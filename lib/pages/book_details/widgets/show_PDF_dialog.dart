import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
 


class showPDFDialog extends StatefulWidget {
String content;
showPDFDialog(this.content);
  @override
  State<showPDFDialog> createState() => _showPDFDialog(this.content);
}

class _showPDFDialog extends State<showPDFDialog> {
 String content;
  Uint8List? _documentBytes;
  _showPDFDialog( this.content);
  @override
  void initState() {
    getPdfBytes();
    super.initState();
  }
 void getPdfBytes() async {
    _documentBytes = base64Decode(content);
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: _documentBytes != null
          ? SfPdfViewer.memory(
              _documentBytes!,
            )
          : Container(),
    );
  }
}
