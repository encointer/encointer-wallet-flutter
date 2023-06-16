import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/utils/alerts/password_input_dialog.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/config/biometiric_auth_state.dart';
import 'package:encointer_wallet/modules/modules.dart';

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
    String? confirmText,
    String? cancelText,
  }) {
    final l10n = context.l10n;
    return showCupertinoDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title,
          content: content,
          actions: <Widget>[
            CupertinoButton(
              onPressed: onCancel,
              child: Text(cancelText ?? l10n.cancel),
            ),
            CupertinoButton(
              key: const Key('ok-button'),
              onPressed: onOK,
              child: Text(confirmText ?? l10n.ok),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showToggleBiometricAuthAlert(BuildContext context) {
    final appSettings = context.read<AppSettings>();
    return showConfirmDialog<void>(
      context: context,
      title: const Text('Biometric Authentication'),
      content: const Text(
          'Biometric authentication uses the biometric information stored on your phone to authenticate you, instead of using your pin. You can enable and disable biometric authentication anytime in the settings.'),
      cancelText: 'Not now',
      confirmText: 'Enable',
      onOK: () async {
        await appSettings.setBiometricAuthState(BiometricAuthState.enabled);
        Navigator.pop(context);
      },
      onCancel: () async {
        await appSettings.setBiometricAuthState(BiometricAuthState.disabled);
        Navigator.pop(context);
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

  static Future<bool?> showPasswordInputDialog(
    BuildContext context, {
    required AccountData account,
    required Future<void> Function(String) onSuccess,
    bool canPop = true,
    bool showCancelButton = false,
    bool autoCloseOnSuccess = true,
    String? title,
  }) async {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return PasswordInputDialog(
          title: title,
          account: account,
          onSuccess: onSuccess,
          canPop: canPop,
          showCancelButton: showCancelButton,
          autoCloseOnSuccess: autoCloseOnSuccess,
        );
      },
    );
  }
}
