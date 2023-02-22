import 'package:encointer_wallet/app/presentation/home/ui/views/home_view.dart';
import 'package:encointer_wallet/app/presentation/language/ui/views/language_view.dart';
import 'package:encointer_wallet/common/data/substrate_api/api.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/page-encointer/bazaar/0_main/bazaar_main.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AppRoute {
  const AppRoute._();

  static const String splash = '/';

  // we use onGenerateRoute with CupertinoPageRoute objects to get specific page transition animations
  // (sliding in from the right if there's a back button, sliding from the bottom up if there's a close button)
  // it is preferable to use Navigator.pushNamed (rather than Navigator.push) for large projects
  // cf. CupertinoPageRoute documentation -> fullscreenDialog: true, (in this case the page slides in from the bottom)
  static Route<void> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashView.route:
        return CupertinoPageRoute(
          builder: (_) => const SplashView(),
        );
      case HomeView.route:
        return CupertinoPageRoute(
          builder: (_) => const HomeView(),
        );

      case NetworkSelectPage.route:
        return CupertinoPageRoute(
          builder: (_) => const NetworkSelectPage(),
          settings: settings,
        );
      case CreateAccountEntryPage.route:
        return CupertinoPageRoute(
          builder: (_) => const CreateAccountEntryPage(),
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
          builder: (_) => const AccountSharePage(),
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
          builder: (_) => const TransferPage(),
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
          builder: (_) => const ReceivePage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case TransferDetailPage.route:
        return CupertinoPageRoute(
          builder: (_) => const TransferDetailPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AccountManagePage.route:
        return CupertinoPageRoute(
          builder: (_) => const AccountManagePage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case ContactsPage.route:
        return CupertinoPageRoute(
          builder: (_) => const ContactsPage(),
          settings: settings,
        );
      case ContactListPage.route:
        return CupertinoPageRoute(
          builder: (_) => const ContactListPage(),
          settings: settings,
        );
      case ContactPage.route:
        return CupertinoPageRoute(
          builder: (_) => const ContactPage(),
          settings: settings,
        );
      case ChangePasswordPage.route:
        return CupertinoPageRoute(
          builder: (_) => const ChangePasswordPage(),
          settings: settings,
        );
      case ContactDetailPage.route:
        return CupertinoPageRoute(
          builder: (_) => ContactDetailPage(webApi),
          settings: settings,
        );
      case SettingsPage.route:
        return CupertinoPageRoute(
          builder: (_) => const SettingsPage(),
          settings: settings,
        );
      case ExportAccountPage.route:
        return CupertinoPageRoute(
          builder: (_) => ExportAccountPage(),
          settings: settings,
        );
      case ExportResultPage.route:
        return CupertinoPageRoute(
          builder: (_) => const ExportResultPage(),
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
          builder: (_) => const AboutPage(),
          settings: settings,
        );
      case BazaarMain.route:
        return CupertinoPageRoute(
          builder: (_) => const BazaarMain(),
          settings: settings,
        );
      case Instruction.route:
        return CupertinoPageRoute(
          builder: (_) => const Instruction(),
          settings: settings,
        );
      case LangPage.route:
        return CupertinoPageRoute(
          builder: (_) => const LangPage(),
          settings: settings,
        );
      case LanguageView.route:
        return CupertinoPageRoute(
          builder: (_) => const LanguageView(),
          settings: settings,
        );
      case MeetupLocationPage.route:
        return CupertinoPageRoute(
          builder: (_) => MeetupLocationPage(settings.arguments! as Location),
          settings: settings,
        );
      case CommunityChooserOnMap.route:
        return CupertinoPageRoute(
          builder: (_) => const CommunityChooserOnMap(),
          settings: settings,
        );
      case TransferHistoryView.route:
        return CupertinoPageRoute(
          builder: (_) => Provider(
            create: (context) => TransferHistoryStore()..getTransfers(),
            child: const TransferHistoryView(),
          ),
          settings: settings,
        );

      default:
        throw Exception(
          'no builder specified for route named: [${settings.name}]',
        );
    }
  }
}
