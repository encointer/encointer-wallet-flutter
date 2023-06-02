import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class PasswordInputDialog extends StatefulWidget {
  const PasswordInputDialog({
    super.key,
    required this.account,
    required this.onSuccess,
    this.canPop = true,
    this.shouldShowCancelButton = false,
    this.autoCloseOnSuccess = true,
  });

  final AccountData account;
  final Future<void> Function(String password) onSuccess;
  final bool canPop;
  final bool shouldShowCancelButton;
  final bool autoCloseOnSuccess;

  @override
  State<PasswordInputDialog> createState() => _PasswordInputDialogState();
}

class _PasswordInputDialogState extends State<PasswordInputDialog> {
  final TextEditingController _passCtrl = TextEditingController();
  bool _submitting = false;

  Future<void> _onOk() async {
    setState(() {
      _submitting = true;
    });
    final res = await webApi.account.checkAccountPassword(widget.account, _passCtrl.text.trim());
    setState(() {
      _submitting = false;
    });
    if (res == null) {
      final dic = I18n.of(context)!.translationsForLocale();
      AppAlert.showErrorDialog(
        context,
        errorText: dic.profile.wrongPinHint,
        buttontext: dic.home.ok,
        title: Text(dic.profile.wrongPin),
      );
    } else {
      await widget.onSuccess(_passCtrl.text.trim());
      if (widget.autoCloseOnSuccess) Navigator.of(context).pop();
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
    return WillPopScope(
      onWillPop: () async => widget.canPop,
      child: CupertinoAlertDialog(
        title: Text(dic.profile.unlock),
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
              if (v == null || !Fmt.checkPassword(v.trim())) return dic.account.createPasswordError;

              return null;
            },
            obscureText: true,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        actions: <Widget>[
          if (widget.shouldShowCancelButton)
            CupertinoButton(
              key: const Key('cancel-bottun'),
              onPressed: () => Navigator.pop(context),
              child: Text(dic.home.cancel),
            ),
          CupertinoButton(
            key: const Key('password-ok'),
            onPressed: _submitting ? null : _onOk,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_submitting) const CupertinoActivityIndicator(),
                Text(dic.home.ok),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
