import 'package:encointer_wallet/common/data/substrate_api/api.dart';
import 'package:encointer_wallet/common/data/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/common/data/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/common/services/js_services/js_services.dart';
import 'package:encointer_wallet/extras/config/build_options.dart';
import 'package:encointer_wallet/mocks/substrate_api/core/mock_dart_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_js_api.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'splash_view_store.g.dart';

const _tag = 'splash_view_store';

class SplashViewStore extends _SplashViewStore with _$SplashViewStore {
  SplashViewStore(super._appStore);
}

abstract class _SplashViewStore with Store {
  _SplashViewStore(this._appStore);

  late final AppStore _appStore;

  @action
  Future<void> init(BuildContext context) async {
    Log.d('init', _tag);
    // _appStore = context.watch<AppStore>();
    await _appStore.init();

    await _initWebApi(context);

    await _setupUpdateReaction();

    _appStore.setApiReady(true);
  }

  @computed
  AppStore get appStore => _appStore;

  /// Initialize an the webApi instance.
  ///
  /// Currently, `store.init()` must be called before it is passed into the api
  /// due to some cyclic dependencies between webApi <> AppStore
  @action
  Future<void> _initWebApi(BuildContext context) async {
    Log.d('_initWebApi', _tag);
    final jsServiceEncointer = await JsServices.loadMainJs(context);

    webApi = buildConfig == BuildConfig.unitTest || !buildConfig.integrationTestConfig.testingRealApp
        ? MockApi(
            _appStore,
            MockJSApi(),
            MockSubstrateDartApi(),
            jsServiceEncointer,
            withUi: true,
          )
        : Api.create(_appStore, JSApi(), SubstrateDartApi(), jsServiceEncointer);

    await webApi.init().timeout(
          const Duration(seconds: 20),
          onTimeout: () => Log.d('webApi.init() has run into a timeout. We might be offline.'),
        );
  }

  @action
  Future<void> _setupUpdateReaction() async {
    Log.d('_setupUpdateReaction', _tag);

    ///TODO(Azamat): Check this method for integration tests
    // We don't poll updates in tests because we mock the backend anyhow.
    if (buildConfig != BuildConfig.unitTest) {
      // must be set after api is initialized.
      _appStore.dataUpdate.setupUpdateReaction(() async {
        await _appStore.encointer.updateState();
      });
    }
  }
}
