import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:convert' as JSON;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/page/account/txConfirmPage.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:image_picker/image_picker.dart';
import 'package:encointer_wallet/service/ipfsApi/httpApi.dart';
import 'dart:io';
import 'package:encointer_wallet/service/substrateApi/api.dart';

// Mostly adopted from import 'package:ipfs/ipfs.dart'; (not working, thus making it myself)
class Ipfs {
  Future getPeers() async {
    try {
      Dio dio = new Dio();
      // returns a json file of Peers
      final response = await dio.get('http://10.0.2.2:8080/api/v0/swarm/peers');
      var data = response.toString();
      print(data);
      var json = JSON.jsonDecode(data);

      var encoder = JsonEncoder.withIndent('  ');
      var prettyprint = encoder.convert(json);

      //Object obj = Object.fromJson(json);
      print(prettyprint);
      //print(obj.data);
      //print(obj.links);
      return prettyprint;
    } catch (e) {
      print(e);
    }
  }

  Future resolveDag(String cid) async {
    try {
      final response = await Dio().get('http://gateway.pinata.cloud/api/v0/object/get?arg=$cid');

      var data = response.toString();
      var json = JSON.jsonDecode(data);

      var encoder = JsonEncoder.withIndent('  ');
      var prettyprint = encoder.convert(json);
      print(prettyprint);
      return json;
    } catch (e) {
      print(e);
    }
  }

  Future getObject(String cid) async {
    try {
      final Dio _dio = Dio();
      //final response = await _dio
      //     .get('http://gateway.pinata.cloud/api/v0/object/get?arg=$cid'); // unschöner gateway -> eigener server?
      final response =
          await _dio.get('http://10.0.2.2:8080/api/v0/object/get?arg=$cid'); // unschöner gateway -> eigener server?
      print(response.toString());
      var object = Object.fromJson(response.data);

      // remove last 3 and first 4 characters (whatever these characters are doing there?)
      var objectDataShortened = object.data.substring(5, object.data.length - 3);

      return objectDataShortened;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<String> uploadImage(File image) async {
    Dio _dio = Dio();

    //_dio.options.baseUrl = "http://10.0.2.2:5001/api/v0";
    _dio.options.connectTimeout = 5000; //5s
    _dio.options.receiveTimeout = 3000;
    // File file = File(image.path);
    final response = await _dio.post("http://10.0.2.2:8080/ipfs/", data: image.openRead());

    print(response.headers.map["location"].toString());
    // return response.data['id'];
    return response.data;
  }

  /*Future uploadObject(File path) async {
    try {
      final Dio _dio = Dio();
      final response = await _dio
          .get('http://gateway.pinata.cloud/api/v0/object/get?arg=$cid'); // unschöner gateway -> eigener server?

      var object = Object.fromJson(response.data);

      // remove last 3 and first 4 characters (whatever these characters are doing there?)
      var objectDataShortened = object.data.substring(5, object.data.length - 3);

      return objectDataShortened;
    } catch (e) {
      print(e);
      return 0;
    }*/

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
