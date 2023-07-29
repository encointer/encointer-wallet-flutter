import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/common/components/wake_lock_and_brightness_enhancer.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class AccountSharePage extends StatefulWidget {
  const AccountSharePage({super.key});

  static const String route = '/profile/share';

  @override
  State<AccountSharePage> createState() => _AccountSharePageState();
}

class _AccountSharePageState extends State<AccountSharePage> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = context.watch<AppStore>();

    final accountToBeSharedPubKey = ModalRoute.of(context)!.settings.arguments as String?;
    final accountToBeShared = store.account.getAccountData(accountToBeSharedPubKey);
    final addressSS58 = Fmt.ss58Encode(accountToBeSharedPubKey!, prefix: store.settings.endpoint.ss58!);

    final contactQrCode = ContactQrCode(
      account: addressSS58,
      label: accountToBeShared.name,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(l10n.share),
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            key: const Key(EWTestKeys.closeSharePage),
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            children: [
              Text(
                l10n.qrScanHintAccount,
                style: context.titleLarge.copyWith(color: AppColors.encointerBlack),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Enhance brightness for the QR-code
              const WakeLockAndBrightnessEnhancer(brightness: 1),
              PrettyQr(
                image: Assets.images.public.app.image(height: 40, width: 40).image,
                data: contactQrCode.toQrPayload(),
                size: MediaQuery.of(context).size.width * 0.85,
                typeNumber: 7,
              ),
              const SizedBox(height: 16),
              Text(
                accountToBeShared.name,
                style: context.bodyLarge.copyWith(color: AppColors.encointerGrey),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Text(
                l10n.shareLinkHint,
                textAlign: TextAlign.center,
                style: context.bodyMedium.copyWith(color: AppColors.encointerGrey),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.share),
                    const SizedBox(width: 12),
                    Text(l10n.sendLink, style: context.titleLarge.copyWith(color: context.colorScheme.primary)),
                  ],
                ),
                onPressed: () => Share.share(toDeepLink(contactQrCode.toQrPayload())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
