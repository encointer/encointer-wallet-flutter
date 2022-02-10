import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage(this.store, this.settingsStore);

  static final String route = '/profile/password';
  final AccountStore store;
  final SettingsStore settingsStore;
  @override
  _ChangePassword createState() => _ChangePassword(store, settingsStore);
}

class _ChangePassword extends State<ChangePasswordPage> {
  _ChangePassword(this.store, this.settingsStore);

  final Api api = webApi;
  final AccountStore store;
  final SettingsStore settingsStore;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passOldCtrl = new TextEditingController();
  final TextEditingController _passCtrl = new TextEditingController();
  final TextEditingController _pass2Ctrl = new TextEditingController();

  bool _submitting = false;

  Future<void> _onSave() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _submitting = true;
      });
      var dic = I18n.of(context).profile;
      final String passOld = _passOldCtrl.text.trim();
      final String passNew = _passCtrl.text.trim();
      // check password
      final passChecked = await webApi.account.checkAccountPassword(store.currentAccount, passOld);
      if (passChecked == null) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(dic['pass.error']),
              content: Text(dic['pass.error.txt']),
              actions: <Widget>[
                CupertinoButton(
                  child: Text(I18n.of(context).home['ok']),
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
        settingsStore.setPin(passNew);
        store.accountListAll.forEach((account) async {
          final Map acc =
              await api.evalJavascript('account.changePassword("${account.pubKey}", "$passOld", "$passNew")');

          // update encrypted seed after password updated
          store.accountListAll.map((accountData) {
            // use local name, not webApi returned name
            Map<String, dynamic> localAcc = AccountData.toJson(accountData);
            // make metadata the same as the polkadot-js/api's
            acc['meta']['name'] = localAcc['name'];
            store.updateAccount(acc);
            store.updateSeed(accountData.pubKey, _passOldCtrl.text, _passCtrl.text);
          });
        });
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(dic['pass.success']),
              content: Text(dic['pass.success.txt']),
              actions: <Widget>[
                CupertinoButton(
                    child: Text(I18n.of(context).home['ok']),
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
    var dic = I18n.of(context).profile;
    var accDic = I18n.of(context).account;
    return Scaffold(
      appBar: AppBar(
        title: Text(dic['pass.change']),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  children: <Widget>[
                    SizedBox(height: 80),
                    Center(
                      child: Text(dic['pin.hint1'],
                          textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline2),
                    ),
                    Center(
                      child: Text(
                        dic['pin.hint2'],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(15), right: Radius.circular(15)),
                        ),
                        filled: true,
                        fillColor: Color(0xffF4F8F9),
                        hintText: dic['pass.old'],
                        labelText: dic['pass.old'],
                        suffixIcon: IconButton(
                          iconSize: 18,
                          icon: Icon(
                            CupertinoIcons.clear_thick_circled,
                            color: Theme.of(context).unselectedWidgetColor,
                          ),
                          onPressed: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) => _passOldCtrl.clear());
                          },
                        ),
                      ),
                      controller: _passOldCtrl,
                      validator: (v) {
                        // TODO: fix me: disable validator for polkawallet-RN exported keystore importing
                        return null;
                        // return Fmt.checkPassword(v.trim()) ? null : accDic['create.password.error'];
                      },
                      obscureText: true,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(15), right: Radius.circular(15)),
                        ),
                        filled: true,
                        fillColor: Color(0xffF4F8F9),
                        hintText: dic['pass.new'],
                        labelText: dic['pass.new'],
                      ),
                      controller: _passCtrl,
                      validator: (v) {
                        return Fmt.checkPassword(v.trim()) ? null : accDic['create.password.error'];
                      },
                      obscureText: true,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(15), right: Radius.circular(15)),
                        ),
                        filled: true,
                        fillColor: Color(0xffF4F8F9),
                        hintText: dic['pass.new2'],
                        labelText: dic['pass.new2'],
                      ),
                      controller: _pass2Ctrl,
                      validator: (v) {
                        return v.trim() != _passCtrl.text ? accDic['create.password2.error'] : null;
                      },
                      obscureText: true,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: PrimaryButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _submitting ? CupertinoActivityIndicator() : Container(),
                    Text(
                      dic['contact.save'],
                      style: Theme.of(context).textTheme.headline3.copyWith(
                            color: Color(0xffF4F8F9),
                          ),
                    ),
                  ],
                ),
                onPressed: _submitting ? null : _onSave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
