import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountAdvanceOption extends StatefulWidget {
  AccountAdvanceOption({this.seed, this.onChange});

  final Function(AccountAdvanceOptionParams) onChange;
  final String seed;

  @override
  _AccountAdvanceOption createState() => _AccountAdvanceOption();
}

class _AccountAdvanceOption extends State<AccountAdvanceOption> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pathCtrl = new TextEditingController();

  final List<String> _typeOptions = [
    AccountAdvanceOptionParams.encryptTypeSR,
    AccountAdvanceOptionParams.encryptTypeED,
  ];

  int _typeSelection = 0;

  bool _expanded = false;
  String _derivePath = '';
  String _pathError;

  String _checkDerivePath(String path) {
    if (widget.seed != "" && path != _derivePath) {
      webApi.account.checkDerivePath(widget.seed, path, _typeOptions[_typeSelection]).then((res) {
        setState(() {
          _derivePath = path;
          _pathError = res != null ? 'Invalid derive path' : null;
        });
        widget.onChange(AccountAdvanceOptionParams(
          type: _typeOptions[_typeSelection],
          path: path,
          error: res != null,
        ));
      });
    }
    return _pathError;
  }

  @override
  void dispose() {
    _pathCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(left: 8, top: 8),
              child: Row(
                children: <Widget>[
                  Icon(
                    _expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    size: 30,
                    color: Theme.of(context).unselectedWidgetColor,
                  ),
                  Text(dic.account.advanced)
                ],
              ),
            ),
            onTap: () {
              // clear state while advanced options closed
              if (_expanded) {
                setState(() {
                  _typeSelection = 0;
                  _pathCtrl.text = '';
                });
                widget.onChange(AccountAdvanceOptionParams(
                  type: _typeOptions[0],
                  path: '',
                ));
              }
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
        ),
        _expanded
            ? ListTile(
                title: Text(I18n.of(context).translationsForLocale().account.importEncrypt),
                subtitle: Text(_typeOptions[_typeSelection]),
                trailing: Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (_) => Container(
                      height: MediaQuery.of(context).copyWith().size.height / 3,
                      child: CupertinoPicker(
                        backgroundColor: Colors.white,
                        itemExtent: 56,
                        scrollController: FixedExtentScrollController(initialItem: _typeSelection),
                        children:
                            _typeOptions.map((i) => Padding(padding: EdgeInsets.all(16), child: Text(i))).toList(),
                        onSelectedItemChanged: (v) {
                          setState(() {
                            _typeSelection = v;
                          });
                          widget.onChange(AccountAdvanceOptionParams(
                            type: _typeOptions[v],
                            path: _derivePath,
                          ));
                        },
                      ),
                    ),
                  );
                },
              )
            : Container(),
        _expanded
            ? Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: '//hard/soft///password',
                      labelText: dic.account.path,
                    ),
                    controller: _pathCtrl,
                    validator: _checkDerivePath,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}

class AccountAdvanceOptionParams {
  AccountAdvanceOptionParams({this.type, this.path, this.error});
  static const String encryptTypeSR = 'sr25519';
  static const String encryptTypeED = 'ed25519';
  String type = encryptTypeSR;
  String path = '';
  bool error = false;
}
