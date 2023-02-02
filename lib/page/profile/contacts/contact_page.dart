import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/rounded_button.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/page/qr_scan/qr_scan_page.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  static const String route = '/profile/contact';

  @override
  State<ContactPage> createState() => _Contact();
}

class _Contact extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _memoCtrl = TextEditingController();

  bool? _isObservation = false;

  ContactData? qrScanData;

  bool _submitting = false;

  Future<void> _onSave() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submitting = true;
      });
      final dic = I18n.of(context)!.translationsForLocale();
      final addr = _addressCtrl.text.replaceAll(' ', '');
      final pubKeyAddress = await webApi.account.decodeAddress([addr]);
      final pubKey = pubKeyAddress.keys.toList()[0] as String;
      final con = {
        'address': addr,
        'name': _nameCtrl.text,
        'memo': _memoCtrl.text,
        'observation': _isObservation,
        'pubKey': pubKey,
      };
      setState(() {
        _submitting = false;
      });
      if (qrScanData == null) {
        // create new contact
        final exist = context.read<AppStore>().settings.contactList.indexWhere((i) => i.address == addr);
        if (exist > -1) {
          await showCupertinoDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Container(),
                content: Text(dic.profile.contactAlreadyExists),
                actions: <Widget>[
                  CupertinoButton(
                    child: Text(I18n.of(context)!.translationsForLocale().home.ok),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
          return;
        } else {
          await context.read<AppStore>().settings.addContact(con);
        }
      } else {
        // edit contact
        await context.read<AppStore>().settings.updateContact(con);
      }

      // get contact info
      if (_isObservation!) {
        await webApi.account.encodeAddress([pubKey]);
      } else {
        // if this address was used as observation and current account,
        // we need to change current account
        if (pubKey == context.read<AppStore>().account.currentAccountPubKey) {
          await webApi.account.changeCurrentAccount(fetchData: true);
        }
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _addressCtrl.dispose();
    _nameCtrl.dispose();
    _memoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qrScanData = ModalRoute.of(context)!.settings.arguments as ContactData?;
    final dic = I18n.of(context)!.translationsForLocale();
    if (qrScanData != null) {
      _addressCtrl.text = qrScanData.account;
      _nameCtrl.text = qrScanData.label;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(dic.profile.addressBook),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: TextFormField(
                        key: const Key('contact-address'),
                        decoration: InputDecoration(
                          hintText: dic.profile.contactAddress,
                          labelText: dic.profile.contactAddress,
                        ),
                        controller: _addressCtrl,
                        validator: (v) {
                          if (!Fmt.isAddress(v!.replaceAll(' ', ''))) {
                            return dic.profile.contactAddressError;
                          }
                          return null;
                        },
                        readOnly: qrScanData != null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: TextFormField(
                        key: const Key('contact-name'),
                        decoration: InputDecoration(
                          hintText: dic.profile.contactName,
                          labelText: dic.profile.contactName,
                        ),
                        controller: _nameCtrl,
                        validator: (v) {
                          return v!.trim().isNotEmpty ? null : dic.profile.contactNameError;
                        },
                      ),
                    ),
                    if (context.select<AppStore, bool>((store) => store.settings.developerMode))
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: dic.profile.contactMemo,
                            labelText: dic.profile.contactMemo,
                          ),
                          controller: _memoCtrl,
                        ),
                      ),
                    if (context.select<AppStore, bool>((store) => store.settings.developerMode))
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: _isObservation,
                            onChanged: (v) {
                              setState(() {
                                _isObservation = v;
                              });
                            },
                          ),
                          GestureDetector(
                            child: Text(I18n.of(context)!.translationsForLocale().account.observe),
                            onTap: () {
                              setState(() {
                                _isObservation = !_isObservation!;
                              });
                            },
                          ),
                          Tooltip(
                            triggerMode: TooltipTriggerMode.tap,
                            message: I18n.of(context)!.translationsForLocale().account.observeBrief,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(Icons.info_outline, size: 16),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 24),
                    IconButton(
                      iconSize: 48,
                      icon: const Icon(Iconsax.scan_barcode),
                      onPressed: () => Navigator.of(context).popAndPushNamed(ScanPage.route,
                          arguments: ScanPageParams(scannerContext: QrScannerContext.contactsPage)),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              child: RoundedButton(
                key: const Key('contact-save'),
                submitting: _submitting,
                text: dic.profile.contactSave,
                onPressed: _onSave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
