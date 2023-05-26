// copied from the `flutter_bloc` package
// https://github.com/felangel/bloc/blob/master/packages/flutter_bloc/lib/src/multi_repository_provider.dart
// https://github.com/felangel/bloc/blob/master/packages/flutter_bloc/lib/src/repository_provider.dart

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// {@template multi_repository_provider}
/// Merges multiple [RepositoryProvider] widgets into one widget tree.
///
/// [MultiRepositoryProvider] improves the readability and eliminates the need
/// to nest multiple [RepositoryProvider]s.
///
/// By using [MultiRepositoryProvider] we can go from:
///
/// ```dart
/// RepositoryProvider<RepositoryA>(
///   create: (context) => RepositoryA(),
///   child: RepositoryProvider<RepositoryB>(
///     create: (context) => RepositoryB(),
///     child: RepositoryProvider<RepositoryC>(
///       create: (context) => RepositoryC(),
///       child: ChildA(),
///     )
///   )
/// )
/// ```
///
/// to:
///
/// ```dart
/// MultiRepositoryProvider(
///   providers: [
///     RepositoryProvider<RepositoryA>(create: (context) => RepositoryA()),
///     RepositoryProvider<RepositoryB>(create: (context) => RepositoryB()),
///     RepositoryProvider<RepositoryC>(create: (context) => RepositoryC()),
///   ],
///   child: ChildA(),
/// )
/// ```
///
/// [MultiRepositoryProvider] converts the [RepositoryProvider] list into a tree
/// of nested [RepositoryProvider] widgets.
/// As a result, the only advantage of using [MultiRepositoryProvider] is
/// improved readability due to the reduction in nesting and boilerplate.
/// {@endtemplate}
class MultiRepositoryProvider extends MultiProvider {
  /// {@macro multi_repository_provider}
  MultiRepositoryProvider({
    super.key,
    required super.providers,
    required Widget super.child,
  });
}

/// {@template repository_provider}
/// Takes a [Create] function that is responsible for creating the repository
/// and a `child` which will have access to the repository via
/// `RepositoryProvider.of(context)`.
/// It is used as a dependency injection (DI) widget so that a single instance
/// of a repository can be provided to multiple widgets within a subtree.
///
/// ```dart
/// RepositoryProvider(
///   create: (context) => RepositoryA(),
///   child: ChildA(),
/// );
/// ```
///
/// Lazily creates the repository unless `lazy` is set to `false`.
///
/// ```dart
/// RepositoryProvider(
///   lazy: false,`
///   create: (context) => RepositoryA(),
///   child: ChildA(),
/// );
/// ```
/// {@endtemplate}
class RepositoryProvider<T> extends Provider<T> {
  /// {@macro repository_provider}
  RepositoryProvider({
    super.key,
    required super.create,
    super.child,
    super.lazy,
  }) : super(dispose: (_, __) {});

  /// Takes a repository and a [child] which will have access to the repository.
  /// A new repository should not be created in `RepositoryProvider.value`.
  /// Repositories should always be created using the default constructor
  /// within the [Create] function.
  RepositoryProvider.value({
    super.key,
    required super.value,
    super.child,
  }) : super.value();

  /// Method that allows widgets to access a repository instance as long as
  /// their `BuildContext` contains a [RepositoryProvider] instance.
  static T of<T>(BuildContext context, {bool listen = false}) {
    try {
      return Provider.of<T>(context, listen: listen);
    } on ProviderNotFoundException catch (e) {
      if (e.valueType != T) rethrow;
      throw FlutterError(
        '''
        RepositoryProvider.of() called with a context that does not contain a repository of type $T.
        No ancestor could be found starting from the context that was passed to RepositoryProvider.of<$T>().
        This can happen if the context you used comes from a widget above the RepositoryProvider.
        The context used was: $context
        ''',
      );
    }
  }
}
