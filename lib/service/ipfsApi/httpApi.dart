import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
// import 'dart:io' as io;

class Ipfs {
  // Todo: remove default -> migrate bazaar to use ipfs field from webApi instance
  Ipfs({this.gateway = ipfs_gateway_encointer});

  final String gateway;
  String _dir;
  // String ipfsGateWay = 'http://ipfs.encointer.org:8080/ipfs/QmP2fzfikh7VqTu8pvzd2G2vAd4eK7EaazXTEgqGN6AWoD';

  String infuraGateway = 'https://infura-ipfs.io';

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

  Future<void> _downloadZip(String url, String cid) async {
    var zippedFile = await _downloadFile(url, '$cid.zip');
    await unarchiveAndSave(zippedFile);
  }

  Future<File> _downloadFile(String url, String fileName) async {
    var req = await http.Client().get(Uri.parse(url));
    // var pathToSDCard = await getExternalStorageDirectory();
    // var _dir = pathToSDCard.path;
    // accessing app memory in /data/user/0/org.encointer.wallet/app_flutter/
    if (null == _dir) {
      _dir = (await getApplicationDocumentsDirectory()).path;
    }
    File file2 = File('$_dir/$fileName');
    // bool doesFileExist = await io.File(file2.toString()).exists();
    // if (!doesFileExist) {
    //   return file2.writeAsBytes(req.bodyBytes);
    // }
    // return file2;
    return file2.writeAsBytes(req.bodyBytes);
  }

  unarchiveAndSave(var zippedFile) async {
    var bytes = zippedFile.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);
    for (var file in archive) {
      var fileName = '$_dir/${file.name}';
      if (file.isFile) {
        var outFile = File(fileName);
        print('File: ' + outFile.path);
        outFile = await outFile.create(recursive: true);
      }
    }
  }

  Image getCommunityIcon(String cid, double devicePixelRatio) {
    String communityIconUrl = getCommunityIconsUrl(cid);
    _downloadZip(communityIconUrl, cid);
    // HERE CHECK THAT unarchiveAndSave succeded
    // return Image.file(File('$_dir/${devicePixelRatioToResolution(devicePixelRatio)}community_icon.png'));

    // return Image.network(getCommunityIconsUrl(cid, devicePixelRatio), errorBuilder: (_, error, __) {
    //   print("Image.network error: ${error.toString()}");
    //   return Image.asset('assets/images/assets/ERT.png');
    // });
  }

  String getCommunityIconsUrl(String cid) {
    // return '$gateway/ipfs/$cid/icons/${devicePixelRatioToResolution(devicePixelRatio)}community_icon.png';
    // var zipUrl = 'http://ipfs.encointer.org:8080/ipfs/$cid';
    var zipUrl = '$infuraGateway/ipfs/$cid';
    return zipUrl;
  }

  /// The [ratio] should be obtained via ' MediaQuery.of(context).devicePixelRatio'.
  ///
  /// Internally, Flutter handles asset resolution the same.
  String devicePixelRatioToResolution(double ratio) {
    if (ratio < 0) {
      print("[Error] invalid devicePixelRation returning 1.0x");
      return '';
    } else if (ratio < 1.8) {
      // '1.0x' resolution is on top level.
      return '';
    } else if (ratio < 2.7) {
      return '2.0x/';
    } else {
      return '3.0x/';
    }
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

const String getRequest = '/api/v0/object/get?arg=';

class IpfsDio {
  IpfsDio([BaseOptions options]) {
    this.dio = Dio(options);
  }

  Dio dio;

  Future<Response<T>> get<T>(String cid) async {
    return dio.get('$getRequest$cid');
  }
}

class Object {
  List links;
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

  Map<String, dynamic> toJson() => <String, dynamic>{'links': this.links, 'data': this.data};
}
