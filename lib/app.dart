import 'package:encointer_wallet/common/components/willPopScopeWrapper.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/mocks/substrate_api/core/mockDartApi.dart';
import 'package:encointer_wallet/mocks/substrate_api/mockJSApi.dart';
import 'package:encointer_wallet/page-encointer/bazaar/0_main/bazaarMain.dart';
import 'package:encointer_wallet/page-encointer/homePage.dart';
import 'package:encointer_wallet/page/account/create/addAccountPage.dart';
import 'package:encointer_wallet/page/account/create/createAccountPage.dart';
import 'package:encointer_wallet/page/account/create/createPinPage.dart';
import 'package:encointer_wallet/page/account/createAccountEntryPage.dart';
import 'package:encointer_wallet/page/account/import/importAccountPage.dart';
import 'package:encointer_wallet/page/assets/receive/receivePage.dart';
import 'package:encointer_wallet/page/assets/transfer/detailPage.dart';
import 'package:encointer_wallet/page/assets/transfer/payment_confirmation_page/index.dart';
import 'package:encointer_wallet/page/assets/transfer/transferPage.dart';
import 'package:encointer_wallet/page/networkSelectPage.dart';
import 'package:encointer_wallet/page/profile/aboutPage.dart';
import 'package:encointer_wallet/page/profile/account/accountManagePage.dart';
import 'package:encointer_wallet/page/profile/account/changePasswordPage.dart';
import 'package:encointer_wallet/page/profile/account/exportAccountPage.dart';
import 'package:encointer_wallet/page/profile/account/exportResultPage.dart';
import 'package:encointer_wallet/page/profile/contacts/accountSharePage.dart';
import 'package:encointer_wallet/page/profile/contacts/contactDetailPage.dart';
import 'package:encointer_wallet/page/profile/contacts/contactListPage.dart';
import 'package:encointer_wallet/page/profile/contacts/contactPage.dart';
import 'package:encointer_wallet/page/profile/contacts/contactsPage.dart';
import 'package:encointer_wallet/page/profile/settings/remoteNodeListPage.dart';
import 'package:encointer_wallet/page/profile/settings/settingsPage.dart';
import 'package:encointer_wallet/page/profile/settings/ss58PrefixListPage.dart';
import 'package:encointer_wallet/page/qr_scan/qrScanPage.dart';
import 'package:encointer_wallet/page/reap_voucher/reapVoucherPage.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/core/dartApi.dart';
import 'package:encointer_wallet/service/substrate_api/core/jsApi.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/localStorage.dart';
import 'package:encointer_wallet/utils/snackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'common/theme.dart';
import 'mocks/storage/mockLocalStorage.dart';
import 'mocks/substrate_api/mockApi.dart';
import 'utils/translations/index.dart';

class WalletApp extends StatefulWidget {
  const WalletApp(this.config);

  final Config config;

  @override
  _WalletAppState createState() => _WalletAppState();
}

class _WalletAppState extends State<WalletApp> {
  AppStore? _appStore;
  Locale _locale = const Locale('en', '');
  ThemeData _theme = appThemeEncointer;

  void _changeTheme() {
    // todo: Remove this. It was for the network dependent theme.
    // But his can be done at the same time, when we refactor
    // the network selection page.
  }

  void _changeLang(BuildContext context, String? code) {
    Locale res;
    switch (code) {
      case 'en':
        res = const Locale('en', '');
        break;
      case 'de':
        res = const Locale('de', '');
        break;
      default:
        res = Localizations.localeOf(context);
    }
    setState(() {
      _locale = res;
    });
  }

  Future<int> _initApp(BuildContext context) async {
    if (_appStore == null) {
      // Todo: Use provider pattern instead of globals, see: https://github.com/encointer/encointer-wallet-flutter/issues/132
      globalAppStore = widget.config.mockLocalStorage
          ? AppStore(MockLocalStorage(), config: widget.config.appStoreConfig)
          : AppStore(LocalStorage(), config: widget.config.appStoreConfig);

      _appStore = globalAppStore;
      _log('Initializing app state');
      _log('sys locale: ${Localizations.localeOf(context)}');
      await _appStore!.init(Localizations.localeOf(context).toString());

      // init webApi after store initiated
      final jsServiceEncointer =
          await DefaultAssetBundle.of(context).loadString('lib/js_service_encointer/dist/main.js');

      webApi = widget.config.mockSubstrateApi
          ? MockApi(_appStore!, MockJSApi(), MockSubstrateDartApi(), jsServiceEncointer, withUi: true)
          : Api.create(_appStore!, JSApi(), SubstrateDartApi(), jsServiceEncointer);

      await webApi.init().timeout(
            Duration(seconds: 20),
            onTimeout: () => print("webApi.init() has run into a timeout. We might be offline."),
          );
      _appStore!.dataUpdate.setupUpdateReaction(() async {
        print('inside update fn');
        await _appStore!.encointer.updateState();
        // return Future.delayed(Duration(seconds: 3));
      });

      _changeLang(context, _appStore!.settings.localeCode);

      _appStore!.setApiReady(true);
    }
    return _appStore!.account.accountListAll.length;
  }

  @protected
  @mustCallSuper
  void reassemble() {
    // this gets executed upon hot-restart or hot-reload only!
    super.reassemble();
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    webApi.close();
    super.dispose();
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
          theme: _theme,
          scaffoldMessengerKey: rootScaffoldMessengerKey,

          // we use onGenerateRoute with CupertinoPageRoute objects to get specific page transition animations (sliding in from the right if there's a back button, sliding from the bottom up if there's a close button)
          // it is preferable to use Navigator.pushNamed (rather than Navigator.push) for large projects
          // cf. CupertinoPageRoute documentation -> fullscreenDialog: true, (in this case the page slides in from the bottom)
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case EncointerHomePage.route:
                return CupertinoPageRoute(
                  settings: settings,
                  builder: (context) => WillPopScopeWrapper(
                    child: Observer(
                      builder: (_) => FutureBuilder<int>(
                        future: _initApp(context),
                        builder: (_, AsyncSnapshot<int> snapshot) {
                          if (snapshot.hasError) {
                            _log("SnapshotError: ${snapshot.error.toString()}");
                          }
                          if (snapshot.hasData && _appStore!.appIsReady) {
                            return snapshot.data! > 0 ? EncointerHomePage(_appStore!) : CreateAccountEntryPage();
                          } else {
                            return CupertinoActivityIndicator();
                          }
                        },
                      ),
                    ),
                  ),
                );
              case NetworkSelectPage.route:
                return CupertinoPageRoute(
                    builder: (_) => NetworkSelectPage(_appStore!, _changeTheme), settings: settings);
              case CreateAccountEntryPage.route:
                return CupertinoPageRoute(
                    builder: (_) => CreateAccountEntryPage(), settings: settings, fullscreenDialog: true);
              case CreateAccountPage.route:
                return CupertinoPageRoute(
                    builder: (_) => CreateAccountPage(_appStore!), settings: settings, fullscreenDialog: true);
              case AddAccountPage.route:
                return CupertinoPageRoute(
                    builder: (_) => AddAccountPage(_appStore!), settings: settings, fullscreenDialog: true);
              case AccountSharePage.route:
                return CupertinoPageRoute(
                    builder: (_) => AccountSharePage(_appStore!), settings: settings, fullscreenDialog: true);
              case CreatePinPage.route:
                return CupertinoPageRoute(builder: (_) => CreatePinPage(_appStore!), settings: settings);
              case ImportAccountPage.route:
                return CupertinoPageRoute(builder: (_) => ImportAccountPage(_appStore!), settings: settings);
              case ScanPage.route:
                return CupertinoPageRoute(builder: (_) => ScanPage(_appStore!), settings: settings);
              case TransferPage.route:
                return CupertinoPageRoute(
                    builder: (_) => TransferPage(_appStore!), settings: settings, fullscreenDialog: true);
              case PaymentConfirmationPage.route:
                return CupertinoPageRoute(
                    builder: (_) => PaymentConfirmationPage(_appStore!, webApi), settings: settings);
              case ReapVoucherPage.route:
                return CupertinoPageRoute(
                    builder: (_) => ReapVoucherPage(_appStore!, webApi), settings: settings, fullscreenDialog: true);
              case ReceivePage.route:
                return CupertinoPageRoute(
                    builder: (_) => ReceivePage(_appStore!), settings: settings, fullscreenDialog: true);
              case TransferDetailPage.route:
                return CupertinoPageRoute(
                    builder: (_) => TransferDetailPage(_appStore!), settings: settings, fullscreenDialog: true);
              case AccountManagePage.route:
                return CupertinoPageRoute(
                    builder: (_) => AccountManagePage(_appStore!), settings: settings, fullscreenDialog: true);
              case ContactsPage.route:
                return CupertinoPageRoute(builder: (_) => ContactsPage(_appStore!), settings: settings);
              case ContactListPage.route:
                return CupertinoPageRoute(builder: (_) => ContactListPage(_appStore!), settings: settings);
              case ContactPage.route:
                return CupertinoPageRoute(builder: (_) => ContactPage(_appStore!), settings: settings);
              case ChangePasswordPage.route:
                return CupertinoPageRoute(builder: (_) => ChangePasswordPage(_appStore!), settings: settings);
              case ContactDetailPage.route:
                return CupertinoPageRoute(builder: (_) => ContactDetailPage(_appStore!, webApi), settings: settings);
              case SettingsPage.route:
                return CupertinoPageRoute(
                    builder: (_) => SettingsPage(_appStore!.settings, _changeLang), settings: settings);
              case ExportAccountPage.route:
                return CupertinoPageRoute(builder: (_) => ExportAccountPage(_appStore!.account), settings: settings);
              case ExportResultPage.route:
                return CupertinoPageRoute(builder: (_) => ExportResultPage(), settings: settings);
              case RemoteNodeListPage.route:
                return CupertinoPageRoute(builder: (_) => RemoteNodeListPage(_appStore!.settings), settings: settings);
              case SS58PrefixListPage.route:
                return CupertinoPageRoute(builder: (_) => SS58PrefixListPage(_appStore!.settings), settings: settings);
              case AboutPage.route:
                return CupertinoPageRoute(builder: (_) => AboutPage(), settings: settings);
              case BazaarMain.route:
                return CupertinoPageRoute(builder: (_) => BazaarMain(_appStore!), settings: settings);
              default:
                throw Exception('no builder specified for route named: [${settings.name}]');
            }
          },
        ));
  }
}

void _log(String msg) {
  print("[App] $msg");
}
