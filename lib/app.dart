import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'common/theme.dart';
import 'config.dart';
import 'mocks/storage/mock_local_storage.dart';
import 'mocks/substrate_api/core/mock_dart_api.dart';
import 'mocks/substrate_api/mock_api.dart';
import 'mocks/substrate_api/mock_js_api.dart';
import 'router/app_router.dart';
import 'service/substrate_api/api.dart';
import 'service/substrate_api/core/dart_api.dart';
import 'service/substrate_api/core/js_api.dart';
import 'store/app.dart';
import 'utils/local_storage.dart';
import 'utils/snack_bar.dart';
import 'utils/translations/index.dart';

class WalletApp extends StatefulWidget {
  const WalletApp(this.config);

  final Config config;

  @override
  _WalletAppState createState() => _WalletAppState();
}

class _WalletAppState extends State<WalletApp> {
  late final String jsServiceEncointer;

  Locale _locale = const Locale('en', '');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<AppStore>().localStorage = widget.config.mockLocalStorage ? MockLocalStorage() : LocalStorage();
      jsServiceEncointer = await DefaultAssetBundle.of(context).loadString('lib/js_service_encointer/dist/main.js');
    });
  }

  // void _changeTheme() {
  //   // todo: Remove this. It was for the network dependent theme.
  //   // But his can be done at the same time, when we refactor
  //   // the network selection page.
  // }

  // void _changeLang(BuildContext context, String? code) {
  //   Locale res;
  //   switch (code) {
  //     case 'en':
  //       res = const Locale('en', '');
  //       break;
  //     case 'de':
  //       res = const Locale('de', '');
  //       break;
  //     default:
  //       res = Localizations.localeOf(context);
  //   }
  //   setState(() {
  //     _locale = res;
  //   });
  // }

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
      child: Provider(
        create: (context) => widget.config.mockSubstrateApi
            ? MockApi(context.read<AppStore>(), MockJSApi(), MockSubstrateDartApi(), jsServiceEncointer, withUi: true)
            : Api.create(context.read<AppStore>(), JSApi(), SubstrateDartApi(), jsServiceEncointer),
        child: MaterialApp(
          title: 'EncointerWallet',
          localizationsDelegates: [
            AppLocalizationsDelegate(_locale),
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('de', ''),
          ],
          initialRoute: widget.config.initialRoute,
          theme: appThemeEncointer,
          scaffoldMessengerKey: rootScaffoldMessengerKey,

          // we use onGenerateRoute with CupertinoPageRoute objects to get specific page transition animations (sliding in from the right if there's a back button, sliding from the bottom up if there's a close button)
          // it is preferable to use Navigator.pushNamed (rather than Navigator.push) for large projects
          // cf. CupertinoPageRoute documentation -> fullscreenDialog: true, (in this case the page slides in from the bottom)
          onGenerateRoute: AppRoute.onGenerateRoute,
        ),
      ),
    );
  }
}
