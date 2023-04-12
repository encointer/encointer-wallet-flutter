import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class AppAlert {
  static Future<T?> showDialog<T>(
    BuildContext context, {
    Widget? title,
    Widget? content,
    List<Widget> actions = const <Widget>[],
  }) {
    return showCupertinoDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title,
          content: content,
          actions: actions,
        );
      },
    );
  }

  static void showLoadingDialog(BuildContext context, String title) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: const SizedBox(height: 64, child: CupertinoActivityIndicator()),
        );
      },
    );
  }

  static Future<T?> showConfirmDialog<T>({
    required BuildContext context,
    required VoidCallback onOK,
    required VoidCallback onCancel,
    Widget? title,
    Widget? content,
  }) {
    final dic = I18n.of(context)!.translationsForLocale();
    return showCupertinoDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title,
          content: content,
          actions: <Widget>[
            CupertinoButton(
              onPressed: onCancel,
              child: Text(dic.home.cancel),
            ),
            CupertinoButton(
              key: const Key('ok-button'),
              onPressed: onOK,
              child: Text(dic.home.ok),
            ),
          ],
        );
      },
    );
  }

  static void showErrorDialog(
    BuildContext context, {
    Widget? title,
    required String errorText,
    required String buttontext,
    void Function()? onPressed,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title,
          content: Text(errorText),
          actions: <Widget>[
            CupertinoButton(
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
              child: Text(buttontext),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showPasswordInputDialog({
    required BuildContext context,
    required AccountData account,
  }) async {
    return showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return PasswordInputDialog(
          account: account,
          onOk: (String password) => context.read<AppStore>().settings.setPin(password),
        );
      },
    );
  }
}

class PasswordInputDialog extends StatefulWidget {
  const PasswordInputDialog({
    super.key,
    required this.account,
    required this.onOk,
  });

  final AccountData account;
  final void Function(String password) onOk;

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
      final dic = I18n.of(context)!.translationsForLocale();
      AppAlert.showErrorDialog(
        context,
        errorText: dic.profile.wrongPinHint,
        buttontext: dic.home.ok,
        title: Text(dic.profile.wrongPin),
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
            if (v == null || !Fmt.checkPassword(v.trim())) {
              return dic.account.createPasswordError;
            }
            return null;
          },
          obscureText: true,
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        ),
      ),
      actions: <Widget>[
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
