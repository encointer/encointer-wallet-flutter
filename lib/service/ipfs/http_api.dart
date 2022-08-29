import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:encointer_wallet/config/consts.dart';

class Ipfs {
  // Todo: remove default -> migrate bazaar to use ipfs field from webApi instance
  Ipfs({this.gateway = ipfs_gateway_encointer});

  final String gateway;

  Future getJson(String cid) async {
    try {
      final dio = IpfsDio(BaseOptions(baseUrl: gateway));

      final response = await dio.get(cid);
      var object = Object.fromJson(response.data);

      // TODO: Better solution available to remove preceding and trailing characters of json?
      // loop through data string until actual json file begins
      int indexJsonBegin = 0;
      for (int i = 0; i < object.data.length; i++) {
        String currentCharacter = object.data[i];
        if (currentCharacter.compareTo('{') == 0) {
          indexJsonBegin = i;
          break;
        }
      }
      // loop through data string until actual json file ends, beginning at end of string
      int indexJsonEnd = 0;
      for (int i = object.data.length - 1; i >= indexJsonBegin; i--) {
        String currentCharacter = object.data[i];
        if (currentCharacter.compareTo('}') == 0) {
          indexJsonEnd = i;
          break;
        }
      }
      var objectData = object.data.substring(indexJsonBegin, indexJsonEnd + 1);
      return objectData;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<SvgPicture> getCommunityIcon(String? cid) async {
    if (cid == null || cid.isEmpty) {
      print('[IPFS] return default encointer icon because ipfs-cid is not set');
      return SvgPicture.asset(fall_back_community_icon);
    }

    try {
      var data = await getData(getIconsPath(cid));
      if (data == null) {
        print('[Ipfs] could not find community icon');
        return SvgPicture.asset(fall_back_community_icon);
      }

      return SvgPicture.string(data);
    } catch (e) {
      print('[Ipfs] error getting communityIcon: $e');
      return SvgPicture.asset(fall_back_community_icon);
    }
  }

  Future<String?> getData(String src) async {
    final dio = IpfsDio(BaseOptions(baseUrl: gateway, connectTimeout: 5000, receiveTimeout: 3000));

    try {
      final response = await dio.get(src);
      var object = Object.fromJson(response.data);

      return object.data;
    } catch (e) {
      // otherwise we would have to adjust the return type.
      throw (e.toString());
    }
  }

  String getIconsPath(String cid) {
    return '$cid/$community_icon_name';
  }

  Future<String> uploadImage(File image) async {
    try {
      Dio _dio = Dio();
      _dio.options.baseUrl = gateway;
      _dio.options.connectTimeout = 5000; //5s
      _dio.options.receiveTimeout = 3000;

      final response = await _dio.post('/ipfs/', data: image.openRead());
      String imageHash = response.headers.map['ipfs-hash'].toString(); // [ipfs_hash]

      // TODO: Nicer solution
      // remove surrounding []
      int imageHashBegin = 0;
      int imageHashEnd = imageHash.length - 1;
      if (imageHash[imageHashBegin].compareTo('[') == 0) imageHashBegin++;
      if (imageHash[imageHashEnd].compareTo(']') == 0) imageHashEnd--;
      imageHash = imageHash.substring(imageHashBegin, imageHashEnd + 1);

      return imageHash;
    } catch (e) {
      print('Ipfs upload of Image error ${e.toString()}');
      return '';
    }
  }

  Future<String> uploadJson(Map<String, dynamic> json) async {
    try {
      Dio _dio = Dio();
      _dio.options.baseUrl = gateway;
      _dio.options.connectTimeout = 5000; //5s
      _dio.options.receiveTimeout = 3000;

      final response = await _dio.post('/ipfs/', data: json);
      String jsonHash = response.headers.map['ipfs-hash'].toString(); // [ipfs_hash]

      // TODO: Nicer solution
      // remove surrounding []
      int jsonHashBegin = 0;
      int jsonHashEnd = jsonHash.length - 1;
      if (jsonHash[jsonHashBegin].compareTo('[') == 0) jsonHashBegin++;
      if (jsonHash[jsonHashEnd].compareTo(']') == 0) jsonHashEnd--;
      jsonHash = jsonHash.substring(jsonHashBegin, jsonHashEnd + 1);

      return jsonHash;
    } catch (e) {
      print('Ipfs upload of json error ${e.toString()}');
      return '';
    }
  }
}

const String getRequest = '/api/v0/object/get?arg=';

class IpfsDio {
  IpfsDio([BaseOptions? options]) {
    this.dio = Dio(options);
  }

  late Dio dio;

  Future<Response<T>> get<T>(String cid) async {
    print('[IPFS] fetching data from: ${dio.options.baseUrl}$getRequest$cid}');
    return dio.get('$getRequest$cid');
  }
}

class Object {
  List links;
  String data;

  Object({
    required this.links,
    required this.data,
  });

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory Object.fromJson(Map<String, dynamic> json) {
    return Object(data: json['Data'], links: json['Links']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'links': this.links, 'data': this.data};
}
