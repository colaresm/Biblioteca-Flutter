import 'package:flutter/material.dart';

import 'button_alert.dart';

class DetailsNotificationIoT extends StatefulWidget {
  final String id;

  const DetailsNotificationIoT(this.id, {super.key});
  @override
  State<DetailsNotificationIoT> createState() => _DetailsNotificationIoTState();
}

class _DetailsNotificationIoTState extends State<DetailsNotificationIoT> {
  String title = "";
  String content = "";
  String deviceType = "";

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        // ignore: prefer_const_constructors
        const Center(
          child: Text(
            "Cuidado!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
        ),
        const Center(
          child: Text(
            "Alerta urgente.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
          child: Center(
            child: Text(
              "O sistema detectou um conportamento atípico em seus indicadores de saúde.",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 3, 25, 2),
          child: Center(
            child: Text(
              deviceType,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        const Center(child: WidgetButtonAlerta()),
      ],
    ));
  }
}
