import 'package:encointer_wallet/common/components/BorderedTitle.dart';
import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/page/assets/receive/receivePage.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
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
        return showPasswordInputDialog(
            context, store.account.currentAccount, Text(I18n.of(context).profile['delete.confirm']), (_) {
          store.account.removeAccount(store.account.currentAccount).then((_) {
            // refresh balance
            store.assets.loadAccountCache();
            webApi.assets.fetchBalance();
          });
          Navigator.of(context).pop();
        });
      },
    );
  }

  List<Widget> _getBalances() {
    CommunityMetadata cm = store.encointer.communityMetadata;
    String name = cm != null ? cm.name : '';
    String symbol = cm != null ? cm.symbol : '';
    final String tokenView = Fmt.tokenView(symbol);
    return store.encointer.balanceEntries.entries.map((i) {
      if (cm != null) {
        return RoundedCard(
          margin: EdgeInsets.only(top: 16),
          child: ListTile(
            leading: Container(
              width: 36,
              child: Image.asset('assets/images/assets/${symbol.isNotEmpty ? symbol : 'DOT'}.png'),
            ),
            title: Text(name),
            subtitle: Text(tokenView),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  Fmt.doubleFormat(store.encointer.communityBalance),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54),
                ),
                Container(width: 16),
              ],
            ),
          ),
        );
      } else
        return Container();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    _nameCtrl = TextEditingController(text: store.account.currentAccount.name);
    _nameCtrl.selection = TextSelection.fromPosition(TextPosition(offset: _nameCtrl.text.length));

    final Map<String, String> dic = I18n.of(context).profile;
    Color primaryColor = Theme.of(context).primaryColor;

    var args = {
      "isShare": true,
    };
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: TextFormField(
            controller: _nameCtrl,
            onTap: () {
              setState(() {
                _isEditingText = true;
              });
            },
            validator: (v) {
              String name = v.trim();
              if (name.length == 0) {
                return dic['contact.name.error'];
              }
              int exist = store.account.optionalAccounts.indexWhere((i) => i.name == name);
              if (exist > -1) {
                return dic['contact.name.exist'];
              }
              return null;
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(16),
                child: _isEditingText
                    ? RoundedButton(
                        text: dic['contact.name.save'],
                        onPressed: () {
                          store.account.updateAccountName(_nameCtrl.text.trim());
                          setState(() {
                            _isEditingText = false;
                          });
                        })
                    : Container(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50),
                  AddressIcon(
                    '',
                    size: 100,
                    pubKey: store.account.currentAccount.pubKey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Fmt.address(store.account.currentAddress), style: TextStyle(fontSize: 20)),
                      ElevatedButton(
                        child: Icon(Icons.copy),
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
                  Text(Fmt.address(store.account.currentAddress) ?? '',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  Container(padding: EdgeInsets.only(top: 16)),
                  ListTile(
                    title: Text(dic['name.change']),
                    trailing: Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () => Navigator.pushNamed(context, ChangeNamePage.route),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        Text(dic['communities'],
                            style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.black54))
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(padding: EdgeInsets.all(16), children: _getBalances()),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  // color: Theme.of(context).colorScheme.secondary,
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.profile_remove),
                            SizedBox(width: 12),
                            Text(dic['delete'], style: Theme.of(context).textTheme.headline3),
                          ],
                        ),
                        // Text(I18n.of(context).home['create'], style: Theme.of(context).textTheme.headline3),
                        onPressed: () {
                          _onDeleteAccount(context);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: PrimaryButton(
                  onPressed: () => Navigator.pushNamed(context, ReceivePage.route, arguments: args),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.share),
                      SizedBox(width: 12),
                      Text(
                        dic['account.share'],
                        style: Theme.of(context).textTheme.headline3.copyWith(
                              color: Color(0xffF4F8F9),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              // Container(
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: ElevatedButton(
              //         style: TextButton.styleFrom(
              //           padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
              //           backgroundColor: primaryColor,
              //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              //         ),
              //         child: Text(
              //           dic['delete'],
              //           style: Theme.of(context).textTheme.button,
              //         ),
              //         onPressed: () {
              //           _onDeleteAccount(context);
              //         }),
              //   ),
              // ),
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //       child: TextButton(
              //         style: TextButton.styleFrom(
              //           padding: EdgeInsets.all(16),
              //           backgroundColor: Colors.white,
              //           textStyle: TextStyle(color: Colors.red),
              //         ),
              //         child: Text(dic['delete']),
              //         onPressed: () => _onDeleteAccount(context),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
