
import 'package:encointer_wallet/utils/format.dart';
import 'package:ew_l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Ensures that the number is positive (doubles)
String? validatePositiveNumber(BuildContext context, String? value) {
  return validatePositiveNumberWithMax(context, value, null);
}

/// Ensures that the number is positive (doubles)
String? validatePositiveNumberWithMax(BuildContext context, String? value, double? max) {
  final l10n = context.l10n;
  if (value == null || value.isEmpty) {
    return l10n.proposalFieldErrorEnterPositiveNumber;
  } else {
    final number = double.tryParse(value);
    if (number == null || number <= 0) {
      return l10n.proposalFieldErrorPositiveNumberRange;
    } else if (max != null && number > max) {
      final maxFmt = Fmt.formatNumber(context, max, decimals: 4);
      return l10n.proposalFieldErrorPositiveNumberTooBig(maxFmt);
    } else {
      return null;
    }
  }
}
