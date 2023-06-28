import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/config/biometiric_auth_state.dart';
import 'package:encointer_wallet/service/service.dart';
import 'package:encointer_wallet/store/app.dart';
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
      cancelButtonKey: const Key('not-now-button'),
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
          onSuccess: (_) => context.read<LoginStore>().setBiometricAuthState(BiometricAuthState.enabled),
        )
      : showPasswordInputDialog(
          context,
          titleText: context.l10n.biometricAuthEnableDisableDescription,
          onSuccess: (_) => context.read<LoginStore>().setBiometricAuthState(BiometricAuthState.disabled),
        );

  static Future<void> verifyPinOrBioAuth(
    BuildContext context, {
    required Future<void> Function(String password) onSuccess,
    bool barrierDismissible = true,
    bool autoCloseOnSuccess = true,
    bool showCancelButton = true,
    bool canPop = true,
    bool stickyAuth = false,
    String? titleText,
  }) async {
    final loginStore = context.read<LoginStore>();
    if (loginStore.getBiometricAuthState == BiometricAuthState.enabled && loginStore.cachedPin.isNotEmpty) {
      await showLocalAuth(
        context,
        onSuccess: onSuccess,
        stickyAuth: stickyAuth,
        titleText: titleText,
      );
    } else {
      await showPasswordInputDialog(
        context,
        onSuccess: onSuccess,
        barrierDismissible: barrierDismissible,
        autoCloseOnSuccess: autoCloseOnSuccess,
        showCancelButton: showCancelButton,
        canPop: canPop,
        titleText: titleText,
      );
    }
  }

  static Future<void> showLocalAuth(
    BuildContext context, {
    required Future<void> Function(String password) onSuccess,
    String? titleText,
    bool stickyAuth = false,
  }) async {
    final loginStore = context.read<LoginStore>();
    final value = await loginStore.localAuthenticate(titleText ?? context.l10n.verifyAuthTitle('true'), stickyAuth);
    if (value) await onSuccess(loginStore.cachedPin);
  }

  static Future<void> showPasswordInputDialog(
    BuildContext context, {
    required Future<void> Function(String password) onSuccess,
    bool barrierDismissible = true,
    bool autoCloseOnSuccess = true,
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
        key: const Key('input-password-dialog'),
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
            key: const Key('cancel-button'),
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        WillPopScope(
          onWillPop: () async => canPop,
          child: CupertinoButton(
            key: const Key('password-ok'),
            onPressed: () async {
              loginStore.loading = true;
              final value = await _onOk(context, passCtrl.text.trim());
              if (value) {
                if (loginStore.cachedPin.isEmpty) await loginStore.setPin(passCtrl.text.trim());
                await onSuccess(passCtrl.text.trim());
                if (autoCloseOnSuccess) Navigator.of(context).pop();
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

  static Future<bool> _onOk(BuildContext context, String password) async {
    final appStore = context.read<AppStore>();
    final res = await webApi.account.checkAccountPassword(appStore.account.currentAccount, password);
    if (res == null) return false;
    return true;
  }

  static String? validatePasswordInputField(String? value, AppLocalizations l10n) {
    return value == null || !Fmt.checkPassword(value.trim()) ? l10n.createPasswordError : null;
  }
}
