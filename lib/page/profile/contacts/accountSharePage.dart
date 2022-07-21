import 'package:encointer_wallet/common/components/wakeLockAndBrightnessEnhancer.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter_fork/qr_flutter_fork.dart';

class AccountSharePage extends StatefulWidget {
  AccountSharePage(this.store);
  static const String route = '/profile/share';
  final AppStore store;
  @override
  _AccountSharePageState createState() => _AccountSharePageState();
}

class _AccountSharePageState extends State<AccountSharePage> {
  @override
  Widget build(BuildContext context) {
    var dic = I18n.of(context)!.translationsForLocale();
    var textTheme = Theme.of(context).textTheme;

    String? accountToBeSharedPubKey = ModalRoute.of(context)!.settings.arguments as String?;
    AccountData accountToBeShared = widget.store.account!.getAccountData(accountToBeSharedPubKey);
    final addressSS58 = widget.store.account!.getNetworkAddress(accountToBeSharedPubKey);

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
            key: Key('close-share-page'),
            icon: Icon(Icons.close),
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
                  SizedBox(height: 16),
                  // Enhance brightness for the QR-code
                  WakeLockAndBrightnessEnhancer(brightness: 1),
                  QrImage(
                    data: contactQrCode.toQrPayload(),
                    embeddedImage: AssetImage('assets/images/public/app.png'),
                    embeddedImageStyle: QrEmbeddedImageStyle(size: Size(40, 40)),
                  ),
                  Text(
                    '${accountToBeShared.name}',
                    style: textTheme.headline3!.copyWith(color: encointerGrey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Spacer(),
              Text(
                dic.profile.shareLinkHint,
                textAlign: TextAlign.center,
                style: textTheme.headline4!.copyWith(color: encointerGrey),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.share, color: ZurichLion.shade500),
                    SizedBox(width: 12),
                    Text(dic.profile.sendLink, style: textTheme.headline3),
                  ],
                ),
                onPressed: () => null, // Todo: use `share_plus` instead of discontinued `share`
                // onPressed: () => Share.share(contactQrCode.toQrPayload()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
