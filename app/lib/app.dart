import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/router/app_router.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class WalletApp extends StatelessWidget {
  const WalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appSettings = context.watch<AppSettings>();
    return GestureDetector(
      key: const Key('metaApp'),
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Observer(builder: (_) {
        return MaterialApp(
          title: 'EncointerWallet',
          locale: context.watch<AppSettings>().locale,
          localizationsDelegates: [
            AppLocalizationsDelegate(appSettings.locale),
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: appSettings.locales,
          initialRoute: SplashView.route,
          theme: appSettings.theme.light,
          scaffoldMessengerKey: rootScaffoldMessengerKey,
          onGenerateRoute: AppRoute.onGenerateRoute,
        );
      }),
    );
  }
}
