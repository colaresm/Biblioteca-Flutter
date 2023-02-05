import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/widgets/back_button.dart';
import 'dart:convert';
import 'package:libraryWDA/models/schedule_params.dart';
import 'package:libraryWDA/pages/widgets/confirm_button.dart';
import 'package:libraryWDA/utils/utf8_decode.dart';

class QueryViewToConfirm extends StatefulWidget {
  Object params;
  @override
  QueryViewToConfirm(this.params);
  State<QueryViewToConfirm> createState() =>
      _QueryViewToConfirmState(this.params);
}

adjustDate(date) {
  if (date != null) {
    var toDate = DateTime.parse(date);
    return toDate.day.toString() +
        '/' +
        toDate.month.toString() +
        '/' +
        toDate.year.toString();
  } else {
    return "";
  }
}

adjustTime(time) {
  if (time != null) {
    return time.substring(0, time.length - 3);
  } else {
    return "";
  }
}

adustDoctorName(doctorName) {
  if (doctorName != null) {
    return doctorName.replaceAll('Ã£', 'ã');
  } else {
    return "";
  }
}

DecodeUTF8 decodeUTF8 = new DecodeUTF8();

class _QueryViewToConfirmState extends State<QueryViewToConfirm> {
  Map<String, dynamic> paramsToMap = {};
  Object params;
  void initState() {
    if (params != "") {
      paramsToMap = json.decode(jsonEncode(params));
    }
  }

  _QueryViewToConfirmState(this.params);
  @override
  Widget build(BuildContext context) {
    ScheduleParams scheduleItems = ScheduleParams.fromJson(paramsToMap);
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
              child: Backbutton("home", ""),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 40),
              width: MediaQuery.of(context).size.width * 0.85,
              child: new Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      "Sua consulta está marcada para o dia ${adjustDate(scheduleItems.date)} às ${adjustTime(scheduleItems.time)}h com o médico(a) Dr(a) ${adustDoctorName(decodeUTF8.decodeString(scheduleItems.doctorName.toString()))}, deseja confirmar sua consulta?",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Confirmbutton(scheduleItems.id.toString()),
        )
      ],
    );
  }
}
