import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/widgets/back_button.dart';
import 'detail_message.dart';

class WidgetDetailMessageView extends StatelessWidget {
  final Object id;

  const WidgetDetailMessageView(this.id, {super.key});

  String convertId(Object params) {
    final json = jsonEncode(params);
    final Map<String, dynamic> map = jsonDecode(json);
    return map['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Expanded(
            flex: 0,
            child: BackButton(),
          ),
          DetailsMessage(convertId(id)),
        ],
      ),
    );
  }
}
