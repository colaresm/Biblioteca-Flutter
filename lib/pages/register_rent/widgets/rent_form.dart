import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/controllers/rent_controller.dart';
import 'package:libraryWDA/main.dart';
import 'package:libraryWDA/models/rent_list_item.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/pages/widgets/cancel_button.dart';
import 'package:libraryWDA/pages/widgets/default_button.dart';

class RentForm extends StatefulWidget {
  var params;
  RentForm(this.params);

  @override
  State<RentForm> createState() => _RentFormState(this.params);
}

class _RentFormState extends State<RentForm> {
  var params;
  _RentFormState(this.params);
  final _formKey = GlobalKey<FormState>();

  requiredField(value) {
    if (value.isEmpty) return "Campo Obrigatório";
  }

  backPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage("home", "", 0),
      ),
    );
  }

  int _quantityDays = 7;
  List<int> days = <int>[7, 14, 21];

  Widget build(BuildContext context) {
    var _rent = {
      "bookId": params['bookId'].toString(),
      "clientId":
          AuthenticationController.userPayload["professionalId"].toString(),
      "loanDate": DateTime.now(),
      "returnDate": ''
    };
    adjustDate(date) {
      if (date.toString().length == 0)
        return DateTime.now().toString().substring(0, 10);
      else {
        return date.toString().substring(0, date.toString().length - 13);
      }
    }

    createRent() {
      if (_formKey.currentState!.validate()) {
        _rent['returnDate'] = DateTime.now().add(Duration(days: _quantityDays));
        _rent['loanDate'] = adjustDate(_rent['loanDate']);
        _rent['returnDate'] = adjustDate(_rent['returnDate']);
        RentController.create(_rent)
            .then((value) => {
                  Get.snackbar('Sucesso', 'Aluguel realizado sucesso',
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
            .catchError(
                (error) => Get.snackbar('Erro', 'Erro ao realizar alguel',
                    backgroundColor: companyColors.shade600,
                    icon: Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                    borderWidth: 2,
                    colorText: Colors.white,
                    borderColor: Colors.white));
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Livro: ${params['bookName']}'),
          ),
          Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Expanded(
                  child: Row(
                children: [
                  Text('Selecione o tempo de empréstimo:'),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1)),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(),
                          alignment: Alignment.bottomCenter,
                          elevation: 0,
                          borderRadius: BorderRadius.circular(5),
                          hint: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 5, 16, 8),
                            child: Text(
                              _quantityDays.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          items:
                              days.map<DropdownMenuItem<String>>((int value) {
                            return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              print(value);
                              _quantityDays = int.parse(value ?? '7');
                            });
                          },
                        ),
                      )),
                ],
              ))),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Column(
                children: [
                  DefaultButton(
                      "FINALIZAR",
                      Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                      createRent),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CancelButton(backPage),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
