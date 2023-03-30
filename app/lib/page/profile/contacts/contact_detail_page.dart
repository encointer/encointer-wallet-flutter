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

class ContactDetailPage extends StatefulWidget {
  const ContactDetailPage(this.accountData, {super.key});

  static const String route = '/profile/contactDetail';

  final AccountData accountData;

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  late final AccountData account;
  bool isEditing = false;

  @override
  void initState() {
    account = widget.accountData;
    _nameCtrl.text = widget.accountData.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final store = context.watch<AppStore>();
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: isEditing
            ? TextFormField(key: const Key('contact-name-field'), controller: _nameCtrl)
            : Text(_nameCtrl.text, style: textTheme.displaySmall),
        actions: [
          if (isEditing)
            IconButton(
              key: const Key('contact-name-edit-check'),
              icon: const Icon(Icons.check),
              onPressed: () async {
                if (_nameCtrl.text != widget.accountData.name) {
                  final contactData = {
                    'address': widget.accountData.address,
                    'name': _nameCtrl.text,
                    'memo': widget.accountData.memo,
                    'observation': widget.accountData.observation,
                    'pubKey': widget.accountData.pubKey,
                  };
                  await context.read<AppStore>().settings.updateContact(contactData);
                }
                setState(() {
                  isEditing = false;
                });
              },
            )
          else
            IconButton(
              key: const Key('contact-name-edit'),
              icon: const Icon(Iconsax.edit),
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
            )
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AddressIcon(account.address, account.pubKey, size: 130),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // The below is duplicate code of `accountManagePage`, but according to figma the design will
                    // change here.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Fmt.address(account.address)!, style: const TextStyle(fontSize: 20)),
                        IconButton(
                          icon: const Icon(Iconsax.copy),
                          color: zurichLion.shade500,
                          onPressed: () => UI.copyAndNotify(context, account.address),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              EndorseButton(store, webApi, account),
              const SizedBox(height: 16),
              SecondaryButtonWide(
                key: const Key('send-money-to-account'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.send_sqaure_2),
                    const SizedBox(width: 12),
                    Text(
                      dic.profile.tokenSend.replaceAll('SYMBOL', store.encointer.community?.symbol ?? 'null'),
                      style: textTheme.displaySmall,
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
                      label: _nameCtrl.text,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              SecondaryButtonWide(
                onPressed: () => _removeItem(context, account, context.read<AppStore>()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.trash),
                    const SizedBox(width: 12),
                    Text(dic.profile.contactDelete, style: textTheme.displaySmall)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
}

class EndorseButton extends StatelessWidget {
  const EndorseButton(this.store, this.api, this.contact, {super.key});

  final AppStore store;
  final Api api;
  final AccountData contact;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Observer(builder: (_) {
          return store.encointer.community!.bootstrappers!.contains(store.account.currentAddress)
              ? FittedBox(
                  child: Row(children: [
                    Text(dic.encointer.remainingNewbieTicketsAsBootStrapper),
                    Text(
                      ' ${store.encointer.communityAccount?.numberOfNewbieTicketsForBootstrapper ?? 0}',
                      style: TextStyle(color: zurichLion.shade800, fontSize: 15),
                    ),
                  ]),
                )
              : const SizedBox();
        }),
        Observer(builder: (_) {
          return store.encointer.account != null && store.encointer.account!.reputations.isNotEmpty
              ? FittedBox(
                  child: Row(children: [
                    Text(dic.encointer.remainingNewbieTicketsAsReputable),
                    Text(
                      ' ${store.encointer.account?.numberOfNewbieTicketsForReputable ?? 0}',
                      style: TextStyle(color: zurichLion.shade800, fontSize: 15),
                    ),
                  ]),
                )
              : !store.encointer.community!.bootstrappers!.contains(store.account.currentAddress)
                  ? Text(dic.encointer.onlyReputablesCanEndorseAttendGatheringToBecomeOne)
                  : const SizedBox();
        }),
        const SizedBox(height: 5),
        Observer(builder: (_) {
          return SubmitButtonSecondary(
            key: const Key('tap-endorse-button'),
            onPressed: hasNewbieTickets() ? onPressed : null,
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.verify),
                  const SizedBox(width: 12),
                  Text(dic.profile.contactEndorse, style: textTheme.displaySmall)
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  bool hasNewbieTickets() {
    if (store.encointer.account!.reputations.isNotEmpty &&
        store.encointer.account!.numberOfNewbieTicketsForReputable > 0) {
      return true;
    }

    if (store.encointer.community!.bootstrappers!.contains(store.account.currentAddress) &&
        store.encointer.communityAccount!.numberOfNewbieTicketsForBootstrapper > 0) {
      return true;
    }

    return false;
  }

  Future<void> onPressed(BuildContext context) async {
    final community = store.encointer.community;
    final bootstrappers = community?.bootstrappers;
    final dic = I18n.of(context)!.translationsForLocale();
    if (bootstrappers != null && bootstrappers.contains(contact.address)) {
      await _popupDialog(context, dic.profile.cantEndorseBootstrapper);
    } else if (store.encointer.currentPhase != CeremonyPhase.Registering) {
      await _popupDialog(context, dic.profile.canEndorseInRegisteringPhaseOnly);
    } else {
      await submitEndorseNewcomer(context, store, api, store.encointer.chosenCid, contact.address);
    }
  }
}

Future<void> _popupDialog(BuildContext context, String content) async {
  return showCupertinoDialog<void>(
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
