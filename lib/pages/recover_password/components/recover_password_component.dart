import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libraryWDA/controllers/recover_password_controller.dart';
import 'package:libraryWDA/main.dart';
import 'package:libraryWDA/models/recover_password.dart';

class RecoverPasswordComponent extends StatefulWidget {
  final int step;
  final String actionText;
  final String inputTextLabel;
  final void Function(int, RecoverPassword) changeStep;

  RecoverPasswordComponent({
    super.key,
    required this.step,
    required this.actionText,
    required this.inputTextLabel,
    required this.changeStep,
  });

  @override
  State<RecoverPasswordComponent> createState() =>
      _RecoverPasswordComponentState();
}

class _RecoverPasswordComponentState extends State<RecoverPasswordComponent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _controller = Get.put(RecoverPasswordController());
  Map<String, String> _formData = {};
  final fieldText = TextEditingController();
  bool isDisabled = false;

  void disableButton() {
    setState(() {
      isDisabled = true;
    });
    Timer(Duration(seconds: 5), () async {
      setState(() {
        isDisabled = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: MediaQuery.of(context).size.width < 900
            ? BoxConstraints(maxWidth: 300)
            : BoxConstraints(maxWidth: 400),
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Recuperar senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 35,
                        color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                      bottom: 25,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          constraints: MediaQuery.of(context).size.width < 900
                              ? BoxConstraints(maxWidth: 280)
                              : BoxConstraints(maxWidth: 380),
                          height: 5,
                          color: companyColors.shade800,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 43,
                              width: 43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: widget.step == 1
                                    ? Colors.black
                                    : companyColors.shade800,
                              ),
                              child: Center(
                                child: Text('1',
                                    style: TextStyle(
                                        color: companyColors.shade100,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Container(
                              height: 43,
                              width: 43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: widget.step == 2
                                    ? Colors.black
                                    : companyColors.shade800,
                              ),
                              child: Center(
                                child: Text('2',
                                    style: TextStyle(
                                        color: companyColors.shade100,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Container(
                              height: 43,
                              width: 43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: widget.step == 3
                                    ? Colors.black
                                    : companyColors.shade800,
                              ),
                              child: Center(
                                child: Text('3',
                                    style: TextStyle(
                                        color: companyColors.shade100,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      widget.actionText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: companyColors.shade50),
                    ),
                  ),
                  TextFormField(
                    onSaved: (value) => _formData['field'] = value!,
                    controller: fieldText,
                    validator: (value) {
                      var text = value!.trim();
                      if (value == null || text.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if (widget.inputTextLabel.toLowerCase() == 'email') {
                        bool _emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!_emailValid) {
                          return 'Email inválido';
                        }
                      }
                      if (widget.inputTextLabel.toLowerCase() == 'código') {
                        if (text.length < 6) {
                          return 'Código inválido';
                        }
                      }
                      if (widget.inputTextLabel.toLowerCase() == 'nova senha') {
                        if (text.length < 6) {
                          return 'Senha inválida';
                        }
                      }
                      return null;
                    },
                    style:
                        TextStyle(fontSize: 18, color: companyColors.shade50),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 23, right: 23, top: 20, bottom: 20),
                        label: Text(widget.inputTextLabel),
                        hintText: widget.inputTextLabel,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: companyColors.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'CANCELAR',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(height: 13),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: isDisabled
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                )),
                            child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Center(
                                  child: SizedBox(
                                    height: 50,
                                    width: 26,
                                    child: CircularProgressIndicator(
                                      color: companyColors.shade100,
                                    ),
                                  ),
                                )),
                            onPressed: () {},
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                )),
                            child: const Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'ENVIAR',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState?.validate() ?? false) {
                                formKey.currentState!.save();
                                if (widget.step == 1) {
                                  _controller.formFields.email =
                                      _formData['field'];
                                  disableButton();
                                }
                                if (widget.step == 2)
                                  _controller.formFields.code =
                                      _formData['field'];
                                if (widget.step == 3)
                                  _controller.formFields.newPassword =
                                      _formData['field'];

                                fieldText.clear();
                                widget.changeStep(
                                    widget.step, _controller.formFields);
                              }
                            },
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
