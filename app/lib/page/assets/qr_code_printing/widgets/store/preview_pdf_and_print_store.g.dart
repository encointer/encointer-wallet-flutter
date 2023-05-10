// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_pdf_and_print_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PreviewPdfAndPrintStore on _PreviewPdfAndPrintStoreBase, Store {
  Computed<pw.Document?>? _$docComputed;

  @override
  pw.Document? get doc =>
      (_$docComputed ??= Computed<pw.Document?>(() => super.doc, name: '_PreviewPdfAndPrintStoreBase.doc')).value;

  late final _$_renderObjectKeyAtom = Atom(name: '_PreviewPdfAndPrintStoreBase._renderObjectKey', context: context);

  @override
  GlobalKey<State<StatefulWidget>> get _renderObjectKey {
    _$_renderObjectKeyAtom.reportRead();
    return super._renderObjectKey;
  }

  @override
  set _renderObjectKey(GlobalKey<State<StatefulWidget>> value) {
    _$_renderObjectKeyAtom.reportWrite(value, super._renderObjectKey, () {
      super._renderObjectKey = value;
    });
  }

  late final _$_docAtom = Atom(name: '_PreviewPdfAndPrintStoreBase._doc', context: context);

  @override
  pw.Document? get _doc {
    _$_docAtom.reportRead();
    return super._doc;
  }

  @override
  set _doc(pw.Document? value) {
    _$_docAtom.reportWrite(value, super._doc, () {
      super._doc = value;
    });
  }

  late final _$timeAtom = Atom(name: '_PreviewPdfAndPrintStoreBase.time', context: context);

  @override
  DateTime get time {
    _$timeAtom.reportRead();
    return super.time;
  }

  @override
  set time(DateTime value) {
    _$timeAtom.reportWrite(value, super.time, () {
      super.time = value;
    });
  }

  late final _$_createPdfAsyncAction = AsyncAction('_PreviewPdfAndPrintStoreBase._createPdf', context: context);

  @override
  Future<void> _createPdf() {
    return _$_createPdfAsyncAction.run(() => super._createPdf());
  }

  late final _$_getQrCodeImageAsyncAction =
      AsyncAction('_PreviewPdfAndPrintStoreBase._getQrCodeImage', context: context);

  @override
  Future<Uint8List?> _getQrCodeImage() {
    return _$_getQrCodeImageAsyncAction.run(() => super._getQrCodeImage());
  }

  late final _$_getBgImageAsyncAction = AsyncAction('_PreviewPdfAndPrintStoreBase._getBgImage', context: context);

  @override
  Future<Uint8List?> _getBgImage() {
    return _$_getBgImageAsyncAction.run(() => super._getBgImage());
  }

  @override
  String toString() {
    return '''
time: ${time},
doc: ${doc}
    ''';
  }
}
