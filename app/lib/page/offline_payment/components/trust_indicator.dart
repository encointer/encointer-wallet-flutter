import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';

class TrustIndicator extends StatelessWidget {
  const TrustIndicator({required this.reputationCount, super.key});

  final int reputationCount;

  @override
  Widget build(BuildContext context) {
    final (color, label) = _trustLevel;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_user, color: color, size: 20),
          const SizedBox(width: 8),
          Text(label, style: context.bodyMedium.copyWith(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  (Color, String) get _trustLevel {
    if (reputationCount >= 5) return (Colors.green, 'Verified in $reputationCount ceremonies');
    if (reputationCount >= 2) return (Colors.orange, 'Verified in $reputationCount ceremonies');
    if (reputationCount == 1) return (Colors.orange, 'Verified in 1 ceremony');
    return (Colors.red, 'No reputation');
  }
}
