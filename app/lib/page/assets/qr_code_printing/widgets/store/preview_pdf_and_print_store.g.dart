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

  late final _$renderObjectKeyAtom = Atom(name: '_PreviewPdfAndPrintStoreBase.renderObjectKey', context: context);

  @override
  GlobalKey<State<StatefulWidget>>? get renderObjectKey {
    _$renderObjectKeyAtom.reportRead();
    return super.renderObjectKey;
  }

  @override
  set renderObjectKey(GlobalKey<State<StatefulWidget>>? value) {
    _$renderObjectKeyAtom.reportWrite(value, super.renderObjectKey, () {
      super.renderObjectKey = value;
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

  late final _$createPdfAsyncAction = AsyncAction('_PreviewPdfAndPrintStoreBase.createPdf', context: context);

  @override
  Future<void> createPdf({required GlobalKey<State<StatefulWidget>> key, required dynamic translations}) {
    return _$createPdfAsyncAction.run(() => super.createPdf(key: key, translations: translations));
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
renderObjectKey: ${renderObjectKey},
time: ${time},
doc: ${doc}
    ''';
  }
}
