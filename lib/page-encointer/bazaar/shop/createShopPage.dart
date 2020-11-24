import 'package:encointer_wallet/common/components/accountAdvanceOption.dart';
import 'package:encointer_wallet/page-encointer/homePage.dart';
import 'package:encointer_wallet/page/account/create/createAccountForm.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:encointer_wallet/page-encointer/bazaar/components/shopClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateShopPage extends StatefulWidget {
  const CreateShopPage(this.store);

  static final String route = '/encointer/bazaar/shop';
  final AppStore store;

  @override
  _CreateShopPageState createState() => _CreateShopPageState(store);
}

class _CreateShopPageState extends State<CreateShopPage> {
  _CreateShopPageState(this.store);

  final AppStore store;

  TextEditingController nameController = TextEditingController();

  void addItemToList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).bazaar;

    return Scaffold(
      appBar: AppBar(title: Text(dic['shop.create'])),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(border: OutlineInputBorder(), labelText: dic['store.name']),
                ),
                RaisedButton(
                  child: Text('Add'),
                  onPressed: () {
                    addItemToList();
                  },
                ),
              ],
            )),
      ),
    );
  }

// bool _submitting = false;
//
// Future<void> _createAndImportAccount() async {
//   setState(() {
//     _submitting = true;
//   });
//
//   await webApi.account.generateAccount();
//
//   var acc = await webApi.account.importAccount(
//     cryptoType: AccountAdvanceOptionParams.encryptTypeSR,
//     derivePath: '',
//   );
//
//   if (acc['error'] != null) {
//     setState(() {
//       _submitting = false;
//     });
//     _showErrorCreatingAccountDialog(context);
//     return;
//   }
//
//   await store.account.addAccount(acc, store.account.newAccount.password);
//   webApi.account.encodeAddress([acc['pubKey']]);
//
//   store.assets.loadAccountCache();
//
//   // fetch info for the imported account
//   String pubKey = acc['pubKey'];
//   webApi.assets.fetchBalance();
//   webApi.account.fetchAccountsBonded([pubKey]);
//   webApi.account.getPubKeyIcons([pubKey]);
//   store.account.setCurrentAccount(pubKey);
//
//   setState(() {
//     _submitting = false;
//   });
//   // go to home page
//   Navigator.popUntil(context, ModalRoute.withName('/'));
//   // pass the encointerHomepage context, else Navigator.pop() acts on this context, which has been invalidated.
//   _showTryFaucetDialog(EncointerHomePage.encointerHomePageKey.currentContext);
// }
//
// Future<void> _showTryFaucetDialog(BuildContext context) async {
//   await showCupertinoDialog(
//     context: context,
//     builder: (_) {
//       return CupertinoAlertDialog(
//         title: Text(I18n.of(context).encointer['faucet.try']),
//         actions: <Widget>[
//           CupertinoButton(
//             child: Text(I18n.of(context).home['ok']),
//             onPressed: () {
//               Navigator.popUntil(context, ModalRoute.withName('/'));
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
//
// static Future<void> _showErrorCreatingAccountDialog(BuildContext context) async {
//   showCupertinoDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return CupertinoAlertDialog(
//         title: Container(),
//         content: Text(I18n.of(context).account['create.error']),
//         actions: <Widget>[
//           CupertinoButton(
//             child: Text(I18n.of(context).home['ok']),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(title: Text(I18n.of(context).home['create'])),
//     body: SafeArea(
//       child: !_submitting
//           ? CreateAccountForm(
//         setNewAccount: store.account.setNewAccount,
//         submitting: _submitting,
//         onSubmit: () {
//           setState(() {
//             _createAndImportAccount();
//           });
//         },
//       )
//           : Center(child: CupertinoActivityIndicator()),
//     ),
//   );
// }
}
