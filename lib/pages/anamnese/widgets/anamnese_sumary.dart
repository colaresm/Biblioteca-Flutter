import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libraryWDA/controllers/anamnese_controller.dart';
import 'package:libraryWDA/pages/anamnese/widgets/anamnese_completed.dart';
import 'package:libraryWDA/pages/anamnese/widgets/anamnese_unfulfilled.dart';
import 'package:libraryWDA/pages/loading/loading_page.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/pages/widgets/cancel_button.dart';

class AnamneseSumary extends StatefulWidget {
  String patientId;
  AnamneseSumary(this.patientId);

  @override
  State<AnamneseSumary> createState() => _AnamneseSumaryState(this.patientId);
}

class _AnamneseSumaryState extends State<AnamneseSumary> {
  backPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage("home", "", 0),
      ),
    );
  }

  String patientId;
  bool isLoading = true;
  _AnamneseSumaryState(this.patientId);
  var anamnese = {};
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      AnamneseController.getByPatientId(patientId).then(
        (response) {
          setState(() {
            if (response != null) {
              anamnese = response;
            }

            isLoading = false;
          });
        },
      );
    });
  }

  Widget getSumary() {
    if (anamnese.isEmpty && isLoading == false) {
      return AnamneseUnfulfilled();
    }
    if (anamnese.isNotEmpty && isLoading == false) {
      return AnamneseCompleted(anamnese);
    } else
      return Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Expanded(
                      child: Text(
                    '  Carregando dados...',
                    style: TextStyle(fontSize: 18),
                  )),
                )
              ],
            ),
          ),
        ],
      );
  }

  Widget build(BuildContext context) {
    return getSumary();
  }
}
