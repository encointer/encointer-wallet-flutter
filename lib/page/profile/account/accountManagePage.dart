import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/assets/receive/receivePage.dart';
import 'package:encointer_wallet/page/profile/account/ExportResultPage.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';

class AccountManagePage extends StatefulWidget {
  AccountManagePage(this.store);

  static final String route = '/profile/account';
  final AppStore store;

  @override
  _AccountManagePageState createState() => _AccountManagePageState(store);
}

class _AccountManagePageState extends State<AccountManagePage> {
  _AccountManagePageState(this.store);

  final AppStore store;
  final Api api = webApi;
  TextEditingController _nameCtrl;
  final TextEditingController _passCtrl = new TextEditingController();
  bool _isEditingText = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  void _onDeleteAccount(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(I18n.of(context).translationsForLocale().profile.accountDelete),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context).translationsForLocale().home.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoButton(
              child: Text(I18n.of(context).translationsForLocale().home.ok),
              onPressed: () => {
                store.account.removeAccount(store.account.currentAccount).then(
                  (_) {
                    // refresh balance
                    store.assets.loadAccountCache();
                    webApi.assets.fetchBalance();
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                ),
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> _getBalances() {
    final TextStyle h3 = Theme.of(context).textTheme.headline3;
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    CommunityMetadata cm = store.encointer.communityMetadata;
    String name = cm != null ? cm.name : '';
    String symbol = cm != null ? cm.symbol : '';
    final String tokenView = Fmt.tokenView(symbol);
    return store.encointer.balanceEntries.entries.map((i) {
      if (cm != null) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
          leading: Container(
            width: 50,
            child: webApi.ipfs.getCommunityIcon(store.encointer.communityIconsCid, devicePixelRatio),
          ),
          title: Text(name, style: h3),
          subtitle: Text(tokenView, style: h3),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${Fmt.doubleFormat(store.encointer.communityBalance)} ⵐ',
                style: h3.copyWith(color: encointerGrey),
              ),
              // Container(width: 16),
            ],
          ),
        );
      } else
        return Container();
    }).toList();
  }

  void _showActions(BuildContext pageContext) {
    final Translations dic = I18n.of(context).translationsForLocale();
    showCupertinoModalPopup(
      context: pageContext,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              dic.profile.delete,
            ),
            onPressed: () {
              _onDeleteAccount(context);
              // Navigator.of(context).pop();
            },
          ),
          CupertinoActionSheetAction(
              child: Text(
                dic.profile.export,
              ),
              onPressed: () {
                // Navigator.of(context).pop();
                if (store.settings.cachedPin.isEmpty)
                  // _showPasswordDialog(context, AccountStore.seedTypeMnemonic);
                  _showPass(context);
                else {
                  Navigator.of(context).pushNamed(ExportResultPage.route, arguments: {
                    // 'key': seed,
                    'type': AccountStore.seedTypeMnemonic,
                  });
                }
              }),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(I18n.of(context).translationsForLocale().home.cancel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showPasswordDialog(BuildContext context, String seedType) {
    final Translations dic = I18n.of(context).translationsForLocale();

    Future<void> onOk() async {
      var res = await webApi.account.checkAccountPassword(store.account.currentAccount, _passCtrl.text);
      if (res == null) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(dic.profile.passError),
              content: Text(dic.profile.passErrorTxt),
              actions: <Widget>[
                CupertinoButton(
                  child: Text(I18n.of(context).translationsForLocale().home.ok),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      } else {
        Navigator.of(context).pop();
        String seed =
            await store.account.decryptSeed(store.account.currentAccount.pubKey, seedType, _passCtrl.text.trim());
        Navigator.of(context).pushNamed(ExportResultPage.route, arguments: {
          'key': seed,
          'type': seedType,
        });
      }
    }

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(dic.profile.deleteConfirm),
          content: Padding(
            padding: EdgeInsets.only(top: 16),
            child: CupertinoTextField(
              keyboardType: TextInputType.number,
              placeholder: dic.profile.passOld,
              controller: _passCtrl,
              clearButtonMode: OverlayVisibilityMode.editing,
              onChanged: (v) {
                return Fmt.checkPassword(v.trim()) ? null : dic.account.createPasswordError;
              },
              obscureText: true,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context).translationsForLocale().home.cancel),
              onPressed: () {
                Navigator.of(context).pop();
                _passCtrl.clear();
              },
            ),
            CupertinoButton(
              child: Text(I18n.of(context).translationsForLocale().home.ok),
              onPressed: onOk,
            ),
          ],
        );
      },
    );
  }

  void _showPass(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return showPasswordInputDialog(context, store.account.currentAccount, Text(dic.profile.deleteConfirm),
            (password) async {
          print('password is: $password');
          setState(() {
            store.settings.setPin(password);
          });

          Navigator.of(context).pushNamed(ExportResultPage.route, arguments: {
            // 'key': seed,
            'type': AccountStore.seedTypeMnemonic,
          });
          Navigator.of(context).pop();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle h3 = Theme.of(context).textTheme.headline3;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    _nameCtrl = TextEditingController(text: store.account.currentAccount.name);
    _nameCtrl.selection = TextSelection.fromPosition(TextPosition(offset: _nameCtrl.text.length));

    final Translations dic = I18n.of(context).translationsForLocale();
    var args = {
      "isShare": true,
    };
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: _isEditingText
              ? TextFormField(
                  controller: _nameCtrl,
                  validator: (v) {
                    String name = v.trim();
                    if (name.length == 0) {
                      return dic.profile.contactNameError;
                    }
                    int exist = store.account.optionalAccounts.indexWhere((i) => i.name == name);
                    if (exist > -1) {
                      return dic.profile.contactNameExist;
                    }
                    return null;
                  },
                )
              : Text(_nameCtrl.text),
          actions: <Widget>[
            !_isEditingText
                ? IconButton(
                    icon: Icon(
                      Iconsax.edit,
                    ),
                    onPressed: () {
                      setState(() {
                        _isEditingText = true;
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(
                      Icons.check,
                    ),
                    onPressed: () {
                      store.account.updateAccountName(_nameCtrl.text.trim());
                      setState(() {
                        _isEditingText = false;
                      });
                    },
                  )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    if (!isKeyboard)
                      AddressIcon(
                        '',
                        size: 130,
                        pubKey: store.account.currentAccount.pubKey,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Fmt.address(store.account.currentAddress), style: TextStyle(fontSize: 20)),
                        IconButton(
                          // style: ElevatedButton.styleFrom(shadowColor: Colors.transparent),
                          icon: Icon(Iconsax.copy),
                          color: ZurichLion.shade500,
                          // border: 2px solid,
                          onPressed: () {
                            final data = ClipboardData(text: store.account.currentAddress);
                            Clipboard.setData(data);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('✓   Copied to Clipboard')),
                            );
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: <Widget>[
                          Text(dic.encointer.communities,
                              style: Theme.of(context).textTheme.headline3.copyWith(color: encointerGrey))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(padding: EdgeInsets.all(16), children: _getBalances()),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16), // make splash animation as high as the container
                          primary: Colors.transparent,
                          onPrimary: Colors.white,
                          shadowColor: Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 26, top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Iconsax.share),
                              SizedBox(width: 12),
                              Text(dic.profile.accountShare, style: h3.copyWith(color: Colors.white)),
                            ],
                          ),
                        ),
                        onPressed: () {
                          // if (acc.address != '') {
                          Navigator.pushNamed(context, ReceivePage.route, arguments: args);
                        },
                      ),
                      // SizedBox(width: 24),
                      Spacer(),
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // primary: Colors.transparent,
                            primary: Colors.transparent,
                            onPrimary: Colors.white,
                            shadowColor: Colors.transparent,
                            // shape: RoundedRectangleBorder(
                            //   // don't redefine the entire style just the border radii
                            //   borderRadius: BorderRadius.horizontal(left: Radius.zero, right: Radius.circular(15)),
                            // ),
                          ),
                          child: Icon(Icons.more_horiz),
                          // child: Padding(
                          //     padding: const EdgeInsets.all(16.0),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         SizedBox(width: 12),
                          //         Icon(Icons.more_horiz),
                          //       ],
                          //     ),
                          // ),
                          onPressed: () => _showActions(context),
                        ),
    ),
                    ],
                  ),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Container(
              //       width: MediaQuery.of(context).size.width * 0.75,
              //       child: PrimaryButton(
              //           borderRadius: BorderRadius.horizontal(left: Radius.circular(15), right: Radius.zero),
              //           // child: ElevatedButton(
              //           //     style: ElevatedButton.styleFrom(
              //           // primary: Colors.transparent,
              //           // onPrimary: Colors.white,
              //           // primary: ZurichLion.shade600,
              //           // shape: RoundedRectangleBorder(
              //           // don't redefine the entire style just the border radii
              //           // borderRadius: BorderRadius.horizontal(left: Radius.circular(15), right: Radius.zero),
              //           // ),
              //           // ),
              //           child: Padding(
              //             padding: const EdgeInsets.all(16.0),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Icon(Iconsax.share),
              //                 SizedBox(width: 12),
              //                 Text(dic.profile.accountShare),
              //               ],
              //             ),
              //           ),
              //           onPressed: () {
              //             // if (acc.address != '') {
              //             Navigator.pushNamed(context, ReceivePage.route, arguments: args);
              //           }),
              //       // ),
              //     ),
              //     SizedBox(width: 2),
              //     Container(
              //       width: MediaQuery.of(context).size.width * 0.25 - 2,
              //       child: PrimaryButton(
              //         borderRadius: BorderRadius.horizontal(left: Radius.zero, right: Radius.circular(15)),
              //         // child: ElevatedButton(
              //         //   style: ElevatedButton.styleFrom(
              //         //     // primary: Colors.transparent,
              //         //     onPrimary: Colors.white,
              //         //     primary: ZurichLion.shade600,
              //         //     shape: RoundedRectangleBorder(
              //         //       // don't redefine the entire style just the border radii
              //         //       borderRadius: BorderRadius.horizontal(left: Radius.zero, right: Radius.circular(15)),
              //         //     ),
              //         //   ),
              //         child: Padding(
              //           padding: const EdgeInsets.all(16.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               SizedBox(width: 12),
              //               Icon(Icons.more_horiz),
              //             ],
              //           ),
              //         ),
              //         onPressed: () => _showActions(context),
              //       ),
              //     ),
              //     // ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
