import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.color,
    this.expand,
    this.submitting = false,
  });

  final String text;
  final void Function()? onPressed;
  final Widget? icon;
  final Color? color;
  final bool? expand;
  final bool submitting;

  @override
  Widget build(BuildContext context) {
    final row = <Widget>[];
    if (submitting) {
      row.add(const CupertinoActivityIndicator());
    }
    if (icon != null) {
      row.add(
        SizedBox(
          width: 32,
          child: icon,
        ),
      );
    }
    row.add(Text(
      text,
      style: context.labelLarge,
    ));
    return ElevatedButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        backgroundColor: color ?? context.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: submitting ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: row,
      ),
    );
  }
}
