import 'dart:async';
import 'dart:convert';

import 'package:encointer_wallet/config/node.dart';
import 'package:encointer_wallet/service/ipfs/httpApi.dart';
import 'package:encointer_wallet/service/subscan.dart';
import 'package:encointer_wallet/service/substrate_api/accountApi.dart';
import 'package:encointer_wallet/service/substrate_api/assetsApi.dart';
import 'package:encointer_wallet/service/substrate_api/chainApi.dart';
import 'package:encointer_wallet/service/substrate_api/codecApi.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointerApi.dart';
import 'package:encointer_wallet/service/substrate_api/types/genExternalLinksParams.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

import 'core/jsApi.dart';

// global api instance
Api webApi;

class Api {
  Api(this.context, this.store);

  final BuildContext context;
  final AppStore store;
  var jsStorage;

  JSApi js;
  AccountApi account;
  AssetsApi assets;
  ChainApi chain;
  CodecApi codec;
  EncointerApi encointer;
  Ipfs ipfs;

  SubScanApi subScanApi = SubScanApi();

  Future<void> init() async {
    jsStorage = GetStorage();
    js = JSApi();

    account = AccountApi(js, fetchAccountData);
    assets = AssetsApi(js);
    chain = ChainApi(js);
    codec = CodecApi(js);
    encointer = EncointerApi(js);
    ipfs = Ipfs(gateway: store.settings.ipfsGateway);

    print("first launch of webview");
    await launchWebview();

    //TODO: fix this properly!
    // hack to allow hot-restart with re-loaded webview
    // the problem is that hot-restart doesn't call dispose(),
    // so the webview will not be closed properly. Therefore,
    // the first call to launchWebView will crash. The second
    // one seems to succeed
    print("second launch of webview");
    await launchWebview();
  }

  Future<void> launchWebview({bool customNode = false}) async {
    var connectFunc = customNode ? connectNode : connectNodeAll;

    void postInitCallback() {
      // load keyPairs from local data
      account.initAccounts();
      connectFunc();
    }

    js.launchWebView(context, postInitCallback);
  }

  /// Evaluate javascript [code] in the webView.
  ///
  /// If [wrapPromise] is true, evaluation of [code] will directly be awaited and the result is returned.
  /// Otherwise, a future is created and put into the list of pending JS-calls.
  /// If [allowRepeat] is true, a call to the same JS-method can be made repeatedly. Otherwise, subsequent calls will
  /// not have any effect.
  Future<dynamic> evalJavascript(
    String code, {
    bool wrapPromise = true,
    // True is the safe approach; otherwise a crashing (and therefore not returning) JS-call, will prevent subsequent
    // calls to the same method.
    bool allowRepeat = true,
  }) {
    return js.evalJavascript(code, wrapPromise: wrapPromise, allowRepeat: allowRepeat);
  }

  Future<void> connectNode() async {
    String node = store.settings.endpoint.value;
    NodeConfig config = store.settings.endpoint.overrideConfig;
    // do connect
    String res = await evalJavascript('settings.connect("$node", "${jsonEncode(config)}")');
    if (res == null) {
      print('connecting to node failed');
      store.settings.setNetworkName(null);
      return;
    }

    if (store.settings.endpointIsTeeProxy) {
      var worker = store.settings.endpoint.worker;
      var mrenclave = store.settings.endpoint.mrenclave;
      await evalJavascript('settings.setWorkerEndpoint("$worker", "$mrenclave")');
    }

    fetchNetworkProps();
  }

  Future<void> connectNodeAll() async {
    List<String> nodes = store.settings.endpointList.map((e) => e.value).toList();
    List<NodeConfig> configs = store.settings.endpointList.map((e) => e.overrideConfig).toList();
    print("configs: $configs");
    // do connect
    String res = await evalJavascript('settings.connectAll(${jsonEncode(nodes)}, ${jsonEncode(configs)})');
    if (res == null) {
      print('connect failed');
      store.settings.setNetworkName(null);
      return;
    }

    // setWorker endpoint on js side
    if (store.settings.endpointIsTeeProxy) {
      var worker = store.settings.endpoint.worker;
      var mrenclave = store.settings.endpoint.mrenclave;
      await evalJavascript('settings.setWorkerEndpoint("$worker", "$mrenclave")');
    }

    int index = store.settings.endpointList.indexWhere((i) => i.value == res);
    if (index < 0) return;
    store.settings.setEndpoint(store.settings.endpointList[index]);
    await fetchNetworkProps();
    encointer.getCommunityData();
  }

  void fetchAccountData() {
    assets.fetchBalance();
    encointer.getCommunityData();
  }

  Future<void> fetchNetworkProps() async {
    // fetch network info
    List<dynamic> info = await Future.wait([
      evalJavascript('settings.getNetworkConst()'),
      evalJavascript('api.rpc.system.properties()'),
      evalJavascript('api.rpc.system.chain()'), // "Development" or "Encointer Testnet Gesell" or whatever
    ]);
    store.settings.setNetworkConst(info[0]);
    store.settings.setNetworkState(info[1]);
    store.settings.setNetworkName(info[2]);

    startSubscriptions();
  }

  void startSubscriptions() {
    this.encointer.startSubscriptions();
    this.chain.startSubscriptions();
    this.assets.startSubscriptions();
  }

  void stopSubscriptions() {
    this.encointer.stopSubscriptions();
    this.chain.stopSubscriptions();
    this.assets.stopSubscriptions();
  }

  Future<void> updateBlocks(List txs) async {
    Map<int, bool> blocksNeedUpdate = Map<int, bool>();
    txs.forEach((i) {
      int block = i['attributes']['block_id'];
      if (store.assets.blockMap[block] == null) {
        blocksNeedUpdate[block] = true;
      }
    });
    String blocks = blocksNeedUpdate.keys.join(',');
    var data = await evalJavascript('account.getBlockTime([$blocks])');

    store.assets.setBlockMap(data);
  }

  Future<void> subscribeMessage(
    String code,
    String channel,
    Function callback,
  ) async {
    js.subscribeMessage(code, channel, callback);
  }

  Future<void> unsubscribeMessage(String channel) async {
    js.unsubscribeMessage(channel);
  }

  Future<bool> isConnected() async {
    bool connected = await evalJavascript('settings.isConnected()');
    print("Api is connected: $connected");
    return connected;
  }

  Future<void> closeWebView() async {
    stopSubscriptions();
    js.closeWebView();
  }

  Future<List> getExternalLinks(GenExternalLinksParams params) async {
    final List res = await evalJavascript(
      'settings.genLinks(${jsonEncode(GenExternalLinksParams.toJson(params))})',
      allowRepeat: true,
    );
    return res;
  }
}
