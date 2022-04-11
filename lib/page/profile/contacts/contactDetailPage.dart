import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/secondaryButtonWide.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/assets/transfer/transferPage.dart';
import 'package:encointer_wallet/service/js_api_wrappers/api.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/ceremonies.dart';
import 'package:encointer_wallet/utils/UI.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/tx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';

class ContactDetailPage extends StatelessWidget {
  ContactDetailPage(this.store);

  static const String route = '/profile/contactDetail';

  final AppStore store;

  void _removeItem(BuildContext context, AccountData account) {
    var dic = I18n.of(context).translationsForLocale();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(dic.profile.contactDeleteWarn),
          content: Text(Fmt.accountName(context, account)),
          actions: <Widget>[
            CupertinoButton(
              child: Text(dic.home.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoButton(
              child: Text(dic.home.ok),
              onPressed: () {
                Navigator.of(context).pop();
                store.settings.removeContact(account);
                if (account.pubKey == store.account.currentAccountPubKey) {
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
    AccountData account = ModalRoute.of(context).settings.arguments;
    var dic = I18n.of(context).translationsForLocale();

    // Because of caching inconsistency with pre-v1.2.0. It would fetch
    // the bootstrappers together from the cache, but it did not exist before.
    // Todo: remove in the process of: #479
    if (store.encointer.chosenCid != null) webApi.encointer.getBootstrappers();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          account.name,
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
                      account.address,
                      size: 130,
                      tapToCopy: true,
                    ),
                    SizedBox(height: 20),
                    // The below is duplicate code of `accountManagePage`, but according to figma the design will
                    // change here.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Fmt.address(account.address), style: TextStyle(fontSize: 20)),
                        IconButton(
                          icon: Icon(Iconsax.copy),
                          color: ZurichLion.shade500,
                          onPressed: () => UI.copyAndNotify(context, account.address),
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
              Observer(builder: (_) {
                if (store.encointer.bootstrappers != null) {
                  return store.encointer.bootstrappers.contains(store.account.currentAddress)
                      ? EndorseButton(store, account)
                      : Container();
                } else {
                  return CupertinoActivityIndicator();
                }
              }),
              SizedBox(height: 16),
              SecondaryButtonWide(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.send_sqaure_2),
                    SizedBox(width: 12),
                    Text("${dic.profile.tokenSend}", style: Theme.of(context).textTheme.headline3),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    TransferPage.route,
                    arguments: TransferPageParams(
                      cid: store.encointer.chosenCid,
                      communitySymbol: store.encointer.communitySymbol,
                      recipient: account.address,
                      amount: null,
                      redirect: '/',
                    ),
                  );
                },
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
                onPressed: () => _removeItem(context, account),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EndorseButton extends StatelessWidget {
  EndorseButton(this.store, this.contact);

  final AppStore store;
  final AccountData contact;

  @override
  Widget build(BuildContext context) {
    var dic = I18n.of(context).translationsForLocale();

    return SecondaryButtonWide(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.send_sqaure_2),
          SizedBox(width: 12),
          Text(dic.profile.contactEndorse, style: Theme.of(context).textTheme.headline3)
        ],
      ),
      onPressed: store.encointer.bootstrappers.contains(contact.address)
          ? () => _popupDialog(context, dic.profile.cantEndorseBootstrapper)
          : store.encointer.currentPhase != CeremonyPhase.Registering
              ? () => _popupDialog(context, dic.profile.canEndorseInRegisteringPhaseOnly)
              : () => submitEndorseNewcomer(context, store.encointer.chosenCid, contact.address),
    );
  }
}

Future<void> _popupDialog(BuildContext context, String content) async {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Container(),
        content: Text(content),
        actions: <Widget>[
          CupertinoButton(
            child: Text(I18n.of(context).translationsForLocale().home.ok),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
