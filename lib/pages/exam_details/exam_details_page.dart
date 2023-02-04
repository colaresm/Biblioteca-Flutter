import 'package:flutter/material.dart';
import 'package:libraryWDA/models/exam_params.dart';
import 'dart:convert';
import 'package:libraryWDA/pages/widgets/back_button.dart';
import 'package:intl/intl.dart';

class ExamDetailsPage extends StatefulWidget {
  Object params;
  ExamDetailsPage(this.params);

  @override
  State<ExamDetailsPage> createState() => _ExamDetailsPageState(this.params);
}

class _ExamDetailsPageState extends State<ExamDetailsPage> {
  Map<String, dynamic> paramsToMap = {};
  Object params;
  void initState() {
    if (params != "") {
      paramsToMap = json.decode(jsonEncode(params));
    }
  }

  _ExamDetailsPageState(this.params);
  @override
  Widget build(BuildContext context) {
    ExamParams examItems = ExamParams.fromJson(paramsToMap);
    adustDateExam(date) {
      if (date != null) {
        var tag = Localizations.maybeLocaleOf(context)?.toLanguageTag();
        return DateFormat.yMMMd(tag).format(DateTime.parse(date));
      } else {
        return "";
      }
    }

    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 8, 5, 2),
              child: Backbutton('exams-list', {}),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(25, 8, 5, 2),
                  child: Text(adustDateExam(examItems.date),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(25, 14, 5, 2),
                  child: const Text('Exame',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 3, 25, 2),
              child: TextField(
                  readOnly: true,
                  controller: new TextEditingController(text: examItems.name),
                  style: TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 23, right: 23, top: 18, bottom: 16),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10))))),
            ),
          ],
        )
      ],
    );
  }
}
