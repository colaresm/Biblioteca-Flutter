import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/controllers/book_controller.dart';
import 'package:libraryWDA/controllers/patient_controller.dart';
import 'package:libraryWDA/controllers/publishing_company_controller.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/pages/book_details/widgets/query_confirm_body.dart';
import 'package:libraryWDA/pages/widgets/cancel_button.dart';
import 'package:libraryWDA/pages/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:libraryWDA/main.dart';
import 'package:http/retry.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:get/get.dart';

class BookForm extends StatefulWidget {
  Function function;
  BookForm(this.function);

  @override
  BookFormState createState() {
    return BookFormState(function);
  }
}

bool isDiabetic = false;
bool isHypertensive = false;
bool takesMedication = false;
bool isSmoker = false;
String _birthDate = "";

class BookFormState extends State<BookForm> {
  Function function;
  BookFormState(this.function);
  final _formKey = GlobalKey<FormState>();

  var _book = {
    "author": "",
    "publishingCompanyId": "",
    "quantity": 0,
    "releaseDate": "",
    "title": ""
  };

  requiredField(value) {
    if (value.isEmpty) return "Campo Obrigatório";
  }

  validateQuantity(value) {
    if (value == "0") return "A quantidade de livros deve ser superior a 1";
    if (value.isEmpty) return "Campo Obrigatório";
  }

  performAnamnese() {
    if (_formKey.currentState!.validate()) {
      adjustDate();
      BookController.create(_book);

      Get.snackbar('Sucesso', 'Livro cadastrado com sucesso',
          backgroundColor: Colors.greenAccent,
          borderWidth: 2,
          icon: Icon(
            Icons.done,
            color: Colors.white,
          ),
          colorText: Colors.white,
          borderColor: Colors.white);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage("home", "", 0),
        ),
      );
    }
  }

  adjustDate() {
    if (_book['releaseDate'].toString().length == 0)
      _book['releaseDate'] = DateTime.now().toString().substring(0, 10);
    else
      _book['releaseDate'] = formatDate(_book['releaseDate']);
  }

  formatDate(date) {
    return date
        .toString()
        .substring(0, _book['releaseDate'].toString().length - 13);
  }

  backPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage("home", "", 0),
      ),
    );
  }

  getMask(digits) {
    switch (digits) {
      case 'three-digits':
        return [
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy)
        ];

      case 'double':
        return [
          MaskTextInputFormatter(
              mask: '#.##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy)
        ];
      default:
        return [
          MaskTextInputFormatter(
              mask: '#.##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy)
        ];
    }
  }

  dateToBrazilianFormat(date) {
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(date);
  }

  String? _selectedPubishingCompany;
  TextEditingController _controllerDatePicker = new TextEditingController();
  void initState() {
    PublishingCompanyController.getCompanys().then(
      (response) {
        setState(() {
          _selectedPubishingCompany = response[0].name;
          _book['publishingCompanyId'] = response[0].id;
        });
      },
    );
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Autor'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 23, right: 23, top: 20, bottom: 20),
                  labelText: 'Digite o nome autor do livro',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
              validator: (value) => requiredField(value),
              onChanged: (value) {
                _book['author'] = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Editora'),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 6, 20),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.94,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1)),
                  child: FutureBuilder(
                    future: PublishingCompanyController.getCompanys(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? Container(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                underline: Container(),
                                alignment: Alignment.bottomCenter,
                                elevation: 0,
                                borderRadius: BorderRadius.circular(5),
                                hint: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 5, 16, 8),
                                  child: Text(
                                    _selectedPubishingCompany ??
                                        'Selecione uma editora',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                items: snapshot.data
                                    .map<DropdownMenuItem<String>>((item) {
                                  return DropdownMenuItem<String>(
                                    onTap: () => setState(() {
                                      _book["publishingCompanyId"] = item.id;
                                    }),
                                    value: item.name,
                                    child: Text(item.name),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPubishingCompany = value;
                                  });
                                },
                              ),
                            )
                          : Container(
                              child: Center(
                                child: Text('Carregando estados...'),
                              ),
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Quantidade'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              inputFormatters: getMask('three-digits'),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 23, right: 23, top: 20, bottom: 20),
                  labelText: 'Digite a quantidade de livros',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
              validator: (value) => validateQuantity(value),
              onChanged: (value) {
                _book['quantity'] = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Título'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 23, right: 23, top: 20, bottom: 20),
                  labelText: 'Digite o título do livro',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
              validator: (value) => requiredField(value),
              onChanged: (value) {
                _book['title'] = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Data de lançamento'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 23, right: 23, top: 20, bottom: 20),
                  labelText: dateToBrazilianFormat(DateTime.now()),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
              controller: _controllerDatePicker,
              readOnly: true,
              onTap: () async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1930),
                    initialDate: DateTime.now(),
                    lastDate: DateTime.now());
                if (date != null) {
                  _controllerDatePicker.text = dateToBrazilianFormat(date);
                  setState(() {
                    _book['releaseDate'] = date;
                  });
                }
              },
            ),
          ),
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
                      performAnamnese),
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
