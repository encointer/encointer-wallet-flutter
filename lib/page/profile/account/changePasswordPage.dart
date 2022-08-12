import 'dart:async';

import 'package:encointer_wallet/common/components/encointerTextFormField.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  static const String route = '/profile/password';

  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passOldCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _pass2Ctrl = TextEditingController();

  bool _submitting = false;

  Future<void> _onSave() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submitting = true;
      });

      final dic = I18n.of(context)!.translationsForLocale();
      final passOld = _passOldCtrl.text.trim();
      final passNew = _passCtrl.text.trim();
      // check password
      final passChecked = await webApi.account.checkAccountPassword(
        context.read<AppStore>().account.currentAccount,
        passOld,
      );
      if (passChecked == null) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(dic.profile.wrongPin),
              content: Text(dic.profile.wrongPinHint),
              actions: [
                CupertinoButton(
                  child: Text(I18n.of(context)!.translationsForLocale().home.ok),
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
        context.read<AppStore>().settings.setPin(passNew);
        context.read<AppStore>().account.accountListAll.forEach((account) async {
          final acc = await webApi.evalJavascript(
            'account.changePassword("${account.pubKey}", "$passOld", "$passNew")',
          );

          // update encrypted seed after password updated
          context.read<AppStore>().account.accountListAll.map((accountData) {
            // use local name, not webApi returned name
            final localAcc = AccountData.toJson(accountData);
            // make metadata the same as the polkadot-js/api's
            acc['meta']['name'] = localAcc['name'];
            context.read<AppStore>().account.updateAccount(acc);
            context.read<AppStore>().account.updateSeed(accountData.pubKey, _passOldCtrl.text, _passCtrl.text);
          });
        });
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(dic.profile.passSuccess),
              content: Text(dic.profile.passSuccessTxt),
              actions: [
                CupertinoButton(
                    child: Text(I18n.of(context)!.translationsForLocale().home.ok),
                    onPressed: () => {
                          // moving back to profile page after changing password
                          Navigator.popUntil(context, ModalRoute.withName('/')),
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
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.profile.changeYourPin),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          dic.profile.hintEnterCurrentPin,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          dic.profile.hintThenEnterANewPin,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 30),
                        EncointerTextFormField(
                          labelText: dic.profile.passOld,
                          controller: _passOldCtrl,
                          validator: (v) {
                            if (v == null || !Fmt.checkPassword(v.trim())) {
                              return dic.account.createPasswordError;
                            }
                            return null;
                          },
                          obscureText: true,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                        ),
                        const SizedBox(height: 20),
                        EncointerTextFormField(
                          labelText: dic.profile.yourNewPin,
                          controller: _passCtrl,
                          validator: (v) {
                            if (v == null || !Fmt.checkPassword(v.trim())) {
                              return dic.account.createPasswordError;
                            }
                            return null;
                          },
                          obscureText: true,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                        ),
                        const SizedBox(height: 20),
                        EncointerTextFormField(
                          labelText: dic.profile.pleaseConfirmYourNewPin,
                          controller: _pass2Ctrl,
                          validator: (v) {
                            if (v == null || v.trim() != _passCtrl.text) {
                              return dic.account.createPassword2Error;
                            }
                            return null;
                          },
                          obscureText: true,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PrimaryButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _submitting ? const CupertinoActivityIndicator() : const SizedBox(),
                    Text(
                      dic.profile.contactSave,
                      style: Theme.of(context).textTheme.headline3!.copyWith(color: ZurichLion.shade50),
                    ),
                  ],
                ),
                onPressed: _submitting ? null : _onSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
