import 'package:flutter/material.dart';

class WidgetButtonAlerta extends StatelessWidget {
  const WidgetButtonAlerta({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () {},
        style: TextButton.styleFrom(
            fixedSize: const Size(265, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: const Color.fromARGB(255, 223, 2, 2)),
        label: const Text(
          "Chamada de emergência",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Fredoka",
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.phone_in_talk,
          color: Colors.white,
        ),
      ),
    );
  }
}
