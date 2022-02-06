import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/page/account/import/importAccountPage.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddAccountForm extends StatelessWidget {
  AddAccountForm({this.setNewAccount, this.submitting, this.onSubmit, this.store});
//todo get rid of the setNewAccount method where password is stored
  final Function setNewAccount;
  final Function onSubmit;
  final bool submitting;
  final AppStore store;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map<String, String> dic = I18n.of(context).account;

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
                  child: Text("Choose an account name.", style: Theme.of(context).textTheme.headline2),
                ),
                // ),
                // Container(
                // width: 300,
                Center(
                  child: Text(
                    "You can change it later in \n your profile settings.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  children: <Widget>[
                    TextFormField(
                      key: Key('create-account-name'),
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(15), right: Radius.circular(15)),
                        ),
                        filled: true,
                        fillColor: Color(0xffF4F8F9),
                        // icon: Icon(Icons.person),
                        // if change color of hint:
                        // labelStyle: TextStyle(
                        //     color: Color(0xff4374A3))
                        hintText: dic['create.hint'],
                        labelText: "Account name",
                      ),
                      controller: _nameCtrl,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 12),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                              text: 'Import',
                              style: TextStyle(
                                color: Color(0xff4374A3),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, ImportAccountPage.route);
                                }),
                        ]),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.add_square),
                  SizedBox(width: 12),
                  Text(
                    "Create account",
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          color: Color(0xffF4F8F9),
                        ),
                  ),
                ],
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  setNewAccount(
                      _nameCtrl.text.isNotEmpty ? _nameCtrl.text : dic['create.default'], store.settings.cachedPin);
                  onSubmit();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
