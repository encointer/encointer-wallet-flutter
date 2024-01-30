import 'dart:async';
import 'dart:convert';

import 'package:ew_http/ew_http.dart';

import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/mocks/ipfs_api.dart';
import 'package:encointer_wallet/service/ipfs/ipfs_api.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/account_api.dart';
import 'package:encointer_wallet/service/substrate_api/assets_api.dart';
import 'package:encointer_wallet/service/substrate_api/chain_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/reconnecting_ws_provider.dart';
import 'package:ew_polkadart/ew_polkadart.dart';

/// Global api instance
///
/// `late final` because it will be initialized exactly once in lib/app.dart.
late Api webApi;

class Api {
  const Api(
    this.store,
    this.js,
    this.provider,
    this.dartApi,
    this.account,
    this.assets,
    this.chain,
    this.encointer,
    this.ipfsApi,
    this._jsServiceEncointer,
  );

  factory Api.create(
    AppStore store,
    JSApi js,
    SubstrateDartApi dartApi,
    EwHttp ewHttp,
    String jsServiceEncointer, {
    bool isIntegrationTest = false,
  }) {
    final provider = ReconnectingWsProvider(Uri.parse(store.settings.endpoint.value!), autoConnect: false);
    return Api(
      store,
      js,
      provider,
      dartApi,
      AccountApi(store, js, provider),
      AssetsApi(store, js, EncointerKusama(provider)),
      ChainApi(store, provider),
      EncointerApi(store, js, dartApi, ewHttp, EncointerKusama(provider)),
      isIntegrationTest ? MockIpfsApi(ewHttp) : IpfsApi(ewHttp, gateway: store.settings.ipfsGateway),
      jsServiceEncointer,
    );
  }

  final AppStore store;
  final String _jsServiceEncointer;

  final JSApi js;
  final ReconnectingWsProvider provider;
  final SubstrateDartApi dartApi;
  final AccountApi account;
  final AssetsApi assets;
  final ChainApi chain;
  final EncointerApi encointer;
  final IpfsApi ipfsApi;

  Future<void> init() async {
    await Future.wait([
      dartApi.connect(store.settings.endpoint.value!),
      provider.connectToNewEndpoint(Uri.parse(store.settings.endpoint.value!)),

      // launch the webView and connect to the endpoint
      launchWebview(),
    ]);

    Log.d('launch the webView', 'Api');

    // need to do this from here as we can't access instance fields in constructor.
    account.setFetchAccountData(fetchAccountData);
  }

  Future<void> close() async {
    final futures = [
      stopSubscriptions(),
      closeWebView(),
      encointer.close(),
      provider.disconnect(),
    ];

    await Future.wait(futures);
  }

  Future<void> launchWebview({
    bool customNode = false,
  }) async {
    final connectFunc = customNode ? connectNode : connectNodeAll;

    Future<void> postInitCallback() async {
      // load keyPairs from local data
      await account.initAccounts();

      if (store.account.currentAddress.isNotEmpty) {
        await store.encointer.initializeUninitializedStores(store.account.currentAddress);
      }

      await connectFunc();
      await Future.wait([
        webApi.encointer.getPhaseDurations(),
        webApi.encointer.getCurrentPhase(),
        webApi.encointer.getNextPhaseTimestamp(),
      ]);
    }

    return js.launchWebView(_jsServiceEncointer, postInitCallback);
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
    // do connect
    final res = await evalJavascript('settings.connect("$node", "{}")');
    if (res == null) {
      Log.d('connecting to node failed', 'Api');
      return;
    }

    if (store.settings.endpointIsTeeProxy) {
      // The JS-implementation used to be here.
      Log.p('Should connect to tee proxy here.');
    }

    await fetchNetworkProps();
  }

  Future<void> connectNodeAll() async {
    final nodes = store.settings.endpointList.map((e) => e.value).toList();

    // do connect
    final res = await evalJavascript('settings.connectAll(${jsonEncode(nodes)}, "[{}]")');
    if (res == null) {
      Log.d('connect failed', 'Api');
      return;
    }

    if (store.settings.endpointIsTeeProxy) {
      // The JS-implementation used to be here.
      Log.p('Should connect to tee proxy here.');
    }

    final index = store.settings.endpointList.indexWhere((i) => i.value == res);
    if (index < 0) return;
    store.settings.setEndpoint(store.settings.endpointList[index]);
    await fetchNetworkProps();
    Log.d('get community data', 'Api');

    encointer.getCommunityData();
  }

  void fetchAccountData() {
    assets.fetchBalance();
    encointer.getCommunityData();
  }

  Future<void> fetchNetworkProps() async {
    startSubscriptions();
  }

  void startSubscriptions() {
    encointer.startSubscriptions();
    chain.startSubscriptions();
    assets.startSubscriptions();
  }

  Future<void> stopSubscriptions() async {
    await encointer.stopSubscriptions();
    await chain.stopSubscriptions();
    await assets.stopSubscriptions();
  }

  Future<void> subscribeMessage(
    String code,
    String channel,
    Function callback,
  ) async {
    await js.subscribeMessage(code, channel, callback);
  }

  Future<void> unsubscribeMessage(String channel) async {
    await js.unsubscribeMessage(channel);
  }

  Future<bool> isConnected() async {
    final connected = await evalJavascript('settings.isConnected()');
    Log.d('Api is connected: $connected', 'Api');

    return connected as bool;
  }

  Future<void> closeWebView() async {
    await stopSubscriptions();
    return js.closeWebView();
  }
}
