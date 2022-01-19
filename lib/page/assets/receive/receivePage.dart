import 'package:encointer_wallet/common/components/roundedButton.dart';
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
    if(args != null) {
      isShare = args['isShare'];
    }

    String codeAddress =
        'substrate:${store.account.currentAddress}:${store.account.currentAccount.pubKey}:${store.account.currentAccount.name}';
    Color themeColor = Theme.of(context).primaryColor;

    bool isEncointer = store.settings.endpointIsEncointer;
    final accInfo = store.account.accountIndexMap[store.account.currentAccount.address];
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: isShare ? Text(I18n.of(context).profile['share']) : Text(I18n.of(context).assets['receive']),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 32),
                  child: Image.asset('assets/images/assets/receive_line_${isEncointer ? 'indigo' : 'pink'}.png'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(const Radius.circular(4)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        I18n.of(context).profile['qr.scan.hint'],
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                      ),
                      accInfo != null && accInfo['accountIndex'] != null
                          ? Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(accInfo['accountIndex']),
                            )
                          : Container(width: 8, height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: themeColor),
                          borderRadius: BorderRadius.all(const Radius.circular(8)),
                        ),
                        margin: EdgeInsets.fromLTRB(48, 16, 48, 24),
                        child: QrImage(
                          data: codeAddress,
                          size: 200,
                          embeddedImage: AssetImage('assets/images/public/app.png'),
                          embeddedImageStyle: QrEmbeddedImageStyle(size: Size(40, 40)),
                        ),
                      ),
                      Container(
                        width: 160,
                        child: Text(store.account.currentAddress),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.only(top: 16, bottom: 32),
                        child: isShare
                            ? RoundedButton(
                                text: I18n.of(context).profile['share'], onPressed: () => Share.share(codeAddress))
                            : RoundedButton(
                                text: I18n.of(context).assets['copy'],
                                onPressed: () => UI.copyAndNotify(context, store.account.currentAddress),
                              ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
