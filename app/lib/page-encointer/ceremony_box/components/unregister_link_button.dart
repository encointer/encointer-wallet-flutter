import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';

class UnregisteredLinkButton extends StatelessWidget {
  const UnregisteredLinkButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Buluşmaya kaydolduğunuzda, bu buluşma yalnızca kayıt olanlar ',
            style: textTheme.headlineMedium!.copyWith(color: encointerGrey),
          ),
          TextSpan(
            text: 'Kaydı İptal Et',
            style: textTheme.headlineMedium!.copyWith(color: encointerGrey, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final value = await AppAlert.showConfirmDialog<bool>(
                  context: context,
                  cancelValue: false,
                  title: const Text('Unregister'),
                  content: const Text(
                    'Bu açıklama, kullanıcılara buluşmanın sadece kayıt olanlar için olduğunu ve kaydın, kullanıcılara özel içerik sağlamak için kullanıldığını açıklamaktadıregister',
                  ),
                  onOK: () => Navigator.pop(context, true),
                );
                if (value ?? false) {
                  AppAlert.showLoadingDialog(context, 'Loading');
                }
              },
          ),
        ],
      ),
    );
  }
}
