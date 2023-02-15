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
import 'package:provider/provider.dart';

part 'splash_view_store.g.dart';

class SplashViewStore extends _SplashViewStore with _$SplashViewStore {}

abstract class _SplashViewStore with Store {
  late final AppStore _appStore;

  Future<void> init(BuildContext context, {required String sysLocaleCode}) async {
    _appStore = context.watch<AppStore>();
    await _appStore.init(sysLocaleCode);

    await _initWebApi(context);

    await _setupUpdateReaction();

    _appStore.setApiReady(true);
  }

  AppStore get appStore => _appStore;

  /// Initialize an the webApi instance.
  ///
  /// Currently, `store.init()` must be called before it is passed into the api
  /// due to some cyclic dependencies between webApi <> AppStore.
  Future<void> _initWebApi(BuildContext context) async {
    final js = await JsServices.loadMainJs(context);

    webApi = buildConfig == BuildConfig.unitTest
        ? MockApi(_appStore, MockJSApi(), MockSubstrateDartApi(), js, withUi: true)
        : Api.create(_appStore, JSApi(), SubstrateDartApi(), js);

    await webApi.init().timeout(
          const Duration(seconds: 20),
          onTimeout: () => Log.d('webApi.init() has run into a timeout. We might be offline.'),
        );
  }

  Future<void> _setupUpdateReaction() async {
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
