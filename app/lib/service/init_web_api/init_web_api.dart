import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:ew_http/ew_http.dart';
import 'package:flutter/material.dart';

/// Initialize an the webApi instance.
///
/// Currently, `store.init()` must be called before it is passed into the api
/// due to some cyclic dependencies between webApi <> AppStore.
Future<void> initWebApi(BuildContext context, AppStore store) async {
  final js = await DefaultAssetBundle.of(context).loadString(Assets.jsServiceEncointer.dist.main);
  final ewHttp = RepositoryProvider.of<EwHttp>(context);
  final appConfig = RepositoryProvider.of<AppConfig>(context);
  final dartApi = RepositoryProvider.of<SubstrateDartApi>(context);
  webApi = Api.create(store, JSApi(), dartApi, ewHttp, js, isIntegrationTest: appConfig.isIntegrationTest);

  await webApi.init().timeout(
        const Duration(seconds: 20),
        onTimeout: () => Log.d('webApi.init() has run into a timeout. We might be offline.'),
      );
}
