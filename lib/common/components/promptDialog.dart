import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';

showPromptDialog(context, account, title, onOk) {
  return PromptDialog(
    account: account,
    title: title,
    onCancel: () => Navigator.of(context).pop(),
    onOk: onOk,
  );
}

class PromptDialog extends StatefulWidget {
  PromptDialog({this.account, this.title, this.onOk, this.onCancel});

  final AccountData account;
  final Widget title;
  final Function onOk;
  final Function onCancel;

  @override
  _PromptDialogState createState() => _PromptDialogState();
}

class _PromptDialogState extends State<PromptDialog> {
  bool _submitting = false;

  Future<void> _onOk() async {
    setState(() {
      _submitting = true;
    });
    if (mounted) {
      setState(() {
        _submitting = false;
      });
    }
    print("got here");
    widget.onOk();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> dic = I18n.of(context).home;

    return CupertinoAlertDialog(
      title: widget.title ?? Container(),
      actions: <Widget>[
        widget.onCancel != null
            ? CupertinoButton(
                child: Text(dic['cancel']),
                onPressed: () {
                  widget.onCancel();
                },
              )
            : Container(),
        CupertinoButton(
          key: Key('password-ok'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(dic['ok'])],
          ),
          onPressed: _submitting
              ? null
              : () {
                  _onOk();
                },
        ),
      ],
    );
  }
}
