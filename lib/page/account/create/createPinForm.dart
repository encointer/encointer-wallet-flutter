import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/common/communityChooserOnMap.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreatePinForm extends StatefulWidget {
  CreatePinForm({this.onSubmit, this.store});
  final Function onSubmit;
  final AppStore store;

  @override
  _CreatePinFormState createState() => _CreatePinFormState(store);
}

class _CreatePinFormState extends State<CreatePinForm> {
  _CreatePinFormState(this.store);

  final AppStore store;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passCtrl = new TextEditingController();
  final TextEditingController _pass2Ctrl = new TextEditingController();

  @override
  void dispose() {
    _passCtrl.dispose();
    _pass2Ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: <Widget>[
                SizedBox(height: 80),
                Center(
                  child: Text(dic.profile.pinSecure, style: Theme.of(context).textTheme.headline2),
                ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 250,
                    child: Text(
                      dic.profile.pinHint,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            color: encointerBlack,
                          ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  key: Key('create-account-pin'),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(15), right: Radius.circular(15)),
                    ),
                    filled: true,
                    fillColor: ZurichLion.shade50,
                    hintText: dic.account.createPassword,
                    labelText: dic.account.createPassword,
                  ),
                  controller: _passCtrl,
                  validator: (v) {
                    return Fmt.checkPassword(v.trim()) ? null : dic.account.createPasswordError;
                  },
                  obscureText: true,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                ),
                SizedBox(height: 20),
                TextFormField(
                  key: Key('create-account-pin2'),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(15), right: Radius.circular(15)),
                    ),
                    filled: true,
                    //todo define color
                    fillColor: Color(0xffF4F8F9),
                    hintText: dic.account.createPassword2,
                    labelText: dic.account.createPassword2,
                  ),
                  controller: _pass2Ctrl,
                  obscureText: true,
                  validator: (v) {
                    return _passCtrl.text != v ? dic.account.createPassword2Error : null;
                  },
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outlined),
                      SizedBox(width: 12),
                      Container(
                        width: 250,
                        child: Text(
                          dic.profile.pinInfo,
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: encointerGrey,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            key: Key('create-account-confirm'),
            padding: EdgeInsets.all(16),
            child: PrimaryButton(
              child: Text(
                I18n.of(context).translationsForLocale().account.create,
                style: Theme.of(context).textTheme.headline3.copyWith(
                      color: ZurichLion.shade50,
                    ),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  store.account.setNewAccountPin(_passCtrl.text);

                  store.settings.setPin(_passCtrl.text);

                  widget.onSubmit();

                  // Even if we do not choose a community, we go back to the home screen.
                  Navigator.popUntil(context, ModalRoute.withName('/'));

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CommunityChooserOnMap(store)),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
