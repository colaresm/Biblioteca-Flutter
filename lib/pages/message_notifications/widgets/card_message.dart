//import 'dart:html';

import 'package:flutter/material.dart';
import '../../main/main_page.dart';

class WidgetCardMessage extends StatelessWidget {
  const WidgetCardMessage(
      {super.key,
      required this.title,
      required this.icon,
      required this.color,
      required this.typeMessege,
      required this.id});

  final Object id;
  final String title;
  final String typeMessege;
  final IconData icon;
  final Color color;

  String type(params) {
    switch (params) {
      case "NEW_MESSAGE":
        return 'Nova Mensagem';
      case "NEW_ALERT":
        return 'Nova Alerta';
      case "MESSAGE_READ":
        return 'Mensagem Lida';
      case "ALERT_READ":
        return 'Alerta Lida';
      default:
        return 'Mensagem';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          ListTile(
            // ignore: unnecessary_const
            trailing: Icon(
              icon,
              color: const Color.fromARGB(255, 255, 255, 255),
              size: 35,
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Fredoka',
                fontWeight: FontWeight.w500,
              ),
            ),
            textColor: const Color.fromARGB(255, 255, 255, 255),
            subtitle: Text(
              type(typeMessege),
              style: const TextStyle(
                fontFamily: 'Fredoka',
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(
                    "messages-details",
                    {
                      "id": id,
                    },
                    0,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
