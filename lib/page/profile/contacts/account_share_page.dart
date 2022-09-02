import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter_fork/qr_flutter_fork.dart';
import 'package:share_plus/share_plus.dart';

import 'package:encointer_wallet/common/components/wake_lock_and_brightness_enhancer.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class AccountSharePage extends StatefulWidget {
  AccountSharePage({Key? key}) : super(key: key);
  static const String route = '/profile/share';

  @override
  _AccountSharePageState createState() => _AccountSharePageState();
}

class _AccountSharePageState extends State<AccountSharePage> {
  @override
  Widget build(BuildContext context) {
    var dic = I18n.of(context)!.translationsForLocale();
    var textTheme = Theme.of(context).textTheme;
    final _store = context.watch<AppStore>();

    String? accountToBeSharedPubKey = ModalRoute.of(context)!.settings.arguments as String?;
    AccountData accountToBeShared = _store.account.getAccountData(accountToBeSharedPubKey);
    final addressSS58 = _store.account.getNetworkAddress(accountToBeSharedPubKey);

    var contactQrCode = ContactQrCode(
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
                    style: textTheme.headline2!.copyWith(color: encointerBlack),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Enhance brightness for the QR-code
                  const WakeLockAndBrightnessEnhancer(brightness: 1),
                  QrImage(
                    data: contactQrCode.toQrPayload(),
                    embeddedImage: const AssetImage('assets/images/public/app.png'),
                    embeddedImageStyle: QrEmbeddedImageStyle(size: const Size(40, 40)),
                  ),
                  Text(
                    '${accountToBeShared.name}',
                    style: textTheme.headline3!.copyWith(color: encointerGrey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                dic.profile.shareLinkHint,
                textAlign: TextAlign.center,
                style: textTheme.headline4!.copyWith(color: encointerGrey),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.share, color: ZurichLion.shade500),
                    const SizedBox(width: 12),
                    Text(dic.profile.sendLink, style: textTheme.headline3),
                  ],
                ),
                onPressed: () => Share.share(contactQrCode.toQrPayload()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
