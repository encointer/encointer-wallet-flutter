import 'package:encointer_wallet/modules/modules.dart';
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
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AppRoute {
  const AppRoute._();

  static const String splash = '/';
  static const String home = '/home';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const EncointerHomePage(),
        );
      case splash:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const SplashView(),
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
          builder: (_) => ScanPage(),
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
  }
}
