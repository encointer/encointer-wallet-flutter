import 'package:meta/meta.dart';

abstract class Either<R, L> {
  const Either();

  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);
}

@immutable
class Right<R, L> extends Either<R, L> {
  const Right(this.r);

  final R r;

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifRight(r);

  @override
  bool operator ==(Object other) => other is Right && other.r == r;
  @override
  int get hashCode => r.hashCode;
}

@immutable
class Left<R, L> extends Either<R, L> {
  const Left(this.l);

  final L l;

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifLeft(l);

  @override
  bool operator ==(Object other) => other is Left && other.l == l;
  @override
  int get hashCode => l.hashCode;
}
