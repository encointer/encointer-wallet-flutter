import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class AccountSharePage extends StatefulWidget {
  AccountSharePage(this.store);
  static final String route = '/profile/share';
  final AppStore store;
  @override
  _AccountSharePageState createState() => _AccountSharePageState();
}

class _AccountSharePageState extends State<AccountSharePage> {
  @override
  Widget build(BuildContext context) {
    var contact = [
      'encointer-contact',
      'V1.0',
      '',
      widget.store.account.currentAccount.address,
      '',
      widget.store.account.currentAccount.name
    ];

    // final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(I18n.of(context).translationsForLocale().profile.share),
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
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: Text(
                      I18n.of(context).translationsForLocale().profile.qrScanHintAccount,
                      style: Theme.of(context).textTheme.headline3.copyWith(color: encointerBlack),
                      textAlign: TextAlign.center,
                    ),
                  ),
              Column(
                children: [
                  Container(
                    child: QrImage(
                      data: contact.join('\n'),
                      embeddedImage: AssetImage('assets/images/public/app.png'),
                      // webApi.ipfs.getCommunityIcon(widget.store.encointer.communityIconsCid, devicePixelRatio).image,
                      embeddedImageStyle: QrEmbeddedImageStyle(size: Size(40, 40)),
                    ),
                  ),
                  Text("Or you can share a link:",
                      style: Theme.of(context).textTheme.headline4.copyWith(color: encointerGrey)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.share, color: ZurichLion.shade500),
                        SizedBox(width: 12),
                        Text(I18n.of(context).translationsForLocale().profile.sendLink,
                            style: Theme.of(context).textTheme.headline3),
                      ],
                    ),
                      onPressed: () => Share.share(contact.join('\n')),
                  ),
                  ],
              ),
            ],
          ),
        ],
          ),
      ),
    );
  }
}
