import 'package:encointer_wallet/modules/modules.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/page-encointer/bazaar/0_main/bazaar_main.dart';
import 'package:encointer_wallet/page-encointer/home_page.dart';
import 'package:encointer_wallet/page/account/create/add_account_page.dart';
import 'package:encointer_wallet/page/account/create/create_account_page.dart';
import 'package:encointer_wallet/page/account/create/create_pin_page.dart';
import 'package:encointer_wallet/page/account/create_account_entry_page.dart';
import 'package:encointer_wallet/page/account/import/import_account_page.dart';
import 'package:encointer_wallet/page/assets/receive/receive_page.dart';
import 'package:encointer_wallet/page/assets/transfer/detail_page.dart';
import 'package:encointer_wallet/page/assets/transfer/payment_confirmation_page/index.dart';
import 'package:encointer_wallet/page/assets/transfer/transfer_page.dart';
import 'package:encointer_wallet/page/network_select_page.dart';
import 'package:encointer_wallet/page/profile/about_page.dart';
import 'package:encointer_wallet/page/profile/account/account_manage_page.dart';
import 'package:encointer_wallet/page/profile/account/change_password_page.dart';
import 'package:encointer_wallet/page/profile/account/export_account_page.dart';
import 'package:encointer_wallet/page/profile/account/export_result_page.dart';
import 'package:encointer_wallet/page/profile/contacts/account_share_page.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_detail_page.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_list_page.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_page.dart';
import 'package:encointer_wallet/page/profile/contacts/contacts_page.dart';
import 'package:encointer_wallet/page/profile/settings/remote_node_list_page.dart';
import 'package:encointer_wallet/page/profile/settings/settings_page.dart';
import 'package:encointer_wallet/page/profile/settings/ss58_prefix_list_page.dart';
import 'package:encointer_wallet/page/qr_scan/qr_scan_page.dart';
import 'package:encointer_wallet/page/reap_voucher/reap_voucher_page.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class WalletApp extends StatefulWidget {
  const WalletApp(this.config, {Key? key}) : super(key: key);

  final Config config;

  @override
  State<WalletApp> createState() => _WalletAppState();
}

class _WalletAppState extends State<WalletApp> {
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

  // Future<int> _initApp(BuildContext context) async {
  //     _changeLang(context, _store.settings.localeCode);
  // }

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
            case SplashView.route:
              return CupertinoPageRoute(
                builder: (_) => SplashView(widget.config.mockLocalStorage),
              );
            case EncointerHomePage.route:
              return CupertinoPageRoute(
                builder: (_) => EncointerHomePage(),
              );
            case NetworkSelectPage.route:
              return CupertinoPageRoute(
                builder: (_) => NetworkSelectPage(_changeTheme),
                settings: settings,
              );
            case CreateAccountEntryPage.route:
              return CupertinoPageRoute(
                builder: (_) => CreateAccountEntryPage(),
                settings: settings,
                fullscreenDialog: true,
              );
            case CreateAccountPage.route:
              return CupertinoPageRoute(
                builder: (_) => const CreateAccountPage(),
                settings: settings,
                fullscreenDialog: true,
              );
            case AddAccountPage.route:
              return CupertinoPageRoute(
                builder: (_) => const AddAccountPage(),
                settings: settings,
                fullscreenDialog: true,
              );
            case AccountSharePage.route:
              return CupertinoPageRoute(
                builder: (_) => AccountSharePage(),
                settings: settings,
                fullscreenDialog: true,
              );
            case CreatePinPage.route:
              return CupertinoPageRoute(
                builder: (_) => const CreatePinPage(),
                settings: settings,
              );
            case ImportAccountPage.route:
              return CupertinoPageRoute(
                builder: (_) => const ImportAccountPage(),
                settings: settings,
              );
            case ScanPage.route:
              return CupertinoPageRoute(
                builder: (_) => ScanPage(),
                settings: settings,
              );
            case TransferPage.route:
              return CupertinoPageRoute(
                builder: (_) => TransferPage(),
                settings: settings,
                fullscreenDialog: true,
              );
            case PaymentConfirmationPage.route:
              return CupertinoPageRoute(
                builder: (_) => PaymentConfirmationPage(webApi),
                settings: settings,
              );
            case ReapVoucherPage.route:
              return CupertinoPageRoute(
                builder: (_) => ReapVoucherPage(webApi),
                settings: settings,
                fullscreenDialog: true,
              );
            case ReceivePage.route:
              return CupertinoPageRoute(
                builder: (_) => ReceivePage(),
                settings: settings,
                fullscreenDialog: true,
              );
            case TransferDetailPage.route:
              return CupertinoPageRoute(
                builder: (_) => TransferDetailPage(),
                settings: settings,
                fullscreenDialog: true,
              );
            case AccountManagePage.route:
              return CupertinoPageRoute(
                builder: (_) => AccountManagePage(),
                settings: settings,
                fullscreenDialog: true,
              );
            case ContactsPage.route:
              return CupertinoPageRoute(
                builder: (_) => ContactsPage(),
                settings: settings,
              );
            case ContactListPage.route:
              return CupertinoPageRoute(
                builder: (_) => ContactListPage(),
                settings: settings,
              );
            case ContactPage.route:
              return CupertinoPageRoute(
                builder: (_) => ContactPage(),
                settings: settings,
              );
            case ChangePasswordPage.route:
              return CupertinoPageRoute(
                builder: (_) => ChangePasswordPage(),
                settings: settings,
              );
            case ContactDetailPage.route:
              return CupertinoPageRoute(
                builder: (_) => ContactDetailPage(webApi),
                settings: settings,
              );
            case SettingsPage.route:
              return CupertinoPageRoute(
                builder: (_) => SettingsPage(_changeLang),
                settings: settings,
              );
            case ExportAccountPage.route:
              return CupertinoPageRoute(
                builder: (_) => ExportAccountPage(),
                settings: settings,
              );
            case ExportResultPage.route:
              return CupertinoPageRoute(
                builder: (_) => ExportResultPage(),
                settings: settings,
              );
            case RemoteNodeListPage.route:
              return CupertinoPageRoute(
                builder: (_) => RemoteNodeListPage(),
                settings: settings,
              );
            case SS58PrefixListPage.route:
              return CupertinoPageRoute(
                builder: (_) => SS58PrefixListPage(),
                settings: settings,
              );
            case AboutPage.route:
              return CupertinoPageRoute(
                builder: (_) => AboutPage(),
                settings: settings,
              );
            case BazaarMain.route:
              return CupertinoPageRoute(
                builder: (_) => BazaarMain(),
                settings: settings,
              );
            default:
              throw Exception('no builder specified for route named: [${settings.name}]');
          }
        },
      ),
    );
  }
}
