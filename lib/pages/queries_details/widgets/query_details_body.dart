import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/interceptors/get_modifiers.dart';
import 'package:libraryWDA/pages/queries_details/widgets/attachments_list.dart';
import 'package:intl/intl.dart';
import 'package:libraryWDA/pages/widgets/back_button.dart';
import 'package:libraryWDA/controllers/book_controller.dart';
import 'dart:convert';
import 'package:libraryWDA/models/schedule_params.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class BookDetailsBody extends StatefulWidget {
  Object params;
  @override
  BookDetailsBody(this.params);
  State<BookDetailsBody> createState() => _BookDetailsBodyState(this.params);
}

class _BookDetailsBodyState extends State<BookDetailsBody> {
  Object params;
  String _title = '';
  String _author = '';
  String _releaseDate = '';

  Map<String, dynamic> paramsToMap = {};

  _BookDetailsBodyState(this.params);

  void initState() {
    if (params != "") {
      paramsToMap = json.decode(jsonEncode(params));
    }

    BookController.getBook(paramsToMap['id']).then((response) {
      if (response != null) {
        setState(() {
          _title = response['title'];
          _author = response['author'];
          _releaseDate = response['releaseDate'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScheduleParams scheduleItems = ScheduleParams.fromJson(paramsToMap);
    getDate(date) {
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
              child: Backbutton("books-list", ""),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(25, 8, 5, 2),
                  child: const Text('Detalhes do livro',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(25, 14, 5, 2),
                  child: Text('Título: $_title',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(25, 14, 5, 2),
                  child: Text('Autor: $_author',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(25, 14, 5, 2),
                  child: Expanded(
                      child: Text(
                          'Data de lançamento: ${getDate(_releaseDate)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12))),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
