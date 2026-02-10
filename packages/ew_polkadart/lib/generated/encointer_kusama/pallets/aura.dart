class Constants {
  Constants();

  /// The slot duration Aura should run with, expressed in milliseconds.
  /// The effective value of this type should not change while the chain is running.
  ///
  /// For backwards compatibility either use [`MinimumPeriodTimesTwo`] or a const.
  final BigInt slotDuration = BigInt.from(6000);
}
