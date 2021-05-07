import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:encointer_wallet/config/consts.dart';

const String api_get_req = '/api/v0/object/get?arg=';

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

  Future<String> getCommunityIcons(String cid) async {
    final dio = IpfsDio(BaseOptions(baseUrl: gateway));

    final response = await dio.get(cid)
      .then((r) => Object.fromJson(r.data));
    print("IPFS get response");
    print(response);
    return response.data;
  }

  Future<String> uploadImage(File image) async {
    try {
      Dio _dio = Dio();
      _dio.options.baseUrl = gateway;
      _dio.options.connectTimeout = 5000; //5s
      _dio.options.receiveTimeout = 3000;

      final response = await _dio.post("/ipfs/", data: image.openRead());
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
      print("Ipfs upload of Image error " + e);
      return "";
    }
  }

  Future<String> uploadJson(Map<String, dynamic> json) async {
    try {
      Dio _dio = Dio();
      _dio.options.baseUrl = gateway;
      _dio.options.connectTimeout = 5000; //5s
      _dio.options.receiveTimeout = 3000;

      final response = await _dio.post("/ipfs/", data: json);
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
      print("Ipfs upload of json error " + e);
      return "";
    }
  }
}

class IpfsDio {
  IpfsDio([BaseOptions options]) {
    this.dio = Dio(options);
  }

  Dio dio;

  Future<Response<T>> get<T>(String cid) async {
    final String req = '$api_get_req$cid/icons/community_icon.png';
    print("Ipfs req: $req");
    return dio.get(req);
  }
}

class Object {
  List links;
  //String cid;
  String data;

  Object({
    this.links,
    //this.cid,
    this.data,
  });

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory Object.fromJson(Map<String, dynamic> json) {
    return Object(data: json['Data'], links: json['Links']);
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
    'links': this.links,
    'data': this.data
  };
}
