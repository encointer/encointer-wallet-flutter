import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

Widget showPasswordInputDialog(
  BuildContext context,
  AccountData account,
  Widget? title,
  Function onOk,
) {
  return PasswordInputDialog(
    account: account,
    title: title,
    onCancel: () => Navigator.of(context).pop(),
    onOk: onOk,
  );
}

class PasswordInputDialog extends StatefulWidget {
  const PasswordInputDialog({
    Key? key,
    required this.account,
    required this.onOk,
    this.title,
    this.onCancel,
    this.onAccountSwitch,
  }) : super(key: key);

  final AccountData account;
  final Function onOk;
  final Widget? title;
  final Function? onCancel;
  final Function? onAccountSwitch;

  @override
  State<PasswordInputDialog> createState() => _PasswordInputDialogState();
}

class _PasswordInputDialogState extends State<PasswordInputDialog> {
  final TextEditingController _passCtrl = TextEditingController();
  bool _submitting = false;

  Future<void> _onOk(String password) async {
    setState(() {
      _submitting = true;
    });
    final res = await webApi.account.checkAccountPassword(widget.account, password);
    if (mounted) {
      setState(() {
        _submitting = false;
      });
    }
    if (res == null) {
      showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) {
          final dic = I18n.of(context)!.translationsForLocale();
          return CupertinoAlertDialog(
            title: Text(dic.profile.wrongPin),
            content: Text(dic.profile.wrongPinHint),
            actions: <Widget>[
              CupertinoButton(
                key: const Key('error-dialog-ok'),
                child: Text(I18n.of(context)!.translationsForLocale().home.ok),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    } else {
      widget.onOk(password);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();

    return CupertinoAlertDialog(
      title: widget.title ?? Container(),
      content: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: CupertinoTextFormFieldRow(
          key: const Key('input-password-dialog'),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
          autofocus: true,
          keyboardType: TextInputType.number,
          placeholder: dic.profile.passOld,
          controller: _passCtrl,
          validator: (v) {
            if (v == null || !Fmt.checkPassword(v.trim())) {
              return dic.account.createPasswordError;
            }
            return null;
          },
          obscureText: true,
          // clearButtonMode: OverlayVisibilityMode.editing,
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        ),
      ),
      actions: <Widget>[
        if (widget.onAccountSwitch != null)
          CupertinoButton(
            child: Text(dic.home.switchAccount),
            onPressed: () {
              widget.onAccountSwitch!();
            },
          ),
        if (widget.onCancel != null)
          CupertinoButton(
            child: Text(dic.home.cancel),
            onPressed: () {
              widget.onCancel!();
            },
          ),
        CupertinoButton(
          key: const Key('password-ok'),
          onPressed: _submitting ? null : () => _onOk(_passCtrl.text.trim()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_submitting) const CupertinoActivityIndicator(),
              Text(dic.home.ok),
            ],
          ),
        ),
      ],
    );
  }
}
