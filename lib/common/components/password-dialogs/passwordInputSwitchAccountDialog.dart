// import 'package:encointer_wallet/common/components/password-dialogs/passwordInputDialogBase.dart';
// import 'package:encointer_wallet/page/networkSelectPage.dart';
// import 'package:flutter/cupertino.dart';
//
// class PasswordInputSwitchAccountDialog extends PasswordInputDialogBase {
//   PasswordInputSwitchAccountDialog({account, title, onOk, this.onAccountSwitch})
//       : super(account: account, title: title, onOk: onOk);
//   final Function onAccountSwitch;
//
//   @override
//   _PasswordInputSwitchAccountDialog createState() => _PasswordInputSwitchAccountDialog();
// }
//
// class _PasswordInputSwitchAccountDialog extends PasswordInputDialogBaseState<PasswordInputSwitchAccountDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return PasswordInputDialogBase(
//         onAccountSwitch: () async => {
//           Navigator.of(context).pop(),
//           await Navigator.of(context).pushNamed(NetworkSelectPage.route),
//           setState(() {}),
//           }
//     );
//   }
// }
//
