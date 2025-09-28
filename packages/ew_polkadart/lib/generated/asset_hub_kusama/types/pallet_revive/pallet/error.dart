// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Invalid schedule supplied, e.g. with zero weight of a basic operation.
  invalidSchedule('InvalidSchedule', 1),

  /// Invalid combination of flags supplied to `seal_call` or `seal_delegate_call`.
  invalidCallFlags('InvalidCallFlags', 2),

  /// The executed contract exhausted its gas limit.
  outOfGas('OutOfGas', 3),

  /// Performing the requested transfer failed. Probably because there isn't enough
  /// free balance in the sender's account.
  transferFailed('TransferFailed', 4),

  /// Performing a call was denied because the calling depth reached the limit
  /// of what is specified in the schedule.
  maxCallDepthReached('MaxCallDepthReached', 5),

  /// No contract was found at the specified address.
  contractNotFound('ContractNotFound', 6),

  /// No code could be found at the supplied code hash.
  codeNotFound('CodeNotFound', 7),

  /// No code info could be found at the supplied code hash.
  codeInfoNotFound('CodeInfoNotFound', 8),

  /// A buffer outside of sandbox memory was passed to a contract API function.
  outOfBounds('OutOfBounds', 9),

  /// Input passed to a contract API function failed to decode as expected type.
  decodingFailed('DecodingFailed', 10),

  /// Contract trapped during execution.
  contractTrapped('ContractTrapped', 11),

  /// Event body or storage item exceeds [`limits::PAYLOAD_BYTES`].
  valueTooLarge('ValueTooLarge', 12),

  /// Termination of a contract is not allowed while the contract is already
  /// on the call stack. Can be triggered by `seal_terminate`.
  terminatedWhileReentrant('TerminatedWhileReentrant', 13),

  /// `seal_call` forwarded this contracts input. It therefore is no longer available.
  inputForwarded('InputForwarded', 14),

  /// The amount of topics passed to `seal_deposit_events` exceeds the limit.
  tooManyTopics('TooManyTopics', 15),

  /// A contract with the same AccountId already exists.
  duplicateContract('DuplicateContract', 18),

  /// A contract self destructed in its constructor.
  ///
  /// This can be triggered by a call to `seal_terminate`.
  terminatedInConstructor('TerminatedInConstructor', 19),

  /// A call tried to invoke a contract that is flagged as non-reentrant.
  reentranceDenied('ReentranceDenied', 20),

  /// A contract called into the runtime which then called back into this pallet.
  reenteredPallet('ReenteredPallet', 21),

  /// A contract attempted to invoke a state modifying API while being in read-only mode.
  stateChangeDenied('StateChangeDenied', 22),

  /// Origin doesn't have enough balance to pay the required storage deposits.
  storageDepositNotEnoughFunds('StorageDepositNotEnoughFunds', 23),

  /// More storage was created than allowed by the storage deposit limit.
  storageDepositLimitExhausted('StorageDepositLimitExhausted', 24),

  /// Code removal was denied because the code is still in use by at least one contract.
  codeInUse('CodeInUse', 25),

  /// The contract ran to completion but decided to revert its storage changes.
  /// Please note that this error is only returned from extrinsics. When called directly
  /// or via RPC an `Ok` will be returned. In this case the caller needs to inspect the flags
  /// to determine whether a reversion has taken place.
  contractReverted('ContractReverted', 26),

  /// The contract failed to compile or is missing the correct entry points.
  ///
  /// A more detailed error can be found on the node console if debug messages are enabled
  /// by supplying `-lruntime::revive=debug`.
  codeRejected('CodeRejected', 27),

  /// The code blob supplied is larger than [`limits::code::BLOB_BYTES`].
  blobTooLarge('BlobTooLarge', 28),

  /// The contract declares too much memory (ro + rw + stack).
  staticMemoryTooLarge('StaticMemoryTooLarge', 29),

  /// The program contains a basic block that is larger than allowed.
  basicBlockTooLarge('BasicBlockTooLarge', 30),

  /// The program contains an invalid instruction.
  invalidInstruction('InvalidInstruction', 31),

  /// The contract has reached its maximum number of delegate dependencies.
  maxDelegateDependenciesReached('MaxDelegateDependenciesReached', 32),

  /// The dependency was not found in the contract's delegate dependencies.
  delegateDependencyNotFound('DelegateDependencyNotFound', 33),

  /// The contract already depends on the given delegate dependency.
  delegateDependencyAlreadyExists('DelegateDependencyAlreadyExists', 34),

  /// Can not add a delegate dependency to the code hash of the contract itself.
  cannotAddSelfAsDelegateDependency('CannotAddSelfAsDelegateDependency', 35),

  /// Can not add more data to transient storage.
  outOfTransientStorage('OutOfTransientStorage', 36),

  /// The contract tried to call a syscall which does not exist (at its current api level).
  invalidSyscall('InvalidSyscall', 37),

  /// Invalid storage flags were passed to one of the storage syscalls.
  invalidStorageFlags('InvalidStorageFlags', 38),

  /// PolkaVM failed during code execution. Probably due to a malformed program.
  executionFailed('ExecutionFailed', 39),

  /// Failed to convert a U256 to a Balance.
  balanceConversionFailed('BalanceConversionFailed', 40),

  /// Immutable data can only be set during deploys and only be read during calls.
  /// Additionally, it is only valid to set the data once and it must not be empty.
  invalidImmutableAccess('InvalidImmutableAccess', 42),

  /// An `AccountID32` account tried to interact with the pallet without having a mapping.
  ///
  /// Call [`Pallet::map_account`] in order to create a mapping for the account.
  accountUnmapped('AccountUnmapped', 43),

  /// Tried to map an account that is already mapped.
  accountAlreadyMapped('AccountAlreadyMapped', 44),

  /// The transaction used to dry-run a contract is invalid.
  invalidGenericTransaction('InvalidGenericTransaction', 45),

  /// The refcount of a code either over or underflowed.
  refcountOverOrUnderflow('RefcountOverOrUnderflow', 46),

  /// Unsupported precompile address.
  unsupportedPrecompileAddress('UnsupportedPrecompileAddress', 47),

  /// The calldata exceeds [`limits::CALLDATA_BYTES`].
  callDataTooLarge('CallDataTooLarge', 48),

  /// The return data exceeds [`limits::CALLDATA_BYTES`].
  returnDataTooLarge('ReturnDataTooLarge', 49);

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
      case 1:
        return Error.invalidSchedule;
      case 2:
        return Error.invalidCallFlags;
      case 3:
        return Error.outOfGas;
      case 4:
        return Error.transferFailed;
      case 5:
        return Error.maxCallDepthReached;
      case 6:
        return Error.contractNotFound;
      case 7:
        return Error.codeNotFound;
      case 8:
        return Error.codeInfoNotFound;
      case 9:
        return Error.outOfBounds;
      case 10:
        return Error.decodingFailed;
      case 11:
        return Error.contractTrapped;
      case 12:
        return Error.valueTooLarge;
      case 13:
        return Error.terminatedWhileReentrant;
      case 14:
        return Error.inputForwarded;
      case 15:
        return Error.tooManyTopics;
      case 18:
        return Error.duplicateContract;
      case 19:
        return Error.terminatedInConstructor;
      case 20:
        return Error.reentranceDenied;
      case 21:
        return Error.reenteredPallet;
      case 22:
        return Error.stateChangeDenied;
      case 23:
        return Error.storageDepositNotEnoughFunds;
      case 24:
        return Error.storageDepositLimitExhausted;
      case 25:
        return Error.codeInUse;
      case 26:
        return Error.contractReverted;
      case 27:
        return Error.codeRejected;
      case 28:
        return Error.blobTooLarge;
      case 29:
        return Error.staticMemoryTooLarge;
      case 30:
        return Error.basicBlockTooLarge;
      case 31:
        return Error.invalidInstruction;
      case 32:
        return Error.maxDelegateDependenciesReached;
      case 33:
        return Error.delegateDependencyNotFound;
      case 34:
        return Error.delegateDependencyAlreadyExists;
      case 35:
        return Error.cannotAddSelfAsDelegateDependency;
      case 36:
        return Error.outOfTransientStorage;
      case 37:
        return Error.invalidSyscall;
      case 38:
        return Error.invalidStorageFlags;
      case 39:
        return Error.executionFailed;
      case 40:
        return Error.balanceConversionFailed;
      case 42:
        return Error.invalidImmutableAccess;
      case 43:
        return Error.accountUnmapped;
      case 44:
        return Error.accountAlreadyMapped;
      case 45:
        return Error.invalidGenericTransaction;
      case 46:
        return Error.refcountOverOrUnderflow;
      case 47:
        return Error.unsupportedPrecompileAddress;
      case 48:
        return Error.callDataTooLarge;
      case 49:
        return Error.returnDataTooLarge;
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
