import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/controllers/patient_controller.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/pages/widgets/cancel_button.dart';
import 'package:libraryWDA/pages/patient_settings/patient_settings_page.dart';
import 'package:libraryWDA/pages/widgets/default_text_element.dart';
import 'package:libraryWDA/pages/widgets/default_button.dart';
import 'package:http/retry.dart';
import 'package:get/get.dart';
import 'package:libraryWDA/main.dart';

class PatientChangePassword extends StatefulWidget {
  const PatientChangePassword({super.key});

  @override
  State<PatientChangePassword> createState() => _PatientChangePasswordState();
}

class _PatientChangePasswordState extends State<PatientChangePassword> {
  String userId = "";
  String userName = "";

  @override
  void initState() {
    PatientController.getUserDetails(
            AuthenticationController.userPayload["patientId"].toString())
        .then(
      (response) {
        userId = response['user']['id'];
        userName = response['user']['username'];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    backPage() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PatientSettings()),
      );
    }

    var _formKey = GlobalKey<FormState>();
    TextEditingController passwordController = new TextEditingController();
    TextEditingController confirmPasswordController =
        new TextEditingController();

    String _password = "";

    getPatientId() {
      return AuthenticationController.userPayload["patientId"].toString();
    }

    updateField(value) {
      _password = value;
    }

    chagePassword() {
      var patientToUpdate = {
        "id": getPatientId(),
        "password": _password,
        "userListResponse": {'id': userId, 'username': userName}
      };
      if (_formKey.currentState!.validate()) {
        PatientController.updatePassword(patientToUpdate);
        Get.snackbar('Sucesso', 'Senha atualizada com sucesso',
            backgroundColor: companyColors.shade400,
            borderWidth: 4,
            colorText: companyColors.shade100,
            borderColor: companyColors.shade100);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage('home', "", 0)),
        );
      } else {
        Get.snackbar('Erro', 'Erro ao atualizar sua senha',
            backgroundColor: companyColors.shade600,
            borderWidth: 4,
            colorText: companyColors.shade100,
            borderColor: companyColors.shade100);
      }
    }

    checkPasswordMatch(password, confirmPassowrd) {
      if (password != confirmPassowrd) {
        return "As senhas devem ser iguais";
      }
    }

    requiredField(String value) {
      if (value == "" || value.length < 6) {
        return "Senha inválida";
      }
    }

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
                              Text('Alterar senha',
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 23,
                                          right: 23,
                                          top: 20,
                                          bottom: 20),
                                      labelText: 'Digite sua nova senha',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))),
                                  controller: passwordController,
                                  onChanged: (value) {
                                    updateField(value);
                                  },
                                  validator: (value) =>
                                      requiredField(value.toString()),
                                ),
                              ),
                              TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 23,
                                        right: 23,
                                        top: 20,
                                        bottom: 20),
                                    labelText: 'Cofirme sua senha',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)))),
                                controller: confirmPasswordController,
                                validator: (value) => checkPasswordMatch(
                                    passwordController.text, value),
                              )
                            ],
                          )),
                    ),
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
                    chagePassword),
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
