import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/book_details/widgets/view_button.dart';

class attachmentsList extends StatefulWidget {
  String fileName;
  String content;
  attachmentsList(this.fileName, this.content);

  @override
  State<attachmentsList> createState() =>
      _attachmentsListState(this.fileName, this.content);
}

class _attachmentsListState extends State<attachmentsList> {
  adustFileName(String fileName) {
    if (fileName.length > 10) {
      return '${fileName.substring(0, 10)} . . . ${fileName.substring(fileName.length - 8, fileName.length)}';
    } else {
      return fileName;
    }
  }

  String fileName;
  String content;
  _attachmentsListState(this.fileName, this.content);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(adustFileName(fileName),
                overflow: TextOverflow.clip,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: viewButton(content,
              fileName.substring(fileName.length - 4, fileName.length)),
        ),
      ],
    );
  }
}
