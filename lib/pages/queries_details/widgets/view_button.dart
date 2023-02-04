import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:libraryWDA/pages/queries_details/widgets/show_PDF_dialog.dart';
import 'package:http/http.dart' as http;

class viewButton extends StatefulWidget {
  String content;
  String fileExtension;
  viewButton(this.content, this.fileExtension);

  @override
  State<viewButton> createState() =>
      _viewButtonState(this.content, this.fileExtension);
}

class _viewButtonState extends State<viewButton> {
  String content;
  String fileExtension;
  _viewButtonState(this.content, this.fileExtension);

  previewImage(content) {
    Uint8List bodyBytes = base64Decode(content);

    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.25,
            padding: EdgeInsets.only(top: 150.0),
            child: Wrap(
              children: <Widget>[Image.memory(bodyBytes)],
            ),
          );
        });
  }

  previewPDF(content) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => showPDFDialog(content)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12),
      child: TextButton.icon(
        onPressed: () {
          if (fileExtension.toUpperCase() == ".PDF")
            previewPDF(content);
          else
            previewImage(content);
        },
        icon: const Icon(
          Icons.info_outline,
          color: Colors.white,
          size: 24,
        ),
        label: const Text(
          "",
        ),
      ),
    );
  }
}
