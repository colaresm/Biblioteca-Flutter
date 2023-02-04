import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/anamnese/perform_anamnese.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/pages/widgets/cancel_button.dart';
import 'package:libraryWDA/pages/widgets/default_button.dart';

class AnamneseUnfulfilled extends StatefulWidget {
  const AnamneseUnfulfilled();

  @override
  State<AnamneseUnfulfilled> createState() => _AnamneseUnfulfilledState();
}

class _AnamneseUnfulfilledState extends State<AnamneseUnfulfilled> {
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
                    padding: const EdgeInsets.all(50.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                                'Não há histórico de anamneses realizadas. Para saber um pouco mais sobre sua saúde clique no botão a seguir e responda algumas perguntas sobre você',
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 18))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: DefaultButton(
                        'Realizar anamnese',
                        Icon(
                          Icons.question_answer_outlined,
                          color: Colors.white,
                        ), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PerformAnamnese(),
                        ),
                      );
                    }),
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
