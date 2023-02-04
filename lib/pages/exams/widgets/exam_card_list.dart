import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/book_controller.dart';
import 'package:libraryWDA/pages/exams/widgets/exam_card_item.dart';
import 'package:libraryWDA/utils/utf8_decode.dart';

class ExamListItems extends StatefulWidget {
  final String patientId;
  const ExamListItems({required this.patientId});

  @override
  State<ExamListItems> createState() => _ExamListItemsState();
}

class _ExamListItemsState extends State<ExamListItems> {
  final DecodeUTF8 decodeUTF8 = new DecodeUTF8();
  List _exams = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BookController.getExamsList(widget.patientId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Não há histórico de exames realizados!",
                  style: TextStyle(
                    fontFamily: "Fredoka",
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                itemBuilder: (context, index) {
                  final exam = snapshot.data?[index];
                  return Column(
                    children: [
                      for (var i = 0; i < exam.exams.length; i++)
                        examCardItem(
                            decodeUTF8
                                .decodeString(exam.exams[i]['name'].toString()),
                            exam.createdAt,
                            exam.id)
                    ],
                  );
                },
              );
            }
        }
      },
    );
  }
}
