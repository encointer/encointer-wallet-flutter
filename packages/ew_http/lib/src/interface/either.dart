import 'package:meta/meta.dart';

/// The Either class is an abstract class representing right and left values.
/// ```dart
/// void main() {
///   // Creating a Right instance representing the right value.
///   final rightValue = Right<int, String>(42);
///
///   // Creating a Left instance representing the left value.
///   final leftValue = Left<int, String>('Error');
///
///   // Values can be processed using the fold method.
///
///   // Calling fold on rightValue.
///   final rightResult = rightValue.fold(
///     (error) => 'Left: $error', // This function is executed if there is no right value.
///     (value) => 'Right: $value', // This function is executed if there is a right value.
///   );
///   print(rightResult); // Output: "Right: 42"
///
///   // Calling fold on leftValue.
///   final leftResult = leftValue.fold(
///     (error) => 'Left: $error', // This function is executed if there is a left value.
///     (value) => 'Right: $value', // This function is executed if there is no left value.
///   );
///   print(leftResult); // Output: "Left: Error"
/// }
/// ```
abstract class Either<R, L> {
  const Either();

  /// The fold method allows performing operations based on right and left values.
  /// B is a type parameter and it performs operations using the ifLeft and ifRight functions.
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);
}

/// The Right class is derived from the Either class and represents the right value.
/// ```dart
/// void main() {
///   // Creating a Right instance representing the right value.
///   final rightValue = Right<int, String>(42);
///
///   // Calling fold on rightValue.
///   final rightResult = rightValue.fold(
///     (error) => 'Left: $error', // This function is executed if there is no right value.
///     (value) => 'Right: $value', // This function is executed if there is a right value.
///   );
///   print(rightResult); // Output: "Right: 42"
/// }
/// ```
@immutable
class Right<R, L> extends Either<R, L> {
  const Right(this.r);

  /// A field is defined to hold the right value.
  final R r;

  /// The fold method invokes the ifRight function using the right value and returns the result.
  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifRight(r);

  /// Equality check is defined for operator == and hashCode is computed for hashing.
  @override
  bool operator ==(Object other) => other is Right && other.r == r;
  @override
  int get hashCode => r.hashCode;
}

/// The Left class is derived from the Either class and represents the left value.
/// ```dart
/// void main() {
///   // Creating a Left instance representing the left value.
///   final leftValue = Left<int, String>('Error');
///
///   // Calling fold on leftValue.
///   final leftResult = leftValue.fold(
///     (error) => 'Left: $error', // This function is executed if there is a left value.
///     (value) => 'Right: $value', // This function is executed if there is no left value.
///   );
///   print(leftResult); // Output: "Left:
/// }
/// ```
@immutable
class Left<R, L> extends Either<R, L> {
  const Left(this.l);

  /// A field is defined to hold the left value.
  final L l;

  /// The fold method invokes the ifLeft function using the left value and returns the result.
  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifLeft(l);

  /// Equality check is defined for operator == and hashCode is computed for hashing.
  @override
  bool operator ==(Object other) => other is Left && other.l == l;
  @override
  int get hashCode => l.hashCode;
}
