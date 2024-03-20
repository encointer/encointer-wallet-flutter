// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// Error for the treasury pallet.
enum Error {
  /// Proposer's balance is too low.
  insufficientProposersBalance('InsufficientProposersBalance', 0),

  /// No proposal, bounty or spend at that index.
  invalidIndex('InvalidIndex', 1),

  /// Too many approvals in the queue.
  tooManyApprovals('TooManyApprovals', 2),

  /// The spend origin is valid but the amount it is allowed to spend is lower than the
  /// amount to be spent.
  insufficientPermission('InsufficientPermission', 3),

  /// Proposal has not been approved.
  proposalNotApproved('ProposalNotApproved', 4),

  /// The balance of the asset kind is not convertible to the balance of the native asset.
  failedToConvertBalance('FailedToConvertBalance', 5),

  /// The spend has expired and cannot be claimed.
  spendExpired('SpendExpired', 6),

  /// The spend is not yet eligible for payout.
  earlyPayout('EarlyPayout', 7),

  /// The payment has already been attempted.
  alreadyAttempted('AlreadyAttempted', 8),

  /// There was some issue with the mechanism of payment.
  payoutError('PayoutError', 9),

  /// The payout was not yet attempted/claimed.
  notAttempted('NotAttempted', 10),

  /// The payment has neither failed nor succeeded yet.
  inconclusive('Inconclusive', 11);

  const Error(
    this.variantName,
    this.codecIndex,
  );

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ErrorCodec codec = $ErrorCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Error.insufficientProposersBalance;
      case 1:
        return Error.invalidIndex;
      case 2:
        return Error.tooManyApprovals;
      case 3:
        return Error.insufficientPermission;
      case 4:
        return Error.proposalNotApproved;
      case 5:
        return Error.failedToConvertBalance;
      case 6:
        return Error.spendExpired;
      case 7:
        return Error.earlyPayout;
      case 8:
        return Error.alreadyAttempted;
      case 9:
        return Error.payoutError;
      case 10:
        return Error.notAttempted;
      case 11:
        return Error.inconclusive;
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
