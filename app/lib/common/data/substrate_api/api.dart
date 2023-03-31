import 'dart:async';
import 'dart:convert';

import 'package:encointer_wallet/common/data/ipfs/http_api.dart';
import 'package:encointer_wallet/common/data/substrate_api/account_api.dart';
import 'package:encointer_wallet/common/data/substrate_api/assets_api.dart';
import 'package:encointer_wallet/common/data/substrate_api/chain_api.dart';
import 'package:encointer_wallet/common/data/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/common/data/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/common/data/substrate_api/encointer/encointer_api.dart';
import 'package:encointer_wallet/common/data/substrate_api/encointer/models/gen_external_links_params.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/subscan.dart';
import 'package:encointer_wallet/store/app_store.dart';

const _tag = 'web_api';

/// Global api instance
///
/// `late final` because it will be initialized exactly once in lib/app.dart.
late Api webApi;

class Api {
  Api(
    this.store,
    this.js,
    this.dartApi,
    this.account,
    this.assets,
    this.chain,
    this.encointer,
    this.ipfs,
    this._jsServiceEncointer,
  );

  factory Api.create(
    AppStore store,
    JSApi js,
    SubstrateDartApi dartApi,
    String jsServiceEncointer,
  ) {
    Log.d('Api.create', _tag);
    return Api(
      store,
      js,
      dartApi,
      AccountApi(store, js),
      AssetsApi(store, js),
      ChainApi(store, js),
      EncointerApi(store, js, dartApi),
      Ipfs(gateway: store.settings.ipfsGateway),
      jsServiceEncointer,
    );
  }

  final AppStore store;
  final String _jsServiceEncointer;

  final JSApi js;
  final SubstrateDartApi dartApi;
  final AccountApi account;
  final AssetsApi assets;
  final ChainApi chain;
  final EncointerApi encointer;
  final Ipfs ipfs;

  SubScanApi subScanApi = SubScanApi();

  Future<void> init() async {
    Log.d('init', _tag);
    await dartApi.connect(store.settings.endpoint.value!);

    // need to do this from here as we can't access instance fields in constructor.
    account.setFetchAccountData(fetchAccountData);

    // launch the webView and connect to the endpoint
    await launchWebview();
  }

  Future<void> close() async {
    Log.d('close', _tag);
    await stopSubscriptions();
    await closeWebView();
    await encointer.close();
  }

  Future<void> launchWebview({
    bool customNode = false,
  }) async {
    Log.d('launchWebview: customNode = $customNode', _tag);

    return js.launchWebView(_jsServiceEncointer, () => _postInitCallback(customNode: customNode));
  }

  Future<void> _postInitCallback({
    bool customNode = false,
  }) async {
    Log.d('_postInitCallback: customNode = $customNode', _tag);
    // load keyPairs from local data
    await account.initAccounts();

    if (store.account.currentAddress.isNotEmpty) {
      await store.encointer.initializeUninitializedStores(store.account.currentAddress);
    }
    final connectFunc = customNode ? connectNode : connectNodeAll;
    return connectFunc();
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
    final node = store.settings.endpoint.value;
    final config = store.settings.endpoint.overrideConfig;
    // do connect
    final res = await evalJavascript('settings.connect("$node", "${jsonEncode(config)}")');
    if (res == null) {
      Log.d('connecting to node failed', 'Api');
      store.settings.setNetworkName(null);
      return;
    }

    if (store.settings.endpointIsTeeProxy) {
      final worker = store.settings.endpoint.worker;
      final mrenclave = store.settings.endpoint.mrenclave;
      await evalJavascript('settings.setWorkerEndpoint("$worker", "$mrenclave")');
    }

    await fetchNetworkProps();
  }

  Future<void> connectNodeAll() async {
    final nodes = store.settings.endpointList.map((e) => e.value).toList();
    final configs = store.settings.endpointList.map((e) => e.overrideConfig).toList();
    Log.d('configs: $configs', _tag);

    // do connect
    final res = await evalJavascript('settings.connectAll(${jsonEncode(nodes)}, ${jsonEncode(configs)})');
    if (res == null) {
      Log.d('Connection failed', _tag);
      store.settings.setNetworkName(null);
      return;
    }

    Log.d('Successfully connected: res = $res', _tag);

    // setWorker endpoint on js side
    if (store.settings.endpointIsTeeProxy) {
      final worker = store.settings.endpoint.worker;
      final mrenclave = store.settings.endpoint.mrenclave;
      await evalJavascript('settings.setWorkerEndpoint("$worker", "$mrenclave")');
    }

    final index = store.settings.endpointList.indexWhere((i) => i.value == res);
    if (index < 0) return;
    store.settings.setEndpoint(store.settings.endpointList[index]);
    await fetchNetworkProps();
    Log.d('get community data', 'Api');

    encointer.getCommunityData();
  }

  void fetchAccountData() {
    Log.d('fetchAccountData', _tag);
    assets.fetchBalance();
    encointer.getCommunityData();
  }

  Future<void> fetchNetworkProps() async {
    // fetch network info
    final info = await Future.wait([
      evalJavascript('settings.getNetworkConst()'),
      evalJavascript('api.rpc.system.properties()'),
      evalJavascript('api.rpc.system.chain()'), // "Development" or "Encointer Testnet Gesell" or whatever
    ]);
    await store.settings.setNetworkConst(info[0] as Map<String, dynamic>);
    await store.settings.setNetworkState(info[1] as Map<String, dynamic>);
    store.settings.setNetworkName(info[2] as String?);

    startSubscriptions();
  }

  void startSubscriptions() {
    encointer.startSubscriptions();
    chain.startSubscriptions();
    assets.startSubscriptions();
  }

  Future<void> stopSubscriptions() async {
    Log.d('stopSubscriptions', _tag);
    await encointer.stopSubscriptions();
    await chain.stopSubscriptions();
    await assets.stopSubscriptions();
  }

  Future<void> subscribeMessage(
    String code,
    String channel,
    Function callback,
  ) async {
    Log.d('subscribeMessage', _tag);
    await js.subscribeMessage(code, channel, callback);
  }

  Future<void> unsubscribeMessage(String channel) async {
    Log.d('unsubscribeMessage', _tag);
    await js.unsubscribeMessage(channel);
  }

  Future<bool> isConnected() async {
    final connected = await evalJavascript('settings.isConnected()');
    Log.d('Api is connected: $connected', 'Api');

    return connected as bool;
  }

  Future<void> closeWebView() async {
    Log.d('closeWebView', _tag);
    await stopSubscriptions();
    return js.closeWebView();
  }

  Future<List?> getExternalLinks(GenExternalLinksParams params) async {
    final res = await evalJavascript(
      'settings.genLinks(${jsonEncode(GenExternalLinksParams.toJson(params))})',
    );
    return res as List?;
  }
}
