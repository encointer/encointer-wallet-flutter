import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  static const String route = '/profile/password';

  @override
  State<ChangePasswordPage> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePasswordPage> {
  final Api api = webApi;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passOldCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _pass2Ctrl = TextEditingController();

  bool _submitting = false;

  Future<void> _onSave(AppStore store) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submitting = true;
      });

      final l10n = context.l10n;
      final passOld = _passOldCtrl.text.trim();
      final passNew = _passCtrl.text.trim();
      // check password
      final passChecked = await webApi.account.checkAccountPassword(
        store.account.currentAccount,
        passOld,
      );
      if (passChecked == null) {
        await showCupertinoDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(l10n.wrongPin),
              content: Text(l10n.wrongPinHint),
              actions: <Widget>[
                CupertinoButton(
                  child: Text(context.l10n.ok),
                  onPressed: () {
                    _passOldCtrl.clear();
                    setState(() {
                      _submitting = false;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        // we need to iterate over all active accounts and update there password
        await context.read<LoginStore>().setPin(passNew);
        for (final account in store.account.accountListAll) {
          final acc = await api.evalJavascript(
            'account.changePassword("${account.pubKey}", "$passOld", "$passNew")',
          ) as Map<String, dynamic>;

          // update encrypted seed after password updated
          store.account.accountListAll.map((accountData) {
            // use local name, not webApi returned name
            final localAcc = accountData.toJson();
            // make metadata the same as the polkadot-js/api's
            (acc['meta'] as Map<String, dynamic>)['name'] = localAcc['name'];
            store.account.updateAccount(acc);
            store.account.updateSeed(accountData.pubKey, _passOldCtrl.text, _passCtrl.text);
          });
        }
        await showCupertinoDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(l10n.passSuccess),
              content: Text(l10n.passSuccessTxt),
              actions: <Widget>[
                CupertinoButton(
                    child: Text(context.l10n.ok),
                    onPressed: () {
                      // moving back to profile page after changing password
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.changeYourPin),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Text(
                          l10n.hintEnterCurrentPin,
                          textAlign: TextAlign.center,
                          style: context.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.hintThenEnterANewPin,
                          textAlign: TextAlign.center,
                          style: context.headlineSmall.copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 30),
                        EncointerTextFormField(
                          labelText: l10n.passOld,
                          controller: _passOldCtrl,
                          validator: (v) {
                            if (v == null || !Fmt.checkPassword(v.trim())) {
                              return l10n.createPasswordError;
                            }
                            return null;
                          },
                          obscureText: true,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        ),
                        const SizedBox(height: 20),
                        EncointerTextFormField(
                          labelText: l10n.yourNewPin,
                          controller: _passCtrl,
                          validator: (v) {
                            if (v == null || !Fmt.checkPassword(v.trim())) {
                              return l10n.createPasswordError;
                            }
                            return null;
                          },
                          obscureText: true,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        ),
                        const SizedBox(height: 20),
                        EncointerTextFormField(
                          labelText: l10n.pleaseConfirmYourNewPin,
                          controller: _pass2Ctrl,
                          validator: (v) {
                            if (v == null || v.trim() != _passCtrl.text) {
                              return l10n.createPassword2Error;
                            }
                            return null;
                          },
                          obscureText: true,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PrimaryButton(
                onPressed: _submitting ? null : () => _onSave(context.read<AppStore>()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_submitting) const CupertinoActivityIndicator(),
                    Text(l10n.contactSave),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
