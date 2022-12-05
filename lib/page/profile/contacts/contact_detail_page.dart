import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/components/secondary_button_wide.dart';
import 'package:encointer_wallet/common/components/submit_button_secondary.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/page/assets/transfer/transfer_page.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/ui.dart';

class ContactDetailPage extends StatelessWidget {
  ContactDetailPage(this.api, {Key? key}) : super(key: key);

  static const String route = '/profile/contactDetail';

  final Api api;

  void _removeItem(BuildContext context, AccountData account, AppStore store) {
    final dic = I18n.of(context)!.translationsForLocale();
    showCupertinoDialog<void>(
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
                if (store.account.currentAccountPubKey == account.pubKey) {
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
    final account = ModalRoute.of(context)!.settings.arguments as AccountData;
    final dic = I18n.of(context)!.translationsForLocale();
    final _store = context.watch<AppStore>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          account.name,
          style: Theme.of(context).textTheme.headline3,
        ),
        iconTheme: const IconThemeData(
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
                    const SizedBox(height: 30),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      AddressIcon(
                        account.address,
                        account.pubKey,
                        size: 130,
                        tapToCopy: true,
                      )
                    ]),
                    const SizedBox(height: 20),
                    // The below is duplicate code of `accountManagePage`, but according to figma the design will
                    // change here.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Fmt.address(account.address)!, style: const TextStyle(fontSize: 20)),
                        IconButton(
                          icon: const Icon(Iconsax.copy),
                          color: ZurichLion.shade500,
                          onPressed: () => UI.copyAndNotify(context, account.address),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Observer(builder: (_) {
                return _store.encointer.community!.bootstrappers!.contains(_store.account.currentAddress)
                    ? EndorseButton(_store, api, account)
                    : Container();
              }),
              const SizedBox(height: 16),
              SecondaryButtonWide(
                key: const Key('send-money-to-account'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.send_sqaure_2),
                    const SizedBox(width: 12),
                    Text(dic.profile.tokenSend.replaceAll('SYMBOL', _store.encointer.community?.symbol ?? 'null'),
                        style: Theme.of(context).textTheme.headline3),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    TransferPage.route,
                    arguments: TransferPageParams(
                      cid: context.read<AppStore>().encointer.chosenCid,
                      communitySymbol: context.read<AppStore>().encointer.community?.symbol,
                      recipient: account.address,
                      label: account.name,
                      amount: null,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              SecondaryButtonWide(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.trash),
                    const SizedBox(width: 12),
                    Text(dic.profile.contactDelete, style: Theme.of(context).textTheme.headline3)
                  ],
                ),
                onPressed: () => _removeItem(context, account, context.read<AppStore>()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EndorseButton extends StatelessWidget {
  EndorseButton(this.store, this.api, this.contact, {Key? key}) : super(key: key);

  final AppStore store;
  final Api api;
  final AccountData contact;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();

    return SubmitButtonSecondary(
      key: const Key('tap-endorse-button'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Iconsax.verify),
          const SizedBox(width: 12),
          Text(dic.profile.contactEndorse, style: Theme.of(context).textTheme.headline3)
        ],
      ),
      onPressed: store.encointer.community!.bootstrappers!.contains(contact.address)
          ? (BuildContext context) => _popupDialog(context, dic.profile.cantEndorseBootstrapper)
          : store.encointer.currentPhase != CeremonyPhase.Registering
              ? (BuildContext context) => _popupDialog(context, dic.profile.canEndorseInRegisteringPhaseOnly)
              : (BuildContext context) =>
                  submitEndorseNewcomer(context, store, api, store.encointer.chosenCid, contact.address),
    );
  }
}

Future<void> _popupDialog(BuildContext context, String content) async {
  showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Container(),
        content: Text(content),
        actions: <Widget>[
          CupertinoButton(
            child: Text(I18n.of(context)!.translationsForLocale().home.ok),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
