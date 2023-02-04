import 'package:libraryWDA/pages/queries_details/widgets/query_confirm_body.dart';
import 'package:libraryWDA/pages/queries_details/widgets/query_details_body.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:libraryWDA/models/schedule_params.dart';
import 'package:libraryWDA/pages/queries_details/widgets/query_view_to_confirm_body.dart';
import 'package:libraryWDA/pages/queries_details/widgets/query_canceled.dart';

class BookDetails extends StatefulWidget {
  Object scheduleParams;
  BookDetails(this.scheduleParams);

  @override
  State<BookDetails> createState() => _BookDetailsState(this.scheduleParams);
}

class _BookDetailsState extends State<BookDetails> {
  Object scheduleParams;

  _BookDetailsState(this.scheduleParams);
  @override
  int _queryBodyIndex = 0;
  Map<String, dynamic> scheduleParamsToMap = {};

  void initState() {
    if (scheduleParams != "") {
      scheduleParamsToMap = json.decode(jsonEncode(scheduleParams));
    }
  }

  selectBodyOfBookDetails(String status) {
    if (status == "COMPLETED") {
      return 0;
    }
    if (status == "CONFIRMED") {
      return 1;
    }
    if (status == "NOT_CONFIRMED") {
      return 2;
    }
    if (status == "CANCELED_BY_CLINIC") {
      return 3;
    }

    List<String> statusList = [
      'COMPLETED',
      'CONFIRMED',
      'NOT_CONFIRMED',
      'CANCELED_BY_CLINIC',
      'CANCELED_BY_DOCTOR',
      'CANCELED_BY_PATIENT',
      'UNREALIZED',
    ];

    for (var statusSelected in statusList) {
      if (statusSelected == status && !statusSelected.contains('CANCELED')) {
        return statusList.indexOf(statusSelected);
      } else {
        return statusList.indexOf('CANCELED_BY_CLINIC');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScheduleParams scheduleItems = ScheduleParams.fromJson(scheduleParamsToMap);

    return Scaffold(
      body: SingleChildScrollView(
        child: IndexedStack(
          index: 0,
          children: [
            BookDetailsBody(scheduleParams),
          ],
        ),
      ),
    );
  }
}
