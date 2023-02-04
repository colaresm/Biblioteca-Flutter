import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/patient_settings/patient_settings_page.dart';
import 'package:libraryWDA/pages/widgets/cancel_button.dart';
import 'package:libraryWDA/pages/widgets/default_button.dart';
import 'package:libraryWDA/pages/widgets/default_text_element.dart';
import 'package:libraryWDA/utils/add_mask.dart';
import 'package:http/retry.dart';
import 'dart:convert';
import 'package:libraryWDA/main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/controllers/patient_controller.dart';

import '../../main/main_page.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({super.key});

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  backPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PatientSettings()),
    );
  }

  var _patient = {};

  List<TextEditingController> _controllersToPersonalData = [];
  List<TextEditingController> _controllersToAddressData = [];
  bool isValidForm = true;
  var personalDataFeatureMap = {
    'name': 'Nome',
    'cpf': 'CPF',
    'birthDate': 'Data de Aniversário',
    'rg': 'RG',
    'firstPhone': 'Telefone',
    'emergencyPhone': 'Telefone de Emergência',
  };
  var addressDataFeatureMap = {
    'address': "Rua",
    'cep': 'CEP',
    'state': 'Estado',
    'neighborhood': 'Bairro',
    'city': 'Cidade',
    'complement': 'Complemento'
  };

  @override
  void initState() {
    createControllersToPersonalData(personalDataFeatureMap.length);
    createControllersToAddressData(addressDataFeatureMap.length);
    PatientController.getUserDetailsToUpdate(
            AuthenticationController.userPayload["patientId"].toString())
        .then((response) {
      setState(() {
        _patient = response;
      });
      setTextToControllers(personalDataFeatureMap);
      setTextToControllersWithSubKey(addressDataFeatureMap, 'address');
    });
  }

  removeMask(value) {
    String removedMask = value;
    removedMask = removedMask.replaceAll('(', '');
    removedMask = removedMask.replaceAll(')', '');
    removedMask = removedMask.replaceAll(' ', '');
    removedMask = removedMask.replaceAll('-', '');
    removedMask = removedMask.replaceAll('.', '');
    return removedMask;
  }

  AddMask addMask = new AddMask();
  createControllersToPersonalData(
    length,
  ) {
    for (int i = 0; i < length; i++)
      _controllersToPersonalData.add(TextEditingController());
  }

  createControllersToAddressData(
    length,
  ) {
    for (int i = 0; i < length; i++)
      _controllersToAddressData.add(TextEditingController());
  }

  setTextToControllers(features) {
    var keys = features.keys.toList();
    _patient['birthDate'] =
        dateToBrazilianFormat(DateTime.parse(_patient['birthDate']));

    _patient['firstPhone'] = addMask.phone(_patient['firstPhone']);
    _patient['emergencyPhone'] = addMask.phone(_patient['emergencyPhone']);
    _patient['rg'] = addMask.rg(_patient['rg']);
    for (int i = 0; i < keys.length; i++) {
      _controllersToPersonalData[i].text = _patient[keys[i]];
    }
  }

  setTextToControllersWithSubKey(features, subKey) {
    var keys = features.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      _controllersToAddressData[i].text = _patient[subKey][keys[i]];
    }
  }

  updateField(value, key, formKey) {
    if (key != 'birthDate') isValidForm = formKey;

    if (addressDataFeatureMap.keys.contains(key)) {
      _patient['address'][key] = value;
    } else {
      _patient[key] = value;
    }
  }

  adjustBirthDate() {
    if (_patient['birthDate'].runtimeType == String) {
      if (_patient['birthDate'].toString().contains('/')) {
        _patient['birthDate'] = dateToEnglishFormat(DateTime.parse(
            _patient['birthDate'].substring(_patient['birthDate'].length - 4,
                    _patient['birthDate'].length) +
                '-' +
                _patient['birthDate'].substring(3, 5) +
                '-' +
                _patient['birthDate'].substring(0, 2)));
      }
    } else {
      _patient['birthDate'] = dateToEnglishFormat(_patient['birthDate']);
    }
  }

  upatePatient() {
    if (isValidForm) {
      adjustBirthDate();
      var patientToUpdate = _patient;

      patientToUpdate['rg'] = removeMask(_patient['rg']);
      patientToUpdate['firstPhone'] = removeMask(_patient['firstPhone']);
      patientToUpdate['emergencyPhone'] =
          removeMask(_patient['emergencyPhone']);

      PatientController.updateDetails(patientToUpdate);
      Get.snackbar('Sucesso', 'Cadastro atualizado com sucesso',
          backgroundColor: companyColors.shade400,
          borderWidth: 4,
          colorText: companyColors.shade100,
          borderColor: companyColors.shade100);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage('home', "", 0)),
      );
    } else
      Get.snackbar('Erro', 'Erro ao atualizar seu cadastro',
          backgroundColor: companyColors.shade600,
          borderWidth: 4,
          colorText: companyColors.shade100,
          borderColor: companyColors.shade100);
  }

  dateToBrazilianFormat(date) {
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(date);
  }

  dateToEnglishFormat(date) {
    var outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(date);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(color: Colors.blue, spreadRadius: 3),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 15, 0, 5),
                          child: Row(
                            children: [
                              Text('Informações pessoais',
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.white)),
                              IconButton(
                                onPressed: () {
                                  backPage();
                                },
                                icon: Icon(
                                  size: 30,
                                  Icons.keyboard_double_arrow_right,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  children: [
                    for (var i = 0; i < _controllersToPersonalData.length; i++)
                      DefaultFormElement(
                          _controllersToPersonalData[i],
                          personalDataFeatureMap[
                                  personalDataFeatureMap.keys.toList()[i]]
                              .toString(),
                          personalDataFeatureMap.keys.toList()[i],
                          updateField),
                    for (var i = 0; i < _controllersToAddressData.length; i++)
                      DefaultFormElement(
                          _controllersToAddressData[i],
                          addressDataFeatureMap[
                                  addressDataFeatureMap.keys.toList()[i]]
                              .toString(),
                          addressDataFeatureMap.keys.toList()[i],
                          updateField),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: DefaultButton(
                    "SALVAR",
                    Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    upatePatient),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: CancelButton(() {
                  backPage();
                }),
              )
            ],
          ),
        ));
  }
}
