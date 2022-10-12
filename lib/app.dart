import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/router/app_router.dart';
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
        navigatorKey: AppRoute.navState,
      ),
    );
  }
}
