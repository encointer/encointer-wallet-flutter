import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:convert' as JSON;
import 'dart:io';
import 'package:encointer_wallet/common/consts/settings.dart';

class Ipfs {
  Future getJson(String cid) async {
    try {
      final Dio _dio = Dio();
      _dio.options.baseUrl = ipfs_gateway_address;

      final response = await _dio.get('/api/v0/object/get?arg=$cid');
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
      print(objectData);
      return objectData;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      Dio _dio = Dio();
      _dio.options.baseUrl = ipfs_gateway_address;
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
      _dio.options.baseUrl = ipfs_gateway_address;
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

  Future objectStats() async {
    try {
      final response = await Dio()
          .get('http://127.0.0.1:5001/api/v0/object/stat?arg=QmYWquTmxMJbeA6AnAedb5CxaPhW8KyTBVkezfKjJTy5jH');
      var data = response.toString();
      var json = JSON.jsonDecode(data);

      var encoder = JsonEncoder.withIndent('  ');
      var prettyprint = encoder.convert(json);

      print(prettyprint);

      var obj = ObjectStats.fromJson(json);
      print(json.toString());
      print(obj.blockSize);
      print(obj.dataSize);
      print(obj.hash);
      print(obj.numLinks);
    } catch (e) {
      print(e);
    }
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

  factory Object.fromJson(Map<String, dynamic> json) {
    return Object(data: json['Data'], links: json['Links']);
  }
}

class ObjectStats {
  int blockSize;
  int cumulative;
  int dataSize;
  String hash;
  int linkSize;
  int numLinks;

  ObjectStats({this.hash, this.blockSize, this.cumulative, this.dataSize, this.linkSize, this.numLinks});

  factory ObjectStats.fromJson(Map<String, dynamic> parsedJson) {
    return ObjectStats(
        blockSize: parsedJson['BlockSize'],
        cumulative: parsedJson['CumulativeSize'],
        dataSize: parsedJson['DataSize'],
        hash: parsedJson['Hash'],
        linkSize: parsedJson['LinksSize'],
        numLinks: parsedJson['NumLinks']);
  }
}
