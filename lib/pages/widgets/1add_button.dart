import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/main/main_page.dart';

class AddButton extends StatelessWidget {
  String routeName;
  int navBarIndex;

  AddButton(this.routeName, this.navBarIndex);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(routeName, {}, navBarIndex),
            ),
          );
        },
        style: TextButton.styleFrom(
            fixedSize: const Size(100, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Colors.black),
        label: const Text(
          "Novo",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
