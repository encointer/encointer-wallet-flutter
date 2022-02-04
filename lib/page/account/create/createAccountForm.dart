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
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: <Widget>[
                Center(
                  child: Text("Choose an account name.", style: Theme.of(context).textTheme.headline2),
                ),
                SizedBox(
                  width: 1,
                  height: 100,
                  child:
                Center(
                child: Text(
                    "You can change it later \n"
                    "in your profile settings.",
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  ),
                ),
                Align(
                  //find alignment statement when online^^
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      key: Key('create-account-name'),
                      decoration: InputDecoration(
                        // icon: Icon(Icons.person),
                        hintText: dic['create.hint'],
                        labelText: "Account name",
                      ),
                      controller: _nameCtrl,
                    ),
                  ],
                ),
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
                  var args = {
                  "name": '${_nameCtrl.text}'
                  };
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
