import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/components/secondary_button_wide.dart';
import 'package:encointer_wallet/common/components/submit_button_secondary.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/page/assets/transfer/transfer_page.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/l10n/l10.dart';
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
    final l10n = context.l10n;
    final store = context.watch<AppStore>();
    final address = Fmt.ss58Encode(account.pubKey, prefix: store.settings.endpoint.ss58!);
    return Scaffold(
      appBar: AppBar(
        title: isEditing
            ? TextFormField(key: const Key(EWTestKeys.contactNameField), controller: _nameCtrl)
            : Text(_nameCtrl.text),
        actions: [
          if (isEditing)
            IconButton(
              key: const Key(EWTestKeys.contactNameEditCheck),
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
              key: const Key(EWTestKeys.contactNameEdit),
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
                        AddressIcon(address, account.pubKey, size: 130),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // The below is duplicate code of `accountManagePage`, but according to figma the design will
                    // change here.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Fmt.address(address)!, style: const TextStyle(fontSize: 20)),
                        IconButton(
                          icon: const Icon(Iconsax.copy),
                          color: context.colorScheme.secondary,
                          onPressed: () => UI.copyAndNotify(context, address),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              EndorseButton(store, webApi, account),
              const SizedBox(height: 16),
              SecondaryButtonWide(
                key: const Key(EWTestKeys.sendMoneyToAccount),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.send_sqaure_2),
                    const SizedBox(width: 12),
                    Text(
                      l10n.tokenSend(store.encointer.community?.symbol ?? 'null'),
                      style: context.titleLarge.copyWith(color: context.colorScheme.primary),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    TransferPage.route,
                    arguments: TransferPageParams(
                      cid: context.read<AppStore>().encointer.chosenCid,
                      communitySymbol: context.read<AppStore>().encointer.community?.symbol,
                      recipientAddress: address,
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
                    Text(l10n.contactDelete, style: context.titleLarge.copyWith(color: context.colorScheme.primary))
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
    final l10n = context.l10n;
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(l10n.contactDeleteWarn),
          content: Text(Fmt.accountName(context, account)),
          actions: <Widget>[
            CupertinoButton(
              child: Text(l10n.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoButton(
              child: Text(l10n.ok),
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
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Observer(builder: (_) {
          return store.encointer.community!.bootstrappers!.contains(store.account.currentAddress)
              ? FittedBox(
                  child: Row(children: [
                    Text(l10n.remainingNewbieTicketsAsBootStrapper),
                    Text(
                      ' ${store.encointer.communityAccount?.numberOfNewbieTicketsForBootstrapper ?? 0}',
                      style: TextStyle(fontSize: 15, color: context.colorScheme.primary),
                    ),
                  ]),
                )
              : const SizedBox();
        }),
        Observer(builder: (_) {
          return store.encointer.account != null && store.encointer.account!.reputations.isNotEmpty
              ? FittedBox(
                  child: Row(children: [
                    Text(l10n.remainingNewbieTicketsAsReputable),
                    Text(
                      ' ${store.encointer.account?.numberOfNewbieTicketsForReputable ?? 0}',
                      style: TextStyle(fontSize: 15, color: context.colorScheme.primary),
                    ),
                  ]),
                )
              : !store.encointer.community!.bootstrappers!.contains(store.account.currentAddress)
                  ? Text(l10n.onlyReputablesCanEndorseAttendGatheringToBecomeOne)
                  : const SizedBox();
        }),
        const SizedBox(height: 5),
        Observer(builder: (_) {
          return SubmitButtonSecondary(
            key: const Key(EWTestKeys.tapEndorseButton),
            onPressed: hasNewbieTickets() ? onPressed : null,
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.verify),
                  const SizedBox(width: 12),
                  Text(l10n.contactEndorse, style: context.titleLarge.copyWith(color: context.colorScheme.primary))
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
    final l10n = context.l10n;
    final address = Fmt.ss58Encode(contact.pubKey, prefix: store.settings.endpoint.ss58!);

    if (bootstrappers != null && bootstrappers.contains(address)) {
      await _popupDialog(context, l10n.cantEndorseBootstrapper);
    } else if (store.encointer.currentPhase != CeremonyPhase.Registering) {
      await _popupDialog(context, l10n.canEndorseInRegisteringPhaseOnly);
    } else {
      await submitEndorseNewcomer(context, store, api, store.encointer.chosenCid, address);
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
            child: Text(context.l10n.ok),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
