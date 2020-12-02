import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:convert' as JSON;
import 'dart:io';

// Mostly taken from import 'package:ipfs/ipfs.dart'; (not working, thus making it myself)
class Ipfs {
  Future getPeers() async {
    try {
      Dio dio = new Dio();
      // returns a json file of Peers
      final response = await dio.get('http://127.0.0.1:5001/api/v0/swarm/peers');
      var data = response.toString();
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
      final response = await Dio()
          .get('http://gateway.pinata.cloud/api/v0/object/get?arg=$cid'); // unschöner gateway -> eigener server?
      print(response.data.toString());
      var data = response.toString();
      var json = JSON.jsonDecode(data);

      var object = Object.fromJson(json);

      var objectData = object.data;

      print(objectData);
      // remove last 3 and first 4 characters (whatever these characters are doing there?
      var objectDataShortened = objectData.substring(5, objectData.length - 3);
      //print(objectDataShortened);

      return objectDataShortened;
    } catch (e) {
      print(e);
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

  factory Object.fromJson(Map<String, dynamic> parsedJson) {
    return Object(data: parsedJson['Data'], links: parsedJson['Links']);
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
