import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatelessWidget {
  QrCode(
    this.store, {
    @required this.title,
    @required this.qrCodeData,
  });

  final AppStore store;

  final String title;
  final String qrCodeData;

  @override
  Widget build(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(""),
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
                  child: Image.asset('assets/images/assets/receive_line_indigo.png'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(const Radius.circular(4)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: AddressIcon(
                          '',
                          pubKey: store.account.currentAccount.pubKey,
                        ),
                      ),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Container(width: 8, height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: themeColor),
                          borderRadius: BorderRadius.all(const Radius.circular(8)),
                        ),
                        child: QrImage(
                          data: qrCodeData,
                          size: 280,
                          //embeddedImage:
                          //    AssetImage('assets/images/public/app.png'),
                          //embeddedImageStyle:
                          //    QrEmbeddedImageStyle(size: Size(40, 40)),
                        ),
                      ),
                      ButtonBar(children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          child: ElevatedButton(
                            child: Text(I18n.of(context).encointer['done']),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          child: TextButton(
                            child: Row(
                              children: [
                                Text('Scan'),
                                SizedBox(width: 4),
                                Image.asset(
                                  'assets/images/assets/qrcode_indigo.png',
                                  width: 24,
                                ),
                              ],
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ])
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
