import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/controllers/patient_controller.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/pages/widgets/cancel_button.dart';
import 'package:libraryWDA/pages/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MyCustomForm extends StatefulWidget {
  Function function;
  MyCustomForm(this.function);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState(function);
  }
}

bool isDiabetic = false;
bool isHypertensive = false;
bool takesMedication = false;
bool isSmoker = false;
String _birthDate = "";

class MyCustomFormState extends State<MyCustomForm> {
  Function function;
  MyCustomFormState(this.function);
  final _formKey = GlobalKey<FormState>();

  var _anamnese = {
    "age": "",
    "male": "",
    "cigsPerDay": 0,
    "prevalentHyp": isHypertensive,
    "BPMeds": takesMedication,
    "diabetes": isDiabetic,
    "totChol": "",
    "sysBP": "",
    "glucose": "",
    "weight": "",
    "height": ""
  };

  requiredField(value) {
    if (value.isEmpty) return "Campo Obrigatório";
  }

  performAnamnese() {
    if (_formKey.currentState!.validate()) {
      tranformBoolToNumeric();
      adjustGender();
      _anamnese['patientId'] =
          AuthenticationController.userPayload["patientId"].toString();
      function(_anamnese);
    }
  }

  tranformBoolToNumeric() {
    List<String> keys = _anamnese.keys.toList();
    for (var i = 0; i < keys.length; i++) {
      if (_anamnese[keys[i]] == true) _anamnese[keys[i]] = 1;
      if (_anamnese[keys[i]] == false) _anamnese[keys[i]] = 0;
    }
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

  calculateAge() {
    if (_birthDate != "")
      return (DateTime.now()
                  .difference(DateTime.parse(_birthDate.toString()))
                  .inDays /
              360)
          .round();
  }

  adjustGender() {
    if (_anamnese['male'] == 'MALE')
      _anamnese['male'] = 1;
    else
      _anamnese['male'] = 0;
  }

  @override
  void initState() {
    PatientController.getUserDetails(
            AuthenticationController.userPayload["patientId"].toString())
        .then(
      (response) {
        _anamnese['male'] = response['gender'];
        _birthDate = response['birthDate'].toString();
        _anamnese['age'] = calculateAge();
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('Dibetes?'),
                Checkbox(
                  checkColor: Colors.white,
                  value: isDiabetic,
                  onChanged: (bool? value) {
                    setState(() {
                      isDiabetic = value!;
                      _anamnese['diabetes'] = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('Tem hipertensão?'),
                Checkbox(
                  checkColor: Colors.white,
                  value: isHypertensive,
                  onChanged: (bool? value) {
                    setState(() {
                      isHypertensive = value!;
                      _anamnese['prevalentHyp'] = value;
                    });
                  },
                ),
              ],
            ),
          ),
          isHypertensive == true
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Expanded(
                          child: Text(
                              'Faz uso de medicamento para controle da pressão arteiral?')),
                      Checkbox(
                        checkColor: Colors.white,
                        value: takesMedication,
                        onChanged: (bool? value) {
                          setState(() {
                            takesMedication = value!;
                            _anamnese['BPMeds'] = value;
                          });
                        },
                      ),
                    ],
                  ),
                )
              : Container(),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('É fumante?'),
                  Checkbox(
                    checkColor: Colors.white,
                    value: isSmoker,
                    onChanged: (bool? value) {
                      setState(() {
                        isSmoker = value!;
                      });
                    },
                  ),
                ],
              )),
          isSmoker == true
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Quantidade de cigarros consumidos por dia:'),
                )
              : Container(),
          isSmoker == true
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    inputFormatters: getMask('three-digits'),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 23, right: 23, top: 20, bottom: 20),
                        labelText:
                            'Quantos cigarros você costuma consumir por dia?',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    validator: (value) => requiredField(value),
                    onChanged: (value) {
                      _anamnese['cigsPerDay'] = value;
                    },
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Glicose'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              inputFormatters: getMask('three-digits'),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 23, right: 23, top: 20, bottom: 20),
                  labelText: 'Digite o valor da sua glicose',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              validator: (value) => requiredField(value),
              onChanged: (value) {
                _anamnese['glucose'] = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Pressão sistólica'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              inputFormatters: getMask('three-digits'),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 23, right: 23, top: 20, bottom: 20),
                  labelText: 'Digite o valor da sua pressão sistólica',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              validator: (value) => requiredField(value),
              onChanged: (value) {
                _anamnese['sysBP'] = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Colesterol'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              inputFormatters: getMask('three-digits'),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 23, right: 23, top: 20, bottom: 20),
                  labelText: 'Digite o valor do seu colesterol',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              validator: (value) => requiredField(value),
              onChanged: (value) {
                _anamnese['totChol'] = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Altura'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              inputFormatters: getMask('double'),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 23, right: 23, top: 20, bottom: 20),
                  labelText: 'Digite o valor da sua altura',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              validator: (value) => requiredField(value),
              onChanged: (value) {
                _anamnese['height'] = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Peso'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              inputFormatters: getMask('three-digits'),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 23, right: 23, top: 20, bottom: 20),
                  labelText: 'Digite o valor do seu peso',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              validator: (value) => requiredField(value),
              onChanged: (value) {
                _anamnese['weight'] = value;
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
