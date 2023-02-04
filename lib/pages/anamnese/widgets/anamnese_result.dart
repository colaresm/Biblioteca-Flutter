import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/anamnese_controller.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/pages/widgets/cancel_button.dart';
import 'package:libraryWDA/pages/widgets/default_button.dart';
import 'package:get/get.dart';
import 'package:libraryWDA/main.dart';

class AnamnesePreview extends StatefulWidget {
  var anamnese;
  AnamnesePreview(this.anamnese);

  @override
  State<AnamnesePreview> createState() => _AnamnesePreviewState(this.anamnese);
}

class _AnamnesePreviewState extends State<AnamnesePreview> {
  var anamnese;
  _AnamnesePreviewState(this.anamnese);
  backPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage('home', {}, 0)),
    );
  }

  saveAnamnese() {
    AnamneseController.create(anamnese);
    Get.snackbar('Sucesso', 'Anamnese salva com sucesso',
        backgroundColor: companyColors.shade400,
        borderWidth: 4,
        colorText: companyColors.shade100,
        borderColor: companyColors.shade100);
    backPage();
  }

  @override
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
                    height: MediaQuery.of(context).size.height * 0.25,
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
                              Expanded(
                                  child: Text('Resumo da anamnese',
                                      style: const TextStyle(
                                          fontSize: 24, color: Colors.white))),
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
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        '*Os resultados exibidos são meras hipóteses diagnósticas. Para mais informações recomenda-se a realização de uma consulta médica.',
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 18)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                                '${'A probabilidade de ocorrência de um AVC nos próximos 10 anos é de aproximadamente ' + anamnese['riskofStroke'].toString()}%.',
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 18))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                                'Seu IMC vale ' +
                                    anamnese['IMCPatient'].toString() +
                                    ' sendo classificado como ' +
                                    anamnese['classificationOfIMC'],
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 18))),
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
                        ), () {
                      saveAnamnese();
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: CancelButton(() {
                      () {
                        backPage();
                      };
                    }),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
