import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/pages/exams/widgets/exam_card_list.dart';
import 'package:libraryWDA/pages/widgets/schedule_button.dart';
import 'package:libraryWDA/pages/widgets/back_button.dart';

class ExamsPageList extends StatefulWidget {
  const ExamsPageList({super.key});

  @override
  State<ExamsPageList> createState() => _ExamsPageListState();
}

class _ExamsPageListState extends State<ExamsPageList> {
  @override
  int _value = 0;

  void _change(bool isViewBookDetails) {
    if (isViewBookDetails == true) {
      setState(() {
        _value = 1;
      });
    }
    if (isViewBookDetails == false) {
      setState(() {
        _value = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _value,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(3, 0, 10, 5),
                    child: Backbutton("home", ""),
                  ),
                ],
              ),
              Column(
                children: [
                  ScheduleButton(),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(25, 8, 5, 2),
                        child: Text('Meus exames',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ],
                  ),
                  ExamListItems(
                    patientId: AuthenticationController.userPayload["patientId"]
                        .toString(),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
