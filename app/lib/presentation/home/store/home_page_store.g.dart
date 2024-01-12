// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageStore on _HomePageStoreBase, Store {
  late final _$appStoreAtom = Atom(name: '_HomePageStoreBase.appStore', context: context);

  @override
  AppStore get appStore {
    _$appStoreAtom.reportRead();
    return super.appStore;
  }

  bool _appStoreIsInitialized = false;

  @override
  set appStore(AppStore value) {
    _$appStoreAtom.reportWrite(value, _appStoreIsInitialized ? super.appStore : null, () {
      super.appStore = value;
      _appStoreIsInitialized = true;
    });
  }

  late final _$buildContextAtom = Atom(name: '_HomePageStoreBase.buildContext', context: context);

  @override
  BuildContext get buildContext {
    _$buildContextAtom.reportRead();
    return super.buildContext;
  }

  bool _buildContextIsInitialized = false;

  @override
  set buildContext(BuildContext value) {
    _$buildContextAtom.reportWrite(value, _buildContextIsInitialized ? super.buildContext : null, () {
      super.buildContext = value;
      _buildContextIsInitialized = true;
    });
  }

  late final _$postFrameCallbacksAsyncAction = AsyncAction('_HomePageStoreBase.postFrameCallbacks', context: context);

  @override
  Future<void> postFrameCallbacks() {
    return _$postFrameCallbacksAsyncAction.run(() => super.postFrameCallbacks());
  }

  late final _$didChangeAppLifecycleStateAsyncAction =
      AsyncAction('_HomePageStoreBase.didChangeAppLifecycleState', context: context);

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) {
    return _$didChangeAppLifecycleStateAsyncAction.run(() => super.didChangeAppLifecycleState(state));
  }

  late final _$_HomePageStoreBaseActionController = ActionController(name: '_HomePageStoreBase', context: context);

  @override
  void _init() {
    final _$actionInfo = _$_HomePageStoreBaseActionController.startAction(name: '_HomePageStoreBase._init');
    try {
      return super._init();
    } finally {
      _$_HomePageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$_HomePageStoreBaseActionController.startAction(name: '_HomePageStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_HomePageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
appStore: ${appStore},
buildContext: ${buildContext}
    ''';
  }
}
