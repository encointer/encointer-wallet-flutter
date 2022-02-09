import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ContactDetailPage extends StatefulWidget {
  ContactDetailPage(this.store);

  static final String route = '/profile/contactDetail';
  final AppStore store;

  @override
  _ContactDetail createState() => _ContactDetail(store);
}

class _ContactDetail extends State<ContactDetailPage> {
  _ContactDetail(this.store);
  final AppStore store;
  AccountData _args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _args = ModalRoute.of(context).settings.arguments;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _removeItem(BuildContext context, AccountData i) {
    var dic = I18n.of(context).profile;
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(dic['contact.delete.warn']),
          content: Text(Fmt.accountName(context, i)),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context).home['cancel']),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoButton(
              child: Text(I18n.of(context).home['ok']),
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
    Map<String, String> dic = I18n.of(context).profile;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _args.name,
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
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                children: <Widget>[
                  SizedBox(height: 30),
                  AddressIcon(
                    _args.address,
                    size: 130,
                    // addressToCopy: address,
                    tapToCopy: false,
                  ),
                  SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(Fmt.address(_args.address),
                        style: Theme.of(context).textTheme.headline3.copyWith(color: Color(0xff353535))),
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(children: [
                      Text(dic['reputation'],
                          style: Theme.of(context).textTheme.headline3.copyWith(color: Color(0xff353535)))
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(children: [
                      Text(dic['ceremonies'],
                          style: Theme.of(context).textTheme.headline3.copyWith(color: Color(0xff353535)))
                    ]),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.send_sqaure_2),
                          SizedBox(width: 12),
                          Text(dic['tokens.send'], style: Theme.of(context).textTheme.headline3)
                        ],
                      ),
                      onPressed: () async => {},
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.trash),
                          SizedBox(width: 12),
                          Text(dic['contact.delete'], style: Theme.of(context).textTheme.headline3)
                        ],
                      ),
                      onPressed: () async => {
                        _removeItem(context, _args),
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
