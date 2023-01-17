import 'dart:async';
import 'dart:convert';

import 'package:encointer_wallet/service/ipfs/http_api.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/subscan.dart';
import 'package:encointer_wallet/service/substrate_api/account_api.dart';
import 'package:encointer_wallet/service/substrate_api/assets_api.dart';
import 'package:encointer_wallet/service/substrate_api/chain_api.dart';
import 'package:encointer_wallet/service/substrate_api/codec_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:encointer_wallet/service/substrate_api/types/gen_external_links_params.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';

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
    this.codec,
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
    return Api(
      store,
      js,
      dartApi,
      AccountApi(js),
      AssetsApi(js),
      ChainApi(js),
      CodecApi(js),
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
  final CodecApi codec;
  final EncointerApi encointer;
  final Ipfs ipfs;

  SubScanApi subScanApi = SubScanApi();

  Future<void> init() async {
    dartApi.connect(store.settings.endpoint.value!);

    // launch the webView and connect to the endpoint
    Log.d('launch the webView', 'Api');

    await launchWebview();
  }

  Future<void> close() async {
    await stopSubscriptions();
    await closeWebView();
    await encointer.close();
  }

  Future<void> launchWebview({bool customNode = false}) async {
    final connectFunc = customNode ? connectNode : connectNodeAll;

    Future<void> postInitCallback() async {
      // load keyPairs from local data
      final keys = await account.initAccounts(
        store.account.accountList,
        store.settings.contactList,
      );

      if (keys != null) store.account.setPubKeyAddressMap(Map<String, Map>.from(keys));

      final contactList = List<AccountData>.of(store.settings.contactList);
      final contacts = List<AccountData>.of(contactList)..retainWhere((i) => i.observation ?? false);
      final observations = contacts.map((i) => i.pubKey).toList();
      if (observations.isNotEmpty) {
        account.encodeAddress(observations);
      }

      if (store.account.currentAddress.isNotEmpty) {
        await store.encointer.initializeUninitializedStores(store.account.currentAddress);
      }

      return connectFunc();
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

    fetchNetworkProps();
  }

  Future<void> connectNodeAll() async {
    final nodes = store.settings.endpointList.map((e) => e.value).toList();
    final configs = store.settings.endpointList.map((e) => e.overrideConfig).toList();
    Log.d('configs: $configs', 'Api');

    // do connect
    final res = await evalJavascript('settings.connectAll(${jsonEncode(nodes)}, ${jsonEncode(configs)})');
    if (res == null) {
      Log.d('connect failed', 'Api');
      store.settings.setNetworkName(null);
      return;
    }

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
    assets.fetchBalance(
      store.account.currentAccountPubKey,
      store.account.currentAddress,
      store.assets.setAccountBalances,
    );
    encointer.getCommunityData();
  }

  Future<void> fetchNetworkProps() async {
    // fetch network info
    final info = await Future.wait([
      evalJavascript('settings.getNetworkConst()'),
      evalJavascript('api.rpc.system.properties()'),
      evalJavascript('api.rpc.system.chain()'), // "Development" or "Encointer Testnet Gesell" or whatever
    ]);
    store.settings.setNetworkConst(info[0] as Map<String, dynamic>);
    store.settings.setNetworkState(info[1] as Map<String, dynamic>);
    store.settings.setNetworkName(info[2] as String?);

    startSubscriptions();
  }

  void startSubscriptions() {
    encointer.startSubscriptions();
    chain.startSubscriptions(store.chain.setLatestHeader);
    assets.startSubscriptions(
      store.account.currentAccountPubKey,
      store.account.currentAddress,
      store.assets.setAccountBalances,
    );
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
    js.subscribeMessage(code, channel, callback);
  }

  Future<void> unsubscribeMessage(String channel) async {
    js.unsubscribeMessage(channel);
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

  Future<List?> getExternalLinks(GenExternalLinksParams params) async {
    final res = await evalJavascript(
      'settings.genLinks(${jsonEncode(GenExternalLinksParams.toJson(params))})',
    );
    return res as List?;
  }

  Future<void> setCurrentAccount(Map<String, dynamic> acc, Map<dynamic, dynamic> res) async {
    store.account.setPubKeyAddressMap(Map<String, Map>.from(res));

    final addresses = <String?>[];
    for (final key in [acc['pubKey'] as String]) {
      addresses.add(store.account.pubKeyAddressMap[store.settings.endpoint.ss58]![key]);
    }

    await store.addAccount(acc, store.account.newAccount.password, addresses[0]);

    final pubKey = acc['pubKey'] as String?;
    store.setCurrentAccount(pubKey);

    await store.loadAccountCache();
  }
}
