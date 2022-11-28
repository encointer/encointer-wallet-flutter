import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

class Ipfs {
  // Todo: remove default -> migrate bazaar to use ipfs field from webApi instance
  Ipfs({this.gateway = ipfs_gateway_encointer});

  final String gateway;

  Future<dynamic> getJson(String cid) async {
    try {
      final dio = IpfsDio(BaseOptions(baseUrl: gateway));

      final response = await dio.get<dynamic>(cid);
      var object = Object.fromJson(response.data as Map<String, dynamic>);

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
    } catch (e, s) {
      Log.e('$e', 'Ipfs', s);
      return 0;
    }
  }

  Future<String?> getCommunityIcon(String cid) async {
    if (cid.isEmpty) {
      Log.d('[IPFS] return default encointer icon because ipfs-cid is not set', 'Ipfs');
      return null;
    }

    try {
      final data = await getData(getIconsPath(cid));
      if (data == null) {
        Log.d('[Ipfs] could not find community icon', 'Ipfs');
        return null;
      }

      return data;
    } catch (e, s) {
      Log.e('[Ipfs] error getting communityIcon: $e', 'Ipfs', s);
      return null;
    }
  }

  Future<String?> getData(String src) async {
    final dio = IpfsDio(BaseOptions(baseUrl: gateway, connectTimeout: 5000, receiveTimeout: 3000));

    try {
      final response = await dio.get<dynamic>(src);
      var object = Object.fromJson(response.data as Map<String, dynamic>);

      return object.data;
    } catch (e, s) {
      // otherwise we would have to adjust the return type.
      Log.e('$e', 'Ipfs', s);
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

      final response = await _dio.post<dynamic>('/ipfs/', data: image.openRead());
      String imageHash = response.headers.map['ipfs-hash'].toString(); // [ipfs_hash]

      // TODO: Nicer solution
      // remove surrounding []
      int imageHashBegin = 0;
      int imageHashEnd = imageHash.length - 1;
      if (imageHash[imageHashBegin].compareTo('[') == 0) imageHashBegin++;
      if (imageHash[imageHashEnd].compareTo(']') == 0) imageHashEnd--;
      imageHash = imageHash.substring(imageHashBegin, imageHashEnd + 1);

      return imageHash;
    } catch (e, s) {
      Log.e('Ipfs upload of Image error $e', 'Ipfs', s);
      return '';
    }
  }

  Future<String> uploadJson(Map<String, dynamic> json) async {
    try {
      Dio _dio = Dio();
      _dio.options.baseUrl = gateway;
      _dio.options.connectTimeout = 5000; //5s
      _dio.options.receiveTimeout = 3000;

      final response = await _dio.post<dynamic>('/ipfs/', data: json);
      String jsonHash = response.headers.map['ipfs-hash'].toString(); // [ipfs_hash]

      // TODO: Nicer solution
      // remove surrounding []
      int jsonHashBegin = 0;
      int jsonHashEnd = jsonHash.length - 1;
      if (jsonHash[jsonHashBegin].compareTo('[') == 0) jsonHashBegin++;
      if (jsonHash[jsonHashEnd].compareTo(']') == 0) jsonHashEnd--;
      jsonHash = jsonHash.substring(jsonHashBegin, jsonHashEnd + 1);

      return jsonHash;
    } catch (e, s) {
      Log.e('Ipfs upload of json error $e', 'Ipfs', s);
      return '';
    }
  }
}

const String getRequest = '/api/v0/object/get?arg=';

class IpfsDio {
  IpfsDio([BaseOptions? options]) {
    dio = Dio(options);
  }

  late Dio dio;

  Future<Response<T>> get<T>(String cid) async {
    Log.d('[IPFS] fetching data from: ${dio.options.baseUrl}$getRequest$cid', 'Ipfs');
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
    return Object(data: json['Data'] as String, links: json['Links'] as List<dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'links': links, 'data': data};
}
