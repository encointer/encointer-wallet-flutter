import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/page-encointer/bazaar/businesses/logic/businesses_store.dart';
import 'package:encointer_wallet/page-encointer/bazaar/businesses/view/businesses_view.dart';
import 'package:encointer_wallet/page-encointer/bazaar/businesses/widgets/dropdown_widget.dart';
import 'package:encointer_wallet/theme/custom/typography/typography_theme.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_l10n/l10n.dart';

class BazaarPage extends StatefulWidget {
  const BazaarPage({super.key});

  static const String route = '/bazaar';

  @override
  State<BazaarPage> createState() => _BazaarPageState();
}

class _BazaarPageState extends State<BazaarPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cid = context.read<AppStore>().encointer.community?.cid;
      if (cid != null) {
        await context.read<BusinessesStore>().getBusinesses(cid);
      } else {
        AppAlert.showErrorDialog(
          context,
          errorText: context.l10n.errorMessageNoCommunity,
          buttontext: context.l10n.ok,
        );
      }
    });
  }

  Future<void> _onAddBusiness() async {
    final community = context.read<AppStore>().encointer.community!.name;
    final address = context.read<AppStore>().account.currentAddress;
    final subject = Uri.encodeComponent('Request for registering a new business');
    final body = Uri.encodeComponent('''
Dear Encointer Team,

I would like to register a business for my community.

My relevant onchain data is:

Account: $address
community: $community

I am looking forward to your response.
''');

    final mailUri = Uri(
      scheme: 'mailto',
      path: 'bazaar@encointer.org',
      query: 'subject=$subject&body=$body',
    );

    try {
      final launched = await launchUrl(
        mailUri,
        mode: LaunchMode.externalApplication, // ensures OS mail app is used
      );

      if (!launched && context.mounted) {
        AppAlert.showErrorDialog(
          context,
          errorText: context.l10n.emailFailedToOpen,
          buttontext: context.l10n.ok,
        );
      }
    } catch (e) {
      if (context.mounted) {
        AppAlert.showErrorDialog(
          context,
          errorText: context.l10n.emailFailedToOpen,
          buttontext: context.l10n.ok,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = context.read<AppStore>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.acceptancePoints, style: context.headlineSmall),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  l10n.categories,
                  style: context.bodySmall,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: DropdownWidget(),
                ),
                const SizedBox(width: 8),
                if (store.encointer.chosenCid != null)
                  IconButton(
                    onPressed: _onAddBusiness,
                    icon: const Icon(Iconsax.add_square),
                    color: context.colorScheme.secondary,
                    tooltip: l10n.addBusiness,
                  ),
              ],
            ),
          ),
        ),
      ),
      body: const BusinessesView(),
    );
  }
}
