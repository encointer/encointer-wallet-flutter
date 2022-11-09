import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/router/app_router.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class WalletApp extends StatefulWidget {
  const WalletApp({Key? key}) : super(key: key);

  @override
  State<WalletApp> createState() => _WalletAppState();
}

class _WalletAppState extends State<WalletApp> {
  final Locale _locale = const Locale('en', '');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const Key('metaApp'),
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
        initialRoute: context.watch<AppStore>().config.initialRoute,
        theme: appThemeEncointer,
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        onGenerateRoute: AppRoute.onGenerateRoute,
      ),
    );
  }
}
