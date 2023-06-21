import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/config/biometiric_auth_state.dart';
import 'package:encointer_wallet/service/service.dart';
// import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';

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

  static Future<void> askPin(
    BuildContext context, {
    required Future<void> Function(String password) onSuccess,
    bool barrierDismissible = false,
    bool autoCloseOnSuccess = true,
    bool showCancelButton = false,
    bool canPop = true,
    String? titleText,
  }) async {
    final loginStore = context.read<LoginStore>();
    if (loginStore.getBiometricAuthState == BiometricAuthState.enabled && loginStore.cachedPin.isNotEmpty) {
      await _showLocalAuth(context, onSuccess: onSuccess);
    } else {
      await _showPasswordInputDialog(
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

  static Future<void> _showLocalAuth(
    BuildContext context, {
    required Future<void> Function(String password) onSuccess,
  }) async {
    final loginStore = context.read<LoginStore>();
    final value = await loginStore.localAuthenticate(context);
    if (value) await onSuccess(loginStore.cachedPin);
  }

  static Future<void> _showPasswordInputDialog(
    BuildContext context, {
    required Future<void> Function(String password) onSuccess,
    bool barrierDismissible = false,
    bool autoCloseOnSuccess = true,
    bool showCancelButton = false,
    bool canPop = true,
    String? titleText,
  }) async {
    final l10n = context.l10n;
    final passCtrl = TextEditingController();
    return AppAlert.showDialog(
      context,
      title: Text(titleText ?? l10n.unlockAccountPin),
      content: CupertinoTextFormFieldRow(
        key: const Key('input-password-dialog'),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.zero,
        autofocus: true,
        keyboardType: TextInputType.number,
        placeholder: l10n.passOld,
        controller: passCtrl,
        validator: (v) {
          if (v == null || !Fmt.checkPassword(v.trim())) return l10n.createPasswordError;
          return null;
        },
        obscureText: true,
        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
      ),
      barrierDismissible: barrierDismissible,
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
              final loginStore = context.read<LoginStore>();
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
            },
            child: Text(l10n.ok),
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
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:mobx/mobx.dart';
// import 'package:provider/provider.dart';

// import 'package:encointer_wallet/modules/modules.dart';
// import 'package:encointer_wallet/common/components/buttons/circle_button.dart';
// import 'package:encointer_wallet/modules/login/widget/widget.dart';
// import 'package:encointer_wallet/config/biometiric_auth_state.dart';
// import 'package:encointer_wallet/service/auth/local_auth_service.dart';
// import 'package:encointer_wallet/presentation/home/views/home_page.dart';
// import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
// import 'package:encointer_wallet/utils/alerts/app_alert.dart';
// import 'package:encointer_wallet/utils/utils.dart';
// import 'package:encointer_wallet/store/app.dart';
// import 'package:encointer_wallet/l10n/l10.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   static const route = '/login';

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       if (context.read<AppSettings>().biometricAuthState == BiometricAuthState.enabled) {
//         final localAuthService = RepositoryProvider.of<LocalAuthService>(context);
//         final value = await localAuthService.localAuthenticate(context.l10n.localizedReason);
//         await navigate(isPinCorrect: value, l10n: context.l10n);
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final loginStore = context.watch<LoginStore>();
//     final appStore = context.watch<AppStore>();
//     final cachedPin = appStore.settings.cachedPin;
//     final l10n = context.l10n;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${context.l10n.welcome} ${appStore.account.currentAccount.name}'),
//       ),
//       body: SingleChildScrollView(
//         child: ReactionBuilder(
//           builder: (BuildContext context) {
//             return reaction<bool>((r) => loginStore.pinCode.length == cachedPin.length, (v) async {
//               if (v) {
//                 final value = context.read<LoginStore>().usePincodeAuth(context);
//                 await navigate(isPinCorrect: value, l10n: l10n);
//               }
//             });
//           },
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height * 0.8,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Observer(builder: (_) {
//                   return PinDots(loginStore.pinCode.length, maxLength: cachedPin.length);
//                 }),
//                 PinKeyboard(
//                   onTapDigit: (value) => context.read<LoginStore>().addDigit(value, cachedPin.length),
//                   removeLastDigit: context.read<LoginStore>().removeLastDigit,
//                   biometricWidget: Observer(builder: (_) {
//                     return switch (context.read<AppSettings>().biometricAuthState) {
//                       BiometricAuthState.enabled => CircleButton(
//                           child: const Icon(Icons.fingerprint),
//                           onPressed: () async {
//                             final value = await RepositoryProvider.of<LocalAuthService>(context)
//                                 .localAuthenticate(context.l10n.localizedReason);
//                             await navigate(isPinCorrect: value, l10n: context.l10n);
//                           },
//                         ),
//                       _ => const SizedBox.shrink(),
//                     };
//                   }),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> navigate({required bool isPinCorrect, required AppLocalizations l10n}) async {
//     if (isPinCorrect) {
//       await Navigator.pushNamedAndRemoveUntil(context, EncointerHomePage.route, (route) => false);
//     } else {
//       await AppAlert.showDialog<void>(
//         context,
//         barrierDismissible: true,
//         title: Text(
//           l10n.pinError,
//           style: context.textTheme.titleMedium!.copyWith(color: context.colorScheme.error),
//         ),
//         actions: <Widget>[
//           CupertinoButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text(l10n.ok),
//           ),
//         ],
//       );
//     }
//   }
// }
