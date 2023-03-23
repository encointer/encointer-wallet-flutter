import 'package:encointer_wallet/common/stores/language/app_language_store.dart';
import 'package:encointer_wallet/extras/utils/translations/app_localizations_delegate.dart';
import 'package:encointer_wallet/presentation/splash/ui/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/router/app_router.dart';
import 'package:encointer_wallet/extras/utils/snack_bar.dart';

class EncointerWallet extends StatelessWidget {
  const EncointerWallet({super.key});

  @override
  Widget build(BuildContext context) {
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
        final languageStore = AppLanguageStore();
        return MaterialApp(
          title: 'EncointerWallet',
          locale: languageStore.locale,
          localizationsDelegates: [
            AppLocalizationsDelegate(languageStore.locale),
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: languageStore.locales,
          initialRoute: SplashView.route,
          theme: appThemeEncointer,
          scaffoldMessengerKey: rootScaffoldMessengerKey,
          onGenerateRoute: AppRoute.onGenerateRoute,
        );
      }),
    );
  }
}
