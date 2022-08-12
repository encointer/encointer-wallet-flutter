import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/secondaryButtonWide.dart';
import 'package:encointer_wallet/common/components/submitButtonSecondary.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/page/assets/transfer/transferPage.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/UI.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ContactDetailPage extends StatelessWidget {
  const ContactDetailPage({Key? key}) : super(key: key);

  static const String route = '/profile/contactDetail';

  void _removeItem(BuildContext context, AccountData account) {
    var dic = I18n.of(context)!.translationsForLocale();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(dic.profile.contactDeleteWarn),
          content: Text(Fmt.accountName(context, account)),
          actions: [
            CupertinoButton(
              child: Text(dic.home.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoButton(
              child: Text(dic.home.ok),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<AppStore>().settings.removeContact(account);
                if (account.pubKey == context.read<AppStore>().account.currentAccountPubKey) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          account.name,
          style: Theme.of(context).textTheme.headline3,
        ),
        iconTheme: const IconThemeData(color: Color(0xff666666)), //change your color here
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
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
                        Text(Fmt.address(account.address)!, style: TextStyle(fontSize: 20)),
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
                if (context.read<AppStore>().encointer.community!.bootstrappers != null) {
                  return context.read<AppStore>().encointer.community!.bootstrappers!.contains(
                            context.read<AppStore>().account.currentAddress,
                          )
                      ? EndorseButton(context.read<AppStore>(), webApi, account)
                      : const SizedBox();
                } else {
                  return const CupertinoActivityIndicator();
                }
              }),
              const SizedBox(height: 16),
              SecondaryButtonWide(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.send_sqaure_2),
                    const SizedBox(width: 12),
                    Text(
                      dic.profile.tokenSend
                          .replaceAll('SYMBOL', context.read<AppStore>().encointer.community?.symbol ?? "null"),
                      style: Theme.of(context).textTheme.headline3,
                    ),
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
                      redirect: '/',
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
  const EndorseButton(
    this.store,
    this.api,
    this.contact, {
    Key? key,
  }) : super(key: key);

  final AppStore store;
  final Api api;
  final AccountData contact;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();

    return SubmitButtonSecondary(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Iconsax.verify),
          const SizedBox(width: 12),
          Text(dic.profile.contactEndorse, style: Theme.of(context).textTheme.headline3)
        ],
      ),
      onPressed: context.read<AppStore>().encointer.community!.bootstrappers!.contains(contact.address)
          ? (BuildContext context) => _popupDialog(context, dic.profile.cantEndorseBootstrapper)
          : context.read<AppStore>().encointer.currentPhase != CeremonyPhase.Registering
              ? (BuildContext context) => _popupDialog(context, dic.profile.canEndorseInRegisteringPhaseOnly)
              : (BuildContext context) => submitEndorseNewcomer(context, context.read<AppStore>(), api,
                  context.read<AppStore>().encointer.chosenCid, contact.address),
    );
  }
}

Future<void> _popupDialog(BuildContext context, String content) async {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const SizedBox(),
        content: Text(content),
        actions: [
          CupertinoButton(
            child: Text(I18n.of(context)!.translationsForLocale().home.ok),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}
