import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/anamnese_controller.dart';
import 'package:libraryWDA/pages/anamnese/widgets/anamnese_result.dart';
import 'package:libraryWDA/pages/anamnese/widgets/anamnese_form.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/pages/widgets/cancel_button.dart';
import 'package:libraryWDA/pages/widgets/default_button.dart';

class PerformAnamnese extends StatefulWidget {
  const PerformAnamnese({super.key});

  @override
  State<PerformAnamnese> createState() => _PerformAnamneseState();
}

class _PerformAnamneseState extends State<PerformAnamnese> {
  performAnamnese(anamnese) {
    AnamneseController.getRiskOfAVC(anamnese).then(
      (response) {
        anamnese['riskofStroke'] = response['risk_of_stroke'];
        anamnese['IMCPatient'] = response['IMC'];
        anamnese['classificationOfIMC'] = response['classification_of_IMC'];
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AnamnesePreview(anamnese)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
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
                            Text('Realizar anamnese',
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.white)),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MainPage("home", "", 0),
                                  ),
                                );
                                ;
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
            MyCustomForm(performAnamnese)
          ],
        )),
      ),
    );
  }
}
