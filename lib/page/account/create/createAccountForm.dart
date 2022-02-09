import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/page/account/create/createPinPage.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CreateAccountForm extends StatelessWidget {
  CreateAccountForm({this.store});
//todo get rid of the setNewAccount method where password is stored
  final AppStore store;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = new TextEditingController();
  var args = {};

  @override
  Widget build(BuildContext context) {
    final Map<String, String> dic = I18n.of(context).account;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 80),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: <Widget>[
                // Container(
                // width: 200,
                Center(
                  child: Text(I18n.of(context).profile['account.name.choose'], style: Theme.of(context).textTheme.headline2),
                ),
                // ),
                // Container(
                // width: 300,
                Center(
                  child: Text(
                    I18n.of(context).profile['account.name.choose.hint'],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ),
                // ),
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
                        labelText: I18n.of(context).profile['account.name'],
                      ),
                      controller: _nameCtrl,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            key: Key('create-account-next'),
            padding: EdgeInsets.all(16),
            child: PrimaryButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.login_1),
                  SizedBox(width: 12),
                  Text(
                    "Next",
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          color: Color(0xffF4F8F9),
                        ),
                  ),
                ],
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  // onSubmit();
                  var args = {"name": '${_nameCtrl.text}'};
                  Navigator.pushNamed(context, CreatePinPage.route, arguments: args);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
