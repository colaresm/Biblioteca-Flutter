import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/widgets/back_button.dart';
import 'dart:convert';
import 'package:libraryWDA/models/schedule_params.dart';

class QueryConfirmBody extends StatefulWidget {
  Object params;
  QueryConfirmBody(this.params);
  State<QueryConfirmBody> createState() => _QueryConfirmBodyState(this.params);
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

class _QueryConfirmBodyState extends State<QueryConfirmBody> {
  Object params;
  Map<String, dynamic> paramsToMap = {};
  _QueryConfirmBodyState(this.params);

  void initState() {
    if (params != "") {
      paramsToMap = json.decode(jsonEncode(params));
    }
  }

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
        Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 40),
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: new Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                            "Sua consulta está confirmada para o dia ${adjustDate(scheduleItems.date)} às ${adjustTime(scheduleItems.time)}h com o médico(a) Dr(a) ${adustDoctorName(scheduleItems.doctorName)}.",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.justify),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
