import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/mocks/substrate_api/core/mock_dart_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_js_api.dart';
import 'package:encointer_wallet/router/app_router.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class WalletApp extends StatefulWidget {
  const WalletApp(this.config, {Key? key}) : super(key: key);

  final Config config;

  @override
  State<WalletApp> createState() => _WalletAppState();
}

class _WalletAppState extends State<WalletApp> {
  final Locale _locale = const Locale('en', '');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final js = await DefaultAssetBundle.of(context).loadString('lib/js_service_encointer/dist/main.js');
      webApi = (context.read<AppStore>().config == StoreConfig.Test
          ? MockApi(context.read<AppStore>(), MockJSApi(), MockSubstrateDartApi(), js, withUi: true)
          : Api.create(context.read<AppStore>(), JSApi(), SubstrateDartApi(), js))
        ..init().timeout(
          const Duration(seconds: 20),
          onTimeout: () => Log.d('webApi.init() has run into a timeout. We might be offline.'),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
        title: 'EncointerWallet',
        localizationsDelegates: [
          AppLocalizationsDelegate(_locale),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('de', ''),
        ],
        initialRoute: widget.config.initialRoute,
        theme: appThemeEncointer,
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        onGenerateRoute: AppRoute.onGenerateRoute,
      ),
    );
  }
}
