import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/widgets/back_button.dart';
import 'package:libraryWDA/pages/widgets/rent_button.dart';

class QueryCanceled extends StatefulWidget {
  String status;
  QueryCanceled(this.status);
  State<QueryCanceled> createState() => _QueryCanceledState(this.status);
}

class _QueryCanceledState extends State<QueryCanceled> {
  Map<String, dynamic> paramsToMap = {};
  String status;
  _QueryCanceledState(this.status);
  canceledBy(status) {
    List<String> statusList = [
      'CANCELED_BY_CLINIC',
      'CANCELED_BY_DOCTOR',
      'CANCELED_BY_PATIENT',
      'UNREALIZED'
    ];
    List<String> listOfStatusValues = [
      'Consulta cancelada pela clínica',
      'Consulta cancelada pelo médico',
      'Consulta cancelada pelo paciente',
      'Consulta não realizada'
    ];
    for (var statusSelected in statusList) {
      if (statusSelected == status) {
        return listOfStatusValues[statusList.indexOf(statusSelected)];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
              child: Backbutton("home", ""),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 40),
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: new Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                            "${canceledBy(status)}. Caso deseje realizar um novo agendamento bastar clicar no botão abaixo.",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.justify),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
