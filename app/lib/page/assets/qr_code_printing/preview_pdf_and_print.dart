import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PreviewPdfAndPrint extends StatefulWidget {
  const PreviewPdfAndPrint({
    required this.doc,
    required this.title,
    super.key,
  });

  final pw.Document doc;
  final String title;

  @override
  State<PreviewPdfAndPrint> createState() => _PreviewPdfAndPrintState();
}

class _PreviewPdfAndPrintState extends State<PreviewPdfAndPrint> {
  late DateTime time;

  @override
  void initState() {
    time = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: PdfPreview(
        build: (format) => widget.doc.save(),
        allowSharing: false,
        initialPageFormat: PdfPageFormat.a4,
        canDebug: false,
        pdfFileName: 'my_account_qr_${time.toIso8601String()}.pdf',
      ),
    );
  }
}
