import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/secondaryButtonWide.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/UI.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ContactDetailPage extends StatelessWidget {
  ContactDetailPage(this.store);

  static final String route = '/profile/contactDetail';

  final AppStore store;

  void _removeItem(BuildContext context, AccountData i) {
    var dic = I18n.of(context).translationsForLocale();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(dic.profile.contactDeleteWarn),
          content: Text(Fmt.accountName(context, i)),
          actions: <Widget>[
            CupertinoButton(
              child: Text(dic.home.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoButton(
              child: Text(dic.home.ok),
              onPressed: () {
                Navigator.of(context).pop();
                store.settings.removeContact(i);
                if (i.pubKey == store.account.currentAccountPubKey) {
                  webApi.account.changeCurrentAccount(fetchData: true);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AccountData args = ModalRoute.of(context).settings.arguments;
    var dic = I18n.of(context).translationsForLocale();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.name,
          style: Theme.of(context).textTheme.headline3,
        ),
        iconTheme: IconThemeData(
          color: Color(0xff666666), //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 30),
                    AddressIcon(
                      args.address,
                      size: 130,
                      tapToCopy: true,
                    ),
                    SizedBox(height: 20),
                    // The below is duplicate code of `accountManagePage`, but according to figma the design will
                    // change here.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Fmt.address(args.address), style: TextStyle(fontSize: 20)),
                        IconButton(
                          icon: Icon(Iconsax.copy),
                          color: ZurichLion.shade500,
                          onPressed: () => UI.copyAndNotify(context, args.address),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Row(children: [
                      Text(dic.profile.reputation,
                          style: Theme.of(context).textTheme.headline3.copyWith(color: Color(0xff353535)))
                    ]),
                    SizedBox(height: 32),
                    Row(children: [
                      Text(dic.profile.ceremonies,
                          style: Theme.of(context).textTheme.headline3.copyWith(color: Color(0xff353535)))
                    ]),
                  ],
                ),
              ),
              SecondaryButtonWide(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.send_sqaure_2),
                    SizedBox(width: 12),
                    Text(dic.profile.contactEndorse, style: Theme.of(context).textTheme.headline3)
                  ],
                ),
                onPressed: null, // Todo: #417
              ),
              SizedBox(height: 16),
              SecondaryButtonWide(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.send_sqaure_2),
                    SizedBox(width: 12),
                    Text(dic.profile.tokenSend, style: Theme.of(context).textTheme.headline3)
                  ],
                ),
                onPressed: null, // Todo: #417
              ),
              SizedBox(height: 16),
              SecondaryButtonWide(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.trash),
                      SizedBox(width: 12),
                      Text(dic.profile.contactDelete, style: Theme.of(context).textTheme.headline3)
                    ],
                  ),
                  onPressed: () => _removeItem(context, args),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
