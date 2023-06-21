// import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';

// // import 'package:encointer_wallet/service/substrate_api/api.dart';
// // import 'package:encointer_wallet/store/account/types/account_data.dart';
// // import 'package:encointer_wallet/utils/alerts/app_alert.dart';
// // import 'package:encointer_wallet/utils/format.dart';
// import 'package:encointer_wallet/l10n/l10.dart';

// class PasswordInputDialog extends StatefulWidget {
//   const PasswordInputDialog({
//     super.key,
//     // required this.account,
//     required this.onSuccess,
//     this.canPop = true,
//     this.showCancelButton = false,
//     this.autoCloseOnSuccess = true,
//     this.title,
//   });

//   // final AccountData account;
//   final Future<void> Function(String password) onSuccess;
//   final bool canPop;
//   final bool showCancelButton;
//   final bool autoCloseOnSuccess;
//   final String? title;

//   @override
//   State<PasswordInputDialog> createState() => _PasswordInputDialogState();
// }

// class _PasswordInputDialogState extends State<PasswordInputDialog> {
//   // final TextEditingController _passCtrl = TextEditingController();
//   // bool _submitting = false;

//   // Future<void> _onOk() async {
//   //   setState(() {
//   //     _submitting = true;
//   //   });
//   //   final res = await webApi.account.checkAccountPassword(widget.account, _passCtrl.text.trim());
//   //   setState(() {
//   //     _submitting = false;
//   //   });
//   //   if (res == null) {
//   //     final l10n = context.l10n;
//   //     AppAlert.showErrorDialog(
//   //       context,
//   //       errorText: l10n.wrongPinHint,
//   //       buttontext: l10n.ok,
//   //       title: Text(l10n.wrongPin),
//   //     );
//   //   } else {
//   //     await widget.onSuccess(_passCtrl.text.trim());
//   //     if (widget.autoCloseOnSuccess) Navigator.of(context).pop();
//   //   }
//   // }

//   // @override
//   // void dispose() {
//   //   _passCtrl.dispose();
//   //   super.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final l10n = context.l10n;
//     return WillPopScope(
//       onWillPop: () async => widget.canPop,
//       child: const CupertinoAlertDialog(
//           // title: Text(widget.title ?? l10n.unlockAccountPin),
//           // content: Padding(
//           //   padding: const EdgeInsets.only(top: 16),
//           // child: CupertinoTextFormFieldRow(
//           //   key: const Key('input-password-dialog'),
//           //   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
//           //   padding: EdgeInsets.zero,
//           //   autofocus: true,
//           //   keyboardType: TextInputType.number,
//           //   placeholder: l10n.passOld,
//           //   controller: _passCtrl,
//           //   validator: (v) {
//           //     if (v == null || !Fmt.checkPassword(v.trim())) return l10n.createPasswordError;

//           //     return null;
//           //   },
//           //   obscureText: true,
//           //   inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
//           // ),
//           // ),
//           // actions: <Widget>[
//           // if (widget.showCancelButton)
//           // CupertinoButton(
//           //   key: const Key('cancel-button'),
//           //   onPressed: () => Navigator.pop(context),
//           //   child: Text(l10n.cancel),
//           // ),
//           // CupertinoButton(
//           //   key: const Key('password-ok'),
//           //   onPressed: _submitting ? null : _onOk,
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     children: [
//           //       if (_submitting) const CupertinoActivityIndicator(),
//           //       Text(l10n.ok),
//           //     ],
//           //   ),
//           // ),
//           // ],
//           ),
//     );
//   }
// }
