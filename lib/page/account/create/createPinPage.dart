import 'package:encointer_wallet/common/components/accountAdvanceOption.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/common/communityChooserOnMap.dart';
import 'package:encointer_wallet/page/account/create/createPinForm.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePinPage extends StatefulWidget {
  const CreatePinPage(this.store, {this.importAccount});

  static const String route = '/account/createPin';
  final AppStore store;

  final Future<void> Function() importAccount;

  @override
  _CreatePinPageState createState() => _CreatePinPageState(store, importAccount: importAccount);
}

class _CreatePinPageState extends State<CreatePinPage> {
  _CreatePinPageState(this.store, {this.importAccount});

  final AppStore store;

  Future<void> Function() importAccount;

  bool _submitting = false;

  Future<void> _createAndImportAccount() async {
    await webApi.account.generateAccount();

    var acc = await webApi.account.importAccount(
      cryptoType: AccountAdvanceOptionParams.encryptTypeSR,
      derivePath: '',
    );

    if (acc['error'] != null) {
      setState(() {
        _submitting = false;
      });
      _showErrorCreatingAccountDialog(context);
      return;
    }

    await store.account.addAccount(acc, store.account.newAccount.password);
    webApi.account.encodeAddress([acc['pubKey']]);

    await store.loadAccountCache();

    // fetch info for the imported account
    String pubKey = acc['pubKey'];
    webApi.fetchAccountData();
    webApi.account.fetchAccountsBonded([pubKey]);
    webApi.account.getPubKeyIcons([pubKey]);
    store.account.setCurrentAccount(pubKey);
  }

  static Future<void> _showErrorCreatingAccountDialog(BuildContext context) async {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Container(),
          content: Text(I18n.of(context).translationsForLocale().account.createError),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context).translationsForLocale().home.ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (importAccount == null) {
      importAccount = _createAndImportAccount;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          I18n.of(context).translationsForLocale().home.create,
        ),
        iconTheme: IconThemeData(
          color: encointerGrey, //change your color here
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: encointerGrey,
            ),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          )
        ],
      ),
      body: SafeArea(
        child: !_submitting
            ? CreatePinForm(
                onSubmit: () async {
                  setState(() {
                    _submitting = true;
                  });

                  await importAccount();

                  if (store.encointer.communities != null) {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CommunityChooserOnMap(store)),
                    );
                  } else {
                    await showNoCommunityDialog(context);
                  }

                  setState(() {
                    _submitting = false;
                  });

                  // Even if we do not choose a community, we go back to the home screen.
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                store: store,
              )
            : Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}

Future<void> showNoCommunityDialog(BuildContext context) {
  var translations = I18n.of(context).translationsForLocale();

  return showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Container(),
        content: Text(translations.encointer.noCommunitiesFoundChooseLater),
        actions: <Widget>[
          CupertinoButton(
            child: Text(translations.home.ok),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
