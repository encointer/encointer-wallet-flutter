import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:encointer_wallet/store/account/services/legacy_storage.dart';
import 'package:ew_storage/ew_storage.dart';
import 'package:ew_http/ew_http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/app.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/store/connectivity/connectivity_store.dart';
import 'package:encointer_wallet/service/http_overrides.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/local_storage.dart' as util;

Future<void> main({AppConfig? appConfig, AppSettings? settings}) async {
  late final AppSettings appSettings;
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationPlugin.setup();

  HttpOverrides.global = MyHttpOverrides();
  final pref = await SharedPreferences.getInstance();

  appSettings = settings ?? AppSettings(AppService(pref));

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => EwHttp()),
        RepositoryProvider(create: (context) => appConfig ?? const AppConfig()),
      ],
      child: MultiProvider(
        providers: [
          Provider<AppSettings>(create: (context) => appSettings..init()),
          Provider<ConnectivityStore>(create: (context) => ConnectivityStore(Connectivity())..listen()),
          Provider<AppStore>(
              create: (context) => AppStore(util.LocalStorage(), const SecureStorage(), LegacyLocalStorage())),
          Provider<LoginStore>(
            create: (context) => LoginStore(LoginService(LocalAuthentication(), pref, const SecureStorage())),
          )
        ],
        child: const WalletApp(),
      ),
    ),
  );
}
