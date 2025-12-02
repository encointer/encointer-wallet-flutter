import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:ew_l10n/l10n.dart';
import 'package:flutter/material.dart';

const logTarget = 'FieldValidation';

/// Ensures that the number is positive (doubles)
String? validatePositiveNumberString(BuildContext context, String? value) {
  return validatePositiveNumber(context, double.tryParse(value ?? ''));
}

/// Ensures that the number is positive (doubles)
String? validatePositiveNumber(BuildContext context, double? value) {
  return validatePositiveNumberWithMax(context, value, null);
}

/// Ensures that the number is positive (doubles)
String? validatePositiveNumberWithMax(BuildContext context, double? number, double? max) {
  final l10n = context.l10n;
  if (number == null) {
    return l10n.proposalFieldErrorEnterPositiveNumber;
  } else {
    if (number <= 0) {
      return l10n.proposalFieldErrorPositiveNumberRange;
    } else if (max != null && number > max) {
      final maxFmt = Fmt.formatNumber(context, max, decimals: 4);
      return l10n.proposalFieldErrorPositiveNumberTooBig(maxFmt);
    } else {
      return null;
    }
  }
}

String? validateSwapAmount(
  BuildContext context,
  String? ccAmountStr,
  double accountBalance,
  String symbol,
  double treasuryBalanceAsset,
  double exchangeRate,
) {
  final l10n = context.l10n;

  final e1 = validatePositiveNumberString(context, ccAmountStr);
  if (e1 != null) return e1;

  final ccAmount = double.parse(ccAmountStr!);

  final e2 = validatePositiveNumberWithMax(context, ccAmount, accountBalance);
  if (e2 != null) return l10n.insufficientBalance;

  // converted treasury asset → CC equivalent
  final swapLimitDesired = ccAmount / exchangeRate;
  final swapLimitMax = treasuryBalanceAsset * exchangeRate;
  Log.d('validateSwapAmount: treasuryBalance: $treasuryBalanceAsset', logTarget);
  Log.d('validateSwapAmount: swapLimitDesired: $swapLimitDesired $symbol}', logTarget);
  Log.d('validateSwapAmount: swapLimitMax: $swapLimitMax $symbol', logTarget);

  final e3 = validatePositiveNumberWithMax(context, swapLimitDesired, treasuryBalanceAsset);
  if (e3 != null) return l10n.treasuryBalanceTooLow(Fmt.formatNumber(context, swapLimitMax, decimals: 4), symbol);

  return null;
}
