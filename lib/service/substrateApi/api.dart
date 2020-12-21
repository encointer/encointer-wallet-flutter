import 'dart:async';
import 'dart:convert';

import 'package:encointer_wallet/common/consts/settings.dart';
import 'package:encointer_wallet/service/subscan.dart';
import 'package:encointer_wallet/service/substrateApi/apiAccount.dart';
import 'package:encointer_wallet/service/substrateApi/apiAssets.dart';
import 'package:encointer_wallet/service/substrateApi/encointer/apiEncointer.dart';
import 'package:encointer_wallet/service/substrateApi/types/genExternalLinksParams.dart';
import 'package:encointer_wallet/service/walletApi.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get_storage/get_storage.dart';

// global api instance
Api webApi;

class Api {
  Api(this.context, this.store);

  final BuildContext context;
  final AppStore store;
  var jsStorage;

  ApiAccount account;

  ApiEncointer encointer;

  ApiAssets assets;

  SubScanApi subScanApi = SubScanApi();

  Map<String, Function> _msgHandlers = {};
  Map<String, Completer> _msgCompleters = {};
  FlutterWebviewPlugin _web;

  int _evalJavascriptUID = 0;

  Function _connectFunc;

  void init() async {
    jsStorage = GetStorage();

    account = ApiAccount(this);

    encointer = ApiEncointer(this);

    assets = ApiAssets(this);

    //ipfs = ApiIpfs(this);

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

  Future<void> _checkJSCodeUpdate() async {
    // check js code update
    final network = store.settings.endpoint.info;
    final jsVersion = await WalletApi.fetchPolkadotJSVersion(network);
    final bool needUpdate = await UI.checkJSCodeUpdate(context, jsVersion, network);
    if (needUpdate) {
      await UI.updateJSCode(context, jsStorage, network, jsVersion);
    }
  }

  void _startJSCode(String js) {
    // inject js file to webview
    _web.evalJavascript(js);

    // load keyPairs from local data
    account.initAccounts();
    // connect remote node
    _connectFunc();
  }

  Future<void> launchWebview({bool customNode = false}) async {
    _msgHandlers = {'txStatusChange': store.account.setTxStatus};

    _evalJavascriptUID = 0;
    _msgCompleters = {};

    _connectFunc = customNode ? connectNode : connectNodeAll;

    if (_web != null) {
      print("reloading webview. close first");
      _web.close();
    }

    _web = FlutterWebviewPlugin();

    _web.onStateChanged.listen((viewState) async {
      if (viewState.type == WebViewState.finishLoad) {
        String network = 'encointer';
        print('webview loaded for network $network');

        DefaultAssetBundle.of(context).loadString('lib/js_service_$network/dist/main.js').then((String js) {
          print('js_service_$network loaded in webview');
          // inject js file to webview
          _web.evalJavascript(js);

          // load keyPairs from local data
          account.initAccounts();
          // connect remote node
          _connectFunc();
        });
      }
    });

    _web.launch(
      'about:blank',
      javascriptChannels: [
        JavascriptChannel(
            name: 'PolkaWallet',
            onMessageReceived: (JavascriptMessage message) {
              print('received msg: ${message.message}');
              compute(jsonDecode, message.message).then((msg) {
                final String path = msg['path'];
                if (_msgCompleters[path] != null) {
                  Completer handler = _msgCompleters[path];
                  handler.complete(msg['data']);
                  if (path.contains('uid=')) {
                    _msgCompleters.remove(path);
                  }
                }
                if (_msgHandlers[path] != null) {
                  Function handler = _msgHandlers[path];
                  handler(msg['data']);
                }
              });
            }),
      ].toSet(),
      ignoreSSLErrors: true,
//      debuggingEnabled: true,
//        withLocalUrl: true,
//        localUrlScope: 'lib/polkadot_js_service/dist/',
      hidden: true,
    );
  }

  int _getEvalJavascriptUID() {
    return _evalJavascriptUID++;
  }

  Future<dynamic> evalJavascript(
    String code, {
    bool wrapPromise = true,
    bool allowRepeat = false,
  }) async {
    // check if there's a same request loading
    if (!allowRepeat) {
      for (String i in _msgCompleters.keys) {
        String call = code.split('(')[0];
        if (i.compareTo(call) == 0) {
          print('request $call loading');
          return _msgCompleters[i].future;
        }
      }
    }

    if (!wrapPromise) {
      String res = await _web.evalJavascript(code);
      return res;
    }

    Completer c = new Completer();

    String method = 'uid=${_getEvalJavascriptUID()};${code.split('(')[0]}';
    _msgCompleters[method] = c;

    String script = '$code.then(function(res) {'
        '  PolkaWallet.postMessage(JSON.stringify({ path: "$method", data: res }));'
        '}).catch(function(err) {'
        '  PolkaWallet.postMessage(JSON.stringify({ path: "log", data: err.message }));'
        '})';
    _web.evalJavascript(script);

    return c.future;
  }

  Future<void> connectNode() async {
    String node = store.settings.endpoint.value;
    // do connect
    String res = await evalJavascript('settings.connect("$node")');
    if (res == null) {
      print('connect failed');
      store.settings.setNetworkName(null);
      return;
    }

    // untested
    if (store.settings.endpoint.info == networkEndpointEncointerCantillon.info) {
      var worker = store.settings.endpoint.worker;
      String res = await evalJavascript('settings.setWorkerEndpoint("$worker")');
    }

    fetchNetworkProps();
  }

  Future<void> connectNodeAll() async {
    List<String> nodes = store.settings.endpointList.map((e) => e.value).toList();
    // do connect
    String res = await evalJavascript('settings.connectAll(${jsonEncode(nodes)})');
    if (res == null) {
      print('connect failed');
      store.settings.setNetworkName(null);
      return;
    }

    // setWorker endpoint on js side
    if (store.settings.endpoint.info == networkEndpointEncointerCantillon.info) {
      var worker = store.settings.endpoint.worker;
      String res = await evalJavascript('settings.setWorkerEndpoint("$worker")');
    }

    int index = store.settings.endpointList.indexWhere((i) => i.value == res);
    if (index < 0) return;
    store.settings.setEndpoint(store.settings.endpointList[index]);
    fetchNetworkProps();
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

    // init subscriptions for all apis
    this.encointer.startSubscriptions();
    this.assets.startSubscriptions();

    // fetch account balance
    if (store.account.accountList.length > 0) {
      await assets.fetchBalance();
    }
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

  Future<String> subscribeBestNumber(Function callback) async {
    final String channel = _getEvalJavascriptUID().toString();
    subscribeMessage('settings.subscribeMessage("chain", "bestNumber", [], "$channel")', channel, callback);
    return channel;
  }

  Future<void> subscribeMessage(
    String code,
    String channel,
    Function callback,
  ) async {
    _msgHandlers[channel] = callback;
    evalJavascript(code, allowRepeat: true);
  }

  Future<void> unsubscribeMessage(String channel) async {
    if (_msgHandlers[channel] != null) {
      _web.evalJavascript('unsub$channel()');
    }
  }

  Future<bool> isConnected() async {
    bool connected = await evalJavascript('settings.isConnected()');
    print("Api is connected: $connected");
    return connected;
  }

  Future<void> closeWebView() async {
    print("closing webview");
    if (_web != null) {
      _web.close();
      _web = null;
    } else {
      print("was null already");
    }
  }

  Future<List> getExternalLinks(GenExternalLinksParams params) async {
    final List res = await evalJavascript(
      'settings.genLinks(${jsonEncode(GenExternalLinksParams.toJson(params))})',
      allowRepeat: true,
    );
    return res;
  }
}
