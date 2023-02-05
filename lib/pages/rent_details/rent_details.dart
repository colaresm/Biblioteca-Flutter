import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:libraryWDA/controllers/rent_controller.dart';
import 'package:libraryWDA/main.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/pages/widgets/back_button.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:libraryWDA/pages/widgets/default_button.dart';

class RentDetaisl extends StatefulWidget {
  var id;
  RentDetaisl(this.id);

  @override
  State<RentDetaisl> createState() => _RentDetaislState(this.id);
}

class _RentDetaislState extends State<RentDetaisl> {
  Object id;
  Map<String, dynamic> paramsToMap = {};
  _RentDetaislState(this.id);

  String _book = '';
  String _client = '';
  String _returnDate = '';
  String _rentStatus = '';

  void initState() {
    if (id != "") {
      paramsToMap = json.decode(jsonEncode(id));
    }

    RentController.getRent(paramsToMap['id']).then((response) {
      if (response != null) {
        setState(() {
          _book = response['book']['title'];
          _client = response['client']['name'];
          _returnDate = response['returnDate'];
          _rentStatus = response['rentStatus'];
        });
      }
    });
  }

  devolutionBook() {
    RentController.devolution(id)
        .then((value) => {
              Get.snackbar('Sucesso', 'Livro devolvido com sucesso.',
                  backgroundColor: Colors.greenAccent,
                  borderWidth: 2,
                  icon: Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                  colorText: Colors.white,
                  borderColor: Colors.white),
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage("home", "", 0),
                ),
              )
            })
        .catchError((error) => Get.snackbar('Erro', 'Erro ao devolver livro.',
            backgroundColor: companyColors.shade600,
            icon: Icon(
              Icons.error,
              color: Colors.white,
            ),
            borderWidth: 2,
            colorText: Colors.white,
            borderColor: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
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
              child: Backbutton("rents-list", ""),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(25, 8, 5, 2),
                  child: const Text('Detalhes do aluguel',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(25, 14, 5, 2),
                  child: Text('Livro: $_book',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(25, 14, 5, 2),
                  child: Text('Alugado por: $_client',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(25, 14, 5, 2),
                  child: Expanded(
                      child: Text('Data de devolução: ${getDate(_returnDate)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))),
                ),
              ],
            ),
          ],
        ),
        _rentStatus == "RENTED"
            ? DefaultButton(
                'Devolver Livro',
                Icon(
                  Icons.repeat_one_on_rounded,
                  color: Colors.white,
                ),
                devolutionBook)
            : Container()
      ],
    );
  }
}
