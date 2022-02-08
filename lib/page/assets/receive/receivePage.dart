import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    I18n.of(context).profile['qr.scan.hint'],
                    style: Theme.of(context).textTheme.headline3.copyWith(color: encointerBlack),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: ZurichLion.shade50,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.headline2.copyWith(color: encointerBlack),
                    decoration: InputDecoration(
                      labelText: I18n.of(context).assets['invoice.amount'],
                      labelStyle: Theme.of(context).textTheme.headline4,
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      suffixIcon: Text(
                        "ⵐ",
                        style: TextStyle(
                          color: encointerGrey,
                          fontSize: 44,
                        ),
                      ),
                    ),
                    // inputFormatters: [UI.decimalInputFormatter(decimals)],
                    // controller: _amountCtrl,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 8),
            Column(children: [
              Container(
                child: QrImage(
                  data: codeAddress,
                  embeddedImage: AssetImage('assets/images/public/app.png'),
                  embeddedImageStyle: QrEmbeddedImageStyle(size: Size(40, 40)),
                ),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.share, color: ZurichLion.shade500),
                        SizedBox(width: 8),
                        Text(
                          I18n.of(context).assets['share.qr.code'],
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ]),
                ),
                onTap: () => null, // TODO add functionality to share the QR code
              ),
            ])
          ],
        ),
      ),
    );
  }
}
