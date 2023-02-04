import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/exam_details/exam_details_page.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:intl/intl.dart';

class examCardItem extends StatefulWidget {
  String nameExam;
  String dateExam;
  String idExam;

  examCardItem(this.nameExam, this.dateExam, this.idExam);

  @override
  State<examCardItem> createState() =>
      _examCardItemState(this.nameExam, this.dateExam, this.idExam);
}

class _examCardItemState extends State<examCardItem> {
  String nameExam;
  String dateExam;
  String idExam;
  _examCardItemState(this.nameExam, this.dateExam, this.idExam);
  @override
  Widget build(BuildContext context) {
    var tag = Localizations.maybeLocaleOf(context)?.toLanguageTag();
    return Container(
      height: MediaQuery.of(context).size.height * 0.11,
      child: Card(
        elevation: 0,
        color: Color.fromRGBO(0, 191, 166, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              trailing: const Icon(
                Icons.file_present_rounded,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 35,
              ),
              title: Text(nameExam),
              textColor: const Color.fromARGB(255, 255, 255, 255),
              subtitle: Text(
                DateFormat.yMMMd(tag).format(DateTime.parse(dateExam)),
                style: const TextStyle(
                  fontFamily: 'Fredoka',
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainPage("exam-details",
                          {'name': nameExam, 'date': dateExam}, 2)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
