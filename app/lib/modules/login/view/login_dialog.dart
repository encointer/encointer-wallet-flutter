import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/config/biometric_auth_state.dart';
import 'package:encointer_wallet/service/service.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';

@immutable
final class LoginDialog {
  static Future<void> showToggleBiometricAuthAlert(BuildContext context) {
    final loginStore = context.read<LoginStore>();
    final l10n = context.l10n;
    return AppAlert.showConfirmDialog<void>(
      context: context,
      title: Text(l10n.biometricAuth),
      content: Text(l10n.biometricAuthDescription),
      cancelButtonKey: const Key(EWTestKeys.notNowButton),
      cancelText: l10n.notNow,
      confirmText: l10n.enable,
      onOK: () async {
        await loginStore.setBiometricAuthState(BiometricAuthState.enabled);
        Navigator.pop(context);
      },
      onCancel: () async {
        await loginStore.setBiometricAuthState(BiometricAuthState.disabled);
        Navigator.pop(context);
      },
    );
  }

  static Future<void> switchBiometricAuth(BuildContext context, {required bool isEnable}) => isEnable
      ? showLocalAuth(
          context,
          titleText: context.l10n.biometricAuthEnableDisableDescription,
          onSuccess: () => context.read<LoginStore>().setBiometricAuthState(BiometricAuthState.enabled),
        )
      : showPasswordInputDialog(
          context,
          titleText: context.l10n.biometricAuthEnableDisableDescription,
          onSuccess: () => context.read<LoginStore>().setBiometricAuthState(BiometricAuthState.disabled),
        );

  static Future<void> verifyPinOrBioAuth(
    BuildContext context, {
    Future<void> Function()? onSuccess,
    bool barrierDismissible = true,
    bool showCancelButton = true,
    bool canPop = true,
    bool stickyAuth = false,
    String? titleText,
  }) async {
    final loginStore = context.read<LoginStore>();
    if (loginStore.getBiometricAuthState?.isEnabled ?? false) {
      try {
        await showLocalAuth(
          context,
          onSuccess: onSuccess,
          stickyAuth: stickyAuth,
          titleText: titleText,
        );
      } catch (e, s) {
        Log.e('$e', 'LoginDialog: error with biometrics, fallback to PIN dialog', s);
        await showPasswordInputDialog(
          context,
          onSuccess: onSuccess,
          barrierDismissible: barrierDismissible,
          showCancelButton: showCancelButton,
          canPop: canPop,
          titleText: titleText,
        );
      }
    } else {
      await showPasswordInputDialog(
        context,
        onSuccess: onSuccess,
        barrierDismissible: barrierDismissible,
        showCancelButton: showCancelButton,
        canPop: canPop,
        titleText: titleText,
      );
    }
  }

  static Future<void> showLocalAuth(
    BuildContext context, {
    required Future<void> Function()? onSuccess,
    String? titleText,
    bool stickyAuth = false,
  }) async {
    final loginStore = context.read<LoginStore>();
    try {
      final success = await loginStore.localAuthenticate(titleText ?? context.l10n.verifyAuthTitle('true'), stickyAuth);

      if (success) {
        loginStore.cachedPin = await loginStore.loginService.getPin();

        if (loginStore.cachedPin == null) {
          throw Exception(['Pin retrieved from storage is null, fatal error']);
        }

        if (onSuccess != null) await onSuccess();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> showPasswordInputDialog(
    BuildContext context, {
    Future<void> Function()? onSuccess,
    bool barrierDismissible = true,
    bool showCancelButton = true,
    bool canPop = true,
    String? titleText,
  }) async {
    final l10n = context.l10n;
    final passCtrl = TextEditingController();
    final loginStore = context.read<LoginStore>();
    return AppAlert.showDialog(
      context,
      barrierDismissible: barrierDismissible,
      title: Text(titleText ?? l10n.verifyAuthTitle('false')),
      content: CupertinoTextFormFieldRow(
        key: const Key(EWTestKeys.inputPasswordDialog),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.zero,
        autofocus: true,
        keyboardType: TextInputType.number,
        placeholder: l10n.passOld,
        controller: passCtrl,
        validator: (v) => validatePasswordInputField(v, l10n),
        obscureText: true,
        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
      ),
      actions: [
        if (showCancelButton)
          CupertinoButton(
            key: const Key(EWTestKeys.cancelButton),
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        PopScope(
          onPopInvoked: (bool didPop) async => canPop,
          child: CupertinoButton(
            key: const Key(EWTestKeys.passwordOk),
            onPressed: () async {
              loginStore.loading = true;
              final success = await _checkPassword(context, passCtrl.text.trim());
              if (success) {
                loginStore.cachedPin = passCtrl.text.trim();

                if (onSuccess != null) await onSuccess();

                Navigator.of(context).pop();
              } else {
                AppAlert.showErrorDialog(
                  context,
                  errorText: l10n.wrongPinHint,
                  buttontext: l10n.ok,
                  title: Text(l10n.wrongPin),
                );
              }
              loginStore.loading = false;
            },
            child: Observer(builder: (_) {
              return loginStore.loading ? const CupertinoActivityIndicator() : Text(l10n.ok);
            }),
          ),
        ),
      ],
    );
  }

  static Future<bool> _checkPassword(BuildContext context, String password) async {
    final loginStore = context.read<LoginStore>();
    return loginStore.isValid(password);
  }

  static String? validatePasswordInputField(String? value, AppLocalizations l10n) {
    return value == null || !Fmt.checkPassword(value.trim()) ? l10n.createPasswordError : null;
  }
}
