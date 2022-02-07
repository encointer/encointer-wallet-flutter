import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/UI.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class ReceivePage extends StatelessWidget {
  ReceivePage(this.store);
  static final String route = '/assets/receive';
  final AppStore store;
  @override
  Widget build(BuildContext context) {
    bool isShare = false;
    final Map args = ModalRoute.of(context).settings.arguments;
    if (args != null) {
      isShare = args['isShare'];
    }

    String codeAddress =
        'substrate:${store.account.currentAddress}:${store.account.currentAccount.pubKey}:${store.account.currentAccount.name}';
    Color themeColor = Theme.of(context).primaryColor;

    bool isEncointer = store.settings.endpointIsEncointer;
    final accInfo = store.account.accountIndexMap[store.account.currentAccount.address];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: isShare ? Text(I18n.of(context).profile['share']) : Text(I18n.of(context).assets['receive']),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    I18n.of(context).profile['qr.scan.hint'],
                    style: Theme.of(context).textTheme.headline2.copyWith(color: encointerBlack),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child: QrImage(
                    data: codeAddress,
                    embeddedImage: AssetImage('assets/images/public/app.png'),
                    embeddedImageStyle: QrEmbeddedImageStyle(size: Size(40, 40)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// what was this for???:
// accInfo != null && accInfo['accountIndex'] != null
// ? Padding(
// padding: EdgeInsets.all(8),
// child: Text(accInfo['accountIndex']),
// )
// : Container(width: 8, height: 8),
