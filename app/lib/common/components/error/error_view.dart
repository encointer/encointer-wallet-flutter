import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/l10.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    this.errorMessage,
    this.onRetryPressed,
  });

  final String? errorMessage;
  final VoidCallback? onRetryPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 70),
          const SizedBox(height: 40),
          Text(
            l10n.error,
            style: context.headlineMedium.copyWith(color: AppColors.encointerGrey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            errorMessage ?? l10n.unknownError,
            style: context.titleLarge.copyWith(color: AppColors.encointerGrey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          if (onRetryPressed != null)
            ElevatedButton(
              onPressed: onRetryPressed,
              child: Text(l10n.retry),
            ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
