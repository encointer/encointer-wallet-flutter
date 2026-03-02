import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/modules/settings/logic/app_settings_store.dart';
import 'package:encointer_wallet/page-encointer/bazaar/business_form/business_form_page.dart';
import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:encointer_wallet/page-encointer/bazaar/businesses/logic/businesses_store.dart';
import 'package:encointer_wallet/page-encointer/bazaar/businesses/view/businesses_view.dart';
import 'package:encointer_wallet/page-encointer/bazaar/businesses/widgets/dropdown_widget.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/theme/custom/typography/typography_theme.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
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
      final store = context.read<AppStore>();
      final cid = store.encointer.community?.cid;
      if (cid != null) {
        await context.read<BusinessesStore>().getBusinesses(cid, store.account.currentAddress);
      } else {
        AppAlert.showErrorDialog(
          context,
          errorText: context.l10n.errorMessageNoCommunity,
          buttontext: context.l10n.ok,
        );
      }
    });
  }

  Future<void> _onUploadToIpfs() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Iconsax.camera),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Iconsax.gallery),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null || !mounted) return;

    final picked = await ImagePicker().pickImage(source: source);
    if (picked == null || !mounted) return;

    try {
      final bytes = Uint8List.fromList(await picked.readAsBytes());
      final store = context.read<AppStore>();
      final pubKey = store.account.currentAccountPubKey!;
      final keyPair = store.account.getKeyringAccount(pubKey).pair;
      final address = store.account.currentAddress;
      final communityId = store.encointer.chosenCid!.toFmtString();

      final result = await webApi.ipfsUploadService.uploadBytes(
        bytes: bytes,
        filename: picked.name,
        address: address,
        communityId: communityId,
        keyPair: keyPair,
      );

      if (!mounted) return;

      await showCupertinoDialog<void>(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Upload Successful'),
          content: SelectableText(result.hash),
          actions: [
            CupertinoDialogAction(
              child: const Text('Copy CID'),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: result.hash));
                Navigator.pop(ctx);
              },
            ),
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      AppAlert.showErrorDialog(
        context,
        errorText: e.toString(),
        buttontext: context.l10n.ok,
      );
    }
  }

  void _onAddBusiness() {
    Navigator.of(context).pushNamed(
      BusinessFormPage.route,
      arguments: const BusinessFormParams(),
    );
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
                if (store.encointer.chosenCid != null) ...[
                  if (RepositoryProvider.of<AppSettings>(context).developerMode)
                    IconButton(
                      onPressed: _onUploadToIpfs,
                      icon: const Icon(Iconsax.camera),
                      color: context.colorScheme.secondary,
                      tooltip: 'Upload to IPFS',
                    ),
                  IconButton(
                    key: const Key(EWTestKeys.addBusiness),
                    onPressed: _onAddBusiness,
                    icon: const Icon(Iconsax.add_square),
                    color: context.colorScheme.secondary,
                    tooltip: l10n.addBusiness,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      body: const BusinessesView(),
    );
  }
}
