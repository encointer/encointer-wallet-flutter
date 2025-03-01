import 'package:encointer_wallet/page-encointer/democracy/democracy_page.dart';
import 'package:encointer_wallet/page-encointer/democracy/proposal_page/propose_page.dart';
import 'package:ew_http/ew_http.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page-encointer/bazaar/businesses/logic/businesses_store.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/page/assets/qr_code_printing/widgets/preview_pdf_and_print.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:encointer_wallet/page-encointer/bazaar/bazaar_main.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/presentation/home/views/home_page.dart';
import 'package:encointer_wallet/page/assets/receive/receive_page.dart';
import 'package:encointer_wallet/page/assets/transfer/payment_confirmation_page/index.dart';
import 'package:encointer_wallet/page/assets/transfer/transfer_page.dart';
import 'package:encointer_wallet/page/network_select_page.dart';
import 'package:encointer_wallet/page/profile/about_page.dart';
import 'package:encointer_wallet/page/profile/account/account_manage_page.dart';
import 'package:encointer_wallet/page/profile/account/change_password_page.dart';
import 'package:encointer_wallet/page/profile/account/export_result_page.dart';
import 'package:encointer_wallet/page/profile/contacts/account_share_page.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_detail_page.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_page.dart';
import 'package:encointer_wallet/page/profile/contacts/contacts_page.dart';
import 'package:encointer_wallet/page/qr_scan/qr_scan_page.dart';
import 'package:encointer_wallet/page/reap_voucher/reap_voucher_page.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';

class AppRoute {
  const AppRoute._();

  static const String splash = '/';

  // we use onGenerateRoute with CupertinoPageRoute objects to get specific page transition animations
  // (sliding in from the right if there's a back button, sliding from the bottom up if there's a close button)
  // it is preferable to use Navigator.pushNamed (rather than Navigator.push) for large projects
  // cf. CupertinoPageRoute documentation -> fullscreenDialog: true, (in this case the page slides in from the bottom)
  static Route<void> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case SplashView.route:
        return CupertinoPageRoute(
          builder: (_) => const SplashView(),
        );
      case EncointerHomePage.route:
        return CupertinoPageRoute(
          builder: (_) => const EncointerHomePage(),
        );
      case NetworkSelectPage.route:
        return CupertinoPageRoute(
          builder: (_) => const NetworkSelectPage(),
          settings: settings,
        );
      case CreateAccountEntryView.route:
        return CupertinoPageRoute(
          builder: (_) => const CreateAccountEntryView(),
          settings: settings,
          fullscreenDialog: true,
        );
      case CreateAccountView.route:
        return CupertinoPageRoute(
          builder: (_) => const CreateAccountView(),
          fullscreenDialog: true,
        );
      case AddAccountView.route:
        return CupertinoPageRoute(
          builder: (_) => const AddAccountView(),
          fullscreenDialog: true,
        );
      case AccountSharePage.route:
        return CupertinoPageRoute(
          builder: (_) => const AccountSharePage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case ScanPage.route:
        return CupertinoPageRoute(
          builder: (_) => ScanPage(
            arguments: arguments! as ScanPageParams,
          ),
          settings: settings,
        );
      case TransferPage.route:
        final params = settings.arguments;
        return CupertinoPageRoute(
          builder: (_) => TransferPage(params as TransferPageParams?),
          fullscreenDialog: true,
        );
      case PaymentConfirmationPage.route:
        return CupertinoPageRoute(
          builder: (_) => PaymentConfirmationPage(webApi),
          settings: settings,
        );
      case ReapVoucherPage.route:
        final params = settings.arguments! as ReapVoucherParams;
        return CupertinoPageRoute(
          builder: (_) => ReapVoucherPage(webApi, params.voucher, params.showFundVoucher),
          settings: settings,
          fullscreenDialog: true,
        );
      case ReceivePage.route:
        return CupertinoPageRoute(
          builder: (_) => const ReceivePage(),
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
        final arg = settings.arguments!;
        return CupertinoPageRoute(builder: (_) => ContactDetailPage(arg as AccountData));
      case ExportResultPage.route:
        return CupertinoPageRoute(
          builder: (_) => const ExportResultPage(),
          settings: settings,
        );
      case AboutPage.route:
        return CupertinoPageRoute(
          builder: (_) => const AboutPage(),
          settings: settings,
        );
      case BazaarPage.route:
        return CupertinoPageRoute(
          builder: (_) => Provider(
            create: (context) => BusinessesStore(),
            child: const BazaarPage(),
          ),
          settings: settings,
        );
      case LangPage.route:
        return CupertinoPageRoute(
          builder: (_) => const LangPage(),
          settings: settings,
        );
      case MeetupLocationPage.route:
        return CupertinoPageRoute(
          builder: (_) => MeetupLocationPage(settings.arguments! as MeetupLocationArgs),
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
            create: (context) => TransferHistoryViewStore(
              context.read<AppStore>(),
              RepositoryProvider.of<EwHttp>(context),
            )..getTransfers(),
            child: const TransferHistoryView(),
          ),
        );
      case PreviewPdfAndPrint.route:
        return CupertinoPageRoute(
          builder: (_) => PreviewPdfAndPrint(args: arguments! as PreviewPdfAndPrintArgs),
          settings: settings,
        );
      case DemocracyPage.route:
        return CupertinoPageRoute(builder: (_) => const DemocracyPage(), settings: settings);
      case ProposePage.route:
        return CupertinoPageRoute(builder: (_) => const ProposePage(), settings: settings);
      default:
        throw Exception('no builder specified for route named: [${settings.name}]');
    }
  }
}
