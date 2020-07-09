import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:polka_wallet/common/consts/settings.dart';
import 'package:polka_wallet/service/substrateApi/encointer/apiEncointer.dart';
import 'package:polka_wallet/service/substrateApi/apiAccount.dart';
import 'package:polka_wallet/service/substrateApi/apiAssets.dart';
import 'package:polka_wallet/service/substrateApi/apiGov.dart';
import 'package:polka_wallet/service/substrateApi/apiStaking.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/store/settings.dart';

// global api instance
Api webApi;

class Api {
  Api(this.context, this.store);

  final BuildContext context;
  final AppStore store;

  ApiAccount account;

  ApiEncointer encointer;

  ApiAssets assets;
  ApiStaking staking;
  ApiGovernance gov;

  Map<String, Function> msgHandlers = {};
  Map<String, Completer> _msgCompleters = {};
  FlutterWebviewPlugin _web;
  int _evalJavascriptUID = 0;

  Function _connectFunc;

  void init() {
    account = ApiAccount(this);

    encointer = ApiEncointer(this);

    assets = ApiAssets(this);
    staking = ApiStaking(this);
    gov = ApiGovernance(this);

    launchWebview();
  }

  Future<void> launchWebview({bool customNode = false}) async {
    msgHandlers = {'txStatusChange': store.account.setTxStatus};

    _evalJavascriptUID = 0;
    _msgCompleters = {};

    _connectFunc = customNode ? connectNode : connectNodeAll;

    if (_web != null) {
      _web.reload();
      return;
    }

    _web = FlutterWebviewPlugin();

    _web.onStateChanged.listen((viewState) async {
      if (viewState.type == WebViewState.finishLoad) {
        String network = 'kusama';

        if (store.settings.endpoint.info.contains('nctr-gsl') ||
            store.settings.endpoint.info.contains('nctr-gsl-dev') ||
            store.settings.endpoint.info.contains('nctr-cln')) {
          network = 'encointer';
        }

        print('webview loaded for network $network');

        DefaultAssetBundle.of(context)
            .loadString('lib/js_service_$network/dist/main.js')
            .then((String js) {
          print('js file loaded');
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
                if (msgHandlers[path] != null) {
                  Function handler = msgHandlers[path];
                  handler(msg['data']);
                }
              });
            }),
      ].toSet(),
      ignoreSSLErrors: true,
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
        if (i.contains(call)) {
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
    List<String> nodes =
        store.settings.endpointList.map((e) => e.value).toList();
    // do connect
    String res =
        await evalJavascript('settings.connectAll(${jsonEncode(nodes)})');
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

    EndpointData connected =
        store.settings.endpointList.firstWhere((i) => i.value == res);
    store.settings.setEndpoint(connected);
    fetchNetworkProps();
  }

  Future<void> fetchNetworkProps() async {
    // fetch network info
    List<dynamic> info = await Future.wait([
      evalJavascript('settings.getNetworkConst()'),
      evalJavascript('api.rpc.system.properties()'),
      evalJavascript('api.rpc.system.chain()'),  // "Development" or "Encointer Testnet Gesell" or whatever
    ]);
    store.settings.setNetworkConst(info[0]);
    store.settings.setNetworkState(info[1]);
    store.settings.setNetworkName(info[2]);

    // fetch account balance
    if (store.account.accountList.length > 0) {
      bool isEncointer = store.settings.endpoint.info ==
          networkEndpointEncointerGesell.info ||
          store.settings.endpoint.info ==
              networkEndpointEncointerGesellDev.info ||
          store.settings.endpoint.info ==
              networkEndpointEncointerCantillon.info;

      if (isEncointer) {
        await assets.fetchBalance(store.account.currentAccount.pubKey);
      } else {
        await Future.wait([
          assets.fetchBalance(store.account.currentAccount.pubKey),
          staking.fetchAccountStaking(store.account.currentAccount.pubKey),
          account.fetchAccountsBonded(
              store.account.accountList.map((i) => i.pubKey).toList()),
        ]);
      }
    }

    // fetch staking overview data as initializing
//    staking.fetchStakingOverview();
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
    String section,
    String method,
    List params,
    String channel,
    Function callback,
  ) async {
    msgHandlers[channel] = callback;
    evalJavascript(
        'settings.subscribeMessage("$section", "$method", ${jsonEncode(params)}, "$channel")');
  }

  Future<void> unsubscribeMessage(String channel) async {
    _web.evalJavascript('unsub$channel()');
  }

  Future<void> closeWebView() async {
    print("closing webview");
    _web.close();
    _web = null;
  }

}
