import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter_fork/qr_flutter_fork.dart';
import 'package:share_plus/share_plus.dart';

import 'package:encointer_wallet/common/components/wake_lock_and_brightness_enhancer.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class AccountSharePage extends StatefulWidget {
  const AccountSharePage({super.key});

  static const String route = '/profile/share';

  @override
  State<AccountSharePage> createState() => _AccountSharePageState();
}

class _AccountSharePageState extends State<AccountSharePage> {
  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
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
        title: Text(dic.profile.share),
        leading: Container(),
        actions: [
          IconButton(
            key: const Key('close-share-page'),
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Text(
                    dic.profile.qrScanHintAccount,
                    style: context.textTheme.displayMedium!.copyWith(color: AppColors.encointerBlack),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Enhance brightness for the QR-code
                  const WakeLockAndBrightnessEnhancer(brightness: 1),
                  QrImage(
                    data: contactQrCode.toQrPayload(),
                    embeddedImage: Assets.images.public.app.provider(),
                    embeddedImageStyle: QrEmbeddedImageStyle(size: const Size(40, 40)),
                  ),
                  Text(
                    accountToBeShared.name,
                    style: context.textTheme.displaySmall!.copyWith(color: AppColors.encointerGrey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                dic.profile.shareLinkHint,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineMedium!.copyWith(color: AppColors.encointerGrey),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.share),
                    const SizedBox(width: 12),
                    Text(dic.profile.sendLink, style: context.textTheme.displaySmall),
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
