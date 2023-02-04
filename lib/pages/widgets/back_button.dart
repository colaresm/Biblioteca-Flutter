import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/main/main_page.dart';

class Backbutton extends StatelessWidget {
  String routeName;
  Object params;
  Backbutton(this.routeName, this.params);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: TextButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(routeName, params, 0),
            ),
          );
        },
        icon: const Icon(
          Icons.keyboard_return_outlined,
          color: Colors.black,
          size: 33,
        ),
        label: const Text(
          "Voltar",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
