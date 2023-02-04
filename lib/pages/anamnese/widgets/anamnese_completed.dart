import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/pages/widgets/cancel_button.dart';

class AnamneseCompleted extends StatefulWidget {
  var anamnese;
  AnamneseCompleted(this.anamnese);

  @override
  State<AnamneseCompleted> createState() =>
      _AnamneseCompletedState(this.anamnese);
}

class _AnamneseCompletedState extends State<AnamneseCompleted> {
  var anamnese;
  _AnamneseCompletedState(this.anamnese);
  @override
  Widget build(BuildContext context) {
    backPage() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage("home", "", 0),
        ),
      );
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
                          padding: const EdgeInsets.fromLTRB(20, 15, 0, 10),
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
                                'Seu IMC é classificado como ' +
                                    anamnese['classificationOfIMC'],
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 18))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: CancelButton(backPage),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
