import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:encointer_wallet/service/log/log.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

const int txListPageSize = 10;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class SubScanRequestParams {
  SubScanRequestParams({
    this.sendPort,
    this.network,
    this.address,
    this.page,
    this.row,
    this.module,
    this.call,
  });

  /// exec in isolate with a message send port
  SendPort? sendPort;

  String? network;
  String? address;
  int? page;
  int? row;
  String? module;
  String? call;
}

class SubScanApi {
  final String moduleBalances = 'Balances';
  final String moduleStaking = 'Staking';
  final String moduleDemocracy = 'Democracy';

  static String getSnEndpoint(String network) {
    var networkScheme = network;
    if (network.contains('polkadot')) {
      networkScheme = 'polkadot';
    }
    if (network.contains('acala')) {
      networkScheme = 'acala-testnet';
    }
    return 'https://$networkScheme.subscan.io/api/scan';
  }

  /// do the request in an isolate to avoid UI stall
  /// in IOS due to https issue: https://github.com/dart-lang/sdk/issues/41519
  Future<Map> fetchTransfersAsync(
    String address,
    int page, {
    String network = 'kusama',
  }) async {
    final Completer completer = Completer<Map>();

    final receivePort = ReceivePort();
    final isolateIns = await Isolate.spawn(
        SubScanApi.fetchTransfers,
        SubScanRequestParams(
          sendPort: receivePort.sendPort,
          network: network,
          address: address,
          page: page,
          row: txListPageSize,
        ));
    receivePort.listen((msg) {
      receivePort.close();
      isolateIns.kill(priority: Isolate.immediate);
      completer.complete(msg);
    });
    return completer.future as FutureOr<Map<dynamic, dynamic>>;
  }

  Future<Map> fetchTxsAsync(
    String module, {
    String? call,
    int page = 0,
    int size = txListPageSize,
    String? sender,
    String network = 'kusama',
  }) async {
    final Completer completer = Completer<Map>();

    final receivePort = ReceivePort();
    final isolateIns = await Isolate.spawn(
        SubScanApi.fetchTxs,
        SubScanRequestParams(
          sendPort: receivePort.sendPort,
          network: network,
          module: module,
          address: sender,
          page: page,
          row: txListPageSize,
        ));
    receivePort.listen((msg) {
      receivePort.close();
      isolateIns.kill(priority: Isolate.immediate);
      completer.complete(msg);
    });
    return completer.future as FutureOr<Map<dynamic, dynamic>>;
  }

  Future<Map> fetchRewardTxsAsync({
    int page = 0,
    int size = txListPageSize,
    String? sender,
    String network = 'kusama',
  }) async {
    final Completer completer = Completer<Map>();

    final receivePort = ReceivePort();
    final isolateIns = await Isolate.spawn(
        SubScanApi.fetchRewardTxs,
        SubScanRequestParams(
          sendPort: receivePort.sendPort,
          network: network,
          address: sender,
          page: page,
          row: txListPageSize,
        ));
    receivePort.listen((msg) {
      receivePort.close();
      isolateIns.kill(priority: Isolate.immediate);
      completer.complete(msg);
    });
    return completer.future as FutureOr<Map<dynamic, dynamic>>;
  }

  static Future<Map?> fetchTransfers(SubScanRequestParams params) async {
    final url = '${getSnEndpoint(params.network!)}/transfers';
    final headers = {'Content-type': 'application/json', 'Accept': '*/*'};
    final body = jsonEncode({
      'page': params.page,
      'row': params.row,
      'address': params.address,
    });
    final res = await post(Uri.parse(url), headers: headers, body: body);
    final obj = await compute(jsonDecode, res.body) as Map<String, dynamic>;
    if (params.sendPort != null) {
      params.sendPort!.send(obj['data']);
    }
    return obj['data'] as Map?;
  }

  static Future<Map?> fetchTxs(SubScanRequestParams para) async {
    final url = '${getSnEndpoint(para.network!)}/extrinsics';
    final headers = {'Content-type': 'application/json'};
    final params = {
      'page': para.page,
      'row': para.row,
      'module': para.module,
    };
    if (para.address != null) {
      params['address'] = para.address;
    }
    if (para.call != null) {
      params['call'] = para.call;
    }
    final body = jsonEncode(params);
    final res = await post(Uri.parse(url), headers: headers, body: body);
    final obj = await compute(jsonDecode, res.body) as Map<String, dynamic>;
    if (para.sendPort != null) {
      para.sendPort!.send(obj['data']);
    }
    return obj['data'] as Map?;
  }

  static Future<Map?> fetchRewardTxs(SubScanRequestParams para) async {
    final url = '${getSnEndpoint(para.network!)}/account/reward_slash';
    final headers = {'Content-type': 'application/json'};
    final params = {
      'address': para.address,
      'page': para.page,
      'row': para.row,
    };
    final body = jsonEncode(params);
    final res = await post(Uri.parse(url), headers: headers, body: body);
    final obj = await compute(jsonDecode, res.body) as Map<String, dynamic>;
    if (para.sendPort != null) {
      para.sendPort!.send(obj['data']);
    }
    return obj['data'] as Map?;
  }

  Future<Map> fetchTokenPriceAsync(String network) async {
    final Completer completer = Completer<Map>();
    final receivePort = ReceivePort();
    final isolateIns = await Isolate.spawn(
        SubScanApi.fetchTokenPrice,
        SubScanRequestParams(
          sendPort: receivePort.sendPort,
          network: network,
        ));
    receivePort.listen((msg) {
      receivePort.close();
      isolateIns.kill(priority: Isolate.immediate);
      completer.complete(msg);
    });
    return completer.future as FutureOr<Map<dynamic, dynamic>>;
  }

  static Future<Map?> fetchTokenPrice(SubScanRequestParams para) async {
    final url = '${getSnEndpoint(para.network!)}/token';
    final headers = {'Content-type': 'application/json'};

    final res = await post(Uri.parse(url), headers: headers);
    try {
      final obj = await compute(jsonDecode, res.body) as Map<String, dynamic>;
      if (para.sendPort != null) {
        para.sendPort!.send(obj['data']);
      }
      return obj['data'] as Map?;
    } catch (e, s) {
      Log.e('$e', 'sunbscan', s);
      // ignore error
    }
    if (para.sendPort != null) {
      para.sendPort!.send({});
    }
    return {};
  }
}
