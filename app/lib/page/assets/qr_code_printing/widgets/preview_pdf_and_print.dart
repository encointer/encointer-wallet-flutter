import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:encointer_wallet/page/assets/qr_code_printing/widgets/store/preview_pdf_and_print_store.dart';

class PreviewPdfAndPrintArgs {
  PreviewPdfAndPrintArgs({
    required this.renderObjectKey,
    required this.title,
  });

  final GlobalKey renderObjectKey;
  final String title;
}

class PreviewPdfAndPrint extends StatefulWidget {
  const PreviewPdfAndPrint({
    required this.args,
    super.key,
  });

  static const route = '/preview_pdf_and_print';

  final PreviewPdfAndPrintArgs args;

  @override
  State<PreviewPdfAndPrint> createState() => _PreviewPdfAndPrintState();
}

class _PreviewPdfAndPrintState extends State<PreviewPdfAndPrint> {
  late final PreviewPdfAndPrintStore store = PreviewPdfAndPrintStore();

  @override
  void didChangeDependencies() {
    store.createPdf(
      key: widget.args.renderObjectKey,
      context: context,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.args.title,
          textAlign: TextAlign.center,
        ),
      ),
      body: Observer(
        builder: (context) {
          if (store.doc == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return PdfPreview(
              build: (format) => store.doc!.save(),
              allowSharing: false,
              canDebug: false,
              initialPageFormat: PdfPageFormat.a4,
              pdfFileName: 'my_accounts_qr_code_${store.time.toIso8601String()}.pdf',
            );
          }
        },
      ),
    );
  }
}
