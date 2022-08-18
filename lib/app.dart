import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'common/components/will_pop_scope_wrapper.dart';
import 'common/theme.dart';
import 'config.dart';
import 'mocks/storage/mock_local_storage.dart';
import 'mocks/substrate_api/core/mock_dart_api.dart';
import 'mocks/substrate_api/mock_api.dart';
import 'mocks/substrate_api/mock_js_api.dart';
import 'page-encointer/bazaar/0_main/bazaar_main.dart';
import 'page-encointer/home_page.dart';
import 'page/account/create/add_account_page.dart';
import 'page/account/create/create_account_page.dart';
import 'page/account/create/create_pin_page.dart';
import 'page/account/create_account_entry_page.dart';
import 'page/account/import/import_account_page.dart';
import 'page/assets/receive/receive_page.dart';
import 'page/assets/transfer/detail_page.dart';
import 'page/assets/transfer/payment_confirmation_page/index.dart';
import 'page/assets/transfer/transfer_page.dart';
import 'page/network_select_page.dart';
import 'page/profile/about_page.dart';
import 'page/profile/account/account_manage_page.dart';
import 'page/profile/account/change_password_page.dart';
import 'page/profile/account/export_account_page.dart';
import 'page/profile/account/export_result_page.dart';
import 'page/profile/contacts/account_share_page.dart';
import 'page/profile/contacts/contact_detail_page.dart';
import 'page/profile/contacts/contact_list_page.dart';
import 'page/profile/contacts/contact_page.dart';
import 'page/profile/contacts/contacts_page.dart';
import 'page/profile/settings/remote_node_list_page.dart';
import 'page/profile/settings/settings_page.dart';
import 'page/profile/settings/ss58_prefix_list_page.dart';
import 'page/qr_scan/qr_scan_page.dart';
import 'page/reap_voucher/reap_voucher_page.dart';
import 'service/log/log_service.dart';
import 'service/notification.dart';
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
  AppStore? _appStore;
  Locale _locale = const Locale('en', '');
  ThemeData _theme = appThemeEncointer;

  // void _changeTheme() {
  //   // todo: Remove this. It was for the network dependent theme.
  //   // But his can be done at the same time, when we refactor
  //   // the network selection page.
  // }

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

      context.read<AppStore>().localStorage = widget.config.mockLocalStorage ? MockLocalStorage() : LocalStorage();
      // _appStore = widget.config.mockLocalStorage
      //     ? AppStore(MockLocalStorage(), config: widget.config.appStoreConfig)
      //     : AppStore(LocalStorage(), config: widget.config.appStoreConfig);

      // _appStore = context.read<AppStore>();
      Log.p('Initializing app state', 'lib/app.dart');
      Log.p('sys locale: ${Localizations.localeOf(context)}', 'lib/app.dart');
      await context.read<AppStore>().init(Localizations.localeOf(context).toString());

      // init webApi after store initiated
      final jsServiceEncointer =
          await DefaultAssetBundle.of(context).loadString('lib/js_service_encointer/dist/main.js');

      webApi = widget.config.mockSubstrateApi
          ? MockApi(context.read<AppStore>(), MockJSApi(), MockSubstrateDartApi(), jsServiceEncointer, withUi: true)
          : Api.create(context.read<AppStore>(), JSApi(), SubstrateDartApi(), jsServiceEncointer);

      await webApi.init().timeout(
            const Duration(seconds: 20),
            onTimeout: () => Log.p("webApi.init() has run into a timeout. We might be offline.", 'lib/app.dart'),
          );

      context.read<AppStore>().dataUpdate.setupUpdateReaction(() async {
        await context.read<AppStore>().encointer.updateState();
      });

      _changeLang(context, context.read<AppStore>().settings.localeCode);

      context.read<AppStore>().setApiReady(true);
    }
    _appStore = context.read<AppStore>();
    return context.read<AppStore>().account.accountListAll.length;
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
        supportedLocales: const [
          Locale('en', ''),
          Locale('de', ''),
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
                builder: (context) => Observer(
                  // Note: There is a false positive about no observables being inside the observer or we are doing
                  // something wrong. However, for some reason the observer needs to be on top-level to properly
                  // update.
                  builder: (_) => WillPopScopeWrapper(
                    child: FutureBuilder<int>(
                      future: _initApp(context),
                      builder: (_, AsyncSnapshot<int> snapshot) {
                        if (snapshot.hasError) {
                          Log.e("SnapshotError: ${snapshot.error.toString()}", 'lib/app.dart FutureBuilder');
                        }
                        if (snapshot.hasData && _appStore!.appIsReady) {
                          return snapshot.data! > 0 ? const EncointerHomePage() : const CreateAccountEntryPage();
                        } else {
                          return const CupertinoActivityIndicator();
                        }
                      },
                    ),
                  ),
                ),
              );
            case NetworkSelectPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const NetworkSelectPage(),
              );
            case CreateAccountEntryPage.route:
              return CupertinoPageRoute(
                settings: settings,
                fullscreenDialog: true,
                builder: (_) => const CreateAccountEntryPage(),
              );
            case CreateAccountPage.route:
              return CupertinoPageRoute(
                settings: settings,
                fullscreenDialog: true,
                builder: (_) => const CreateAccountPage(),
              );
            case AddAccountPage.route:
              return CupertinoPageRoute(
                settings: settings,
                fullscreenDialog: true,
                builder: (_) => const AddAccountPage(),
              );
            case AccountSharePage.route:
              return CupertinoPageRoute(
                settings: settings,
                fullscreenDialog: true,
                builder: (_) => const AccountSharePage(),
              );
            case CreatePinPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const CreatePinPage(),
              );
            case ImportAccountPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const ImportAccountPage(),
              );
            case ScanPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const ScanPage(),
              );
            case TransferPage.route:
              return CupertinoPageRoute(
                settings: settings,
                fullscreenDialog: true,
                builder: (_) => const TransferPage(),
              );
            case PaymentConfirmationPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const PaymentConfirmationPage(),
              );
            case ReapVoucherPage.route:
              return CupertinoPageRoute(
                settings: settings,
                fullscreenDialog: true,
                builder: (_) => const ReapVoucherPage(),
              );
            case ReceivePage.route:
              return CupertinoPageRoute(
                settings: settings,
                fullscreenDialog: true,
                builder: (_) => const ReceivePage(),
              );
            case TransferDetailPage.route:
              return CupertinoPageRoute(
                settings: settings,
                fullscreenDialog: true,
                builder: (_) => const TransferDetailPage(),
              );
            case AccountManagePage.route:
              return CupertinoPageRoute(
                settings: settings,
                fullscreenDialog: true,
                builder: (_) => const AccountManagePage(),
              );
            case ContactsPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const ContactsPage(),
              );
            case ContactListPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const ContactListPage(),
              );
            case ContactPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const ContactPage(),
              );
            case ChangePasswordPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const ChangePasswordPage(),
              );
            case ContactDetailPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const ContactDetailPage(),
              );
            case SettingsPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => Provider(
                  create: (context) => context.read<AppStore>().settings,
                  child: const SettingsPage(),
                ),
              );
            case ExportAccountPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => Provider(
                  create: (context) => context.read<AppStore>().account,
                  child: ExportAccountPage(),
                ),
              );
            case ExportResultPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const ExportResultPage(),
              );
            case RemoteNodeListPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => Provider(
                  create: (context) => context.read<AppStore>().settings,
                  child: const RemoteNodeListPage(),
                ),
              );
            case SS58PrefixListPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => Provider(
                  create: (context) => context.watch<AppStore>().settings,
                  child: const SS58PrefixListPage(),
                ),
              );
            case AboutPage.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const AboutPage(),
              );
            case BazaarMain.route:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const BazaarMain(),
              );
            default:
              throw Exception('no builder specified for route named: [${settings.name}]');
          }
        },
      ),
    );
  }
}
