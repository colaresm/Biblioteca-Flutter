import 'package:flutter/material.dart';

class ScheduleButton extends StatelessWidget {
  const ScheduleButton({super.key});

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
            backgroundColor: Colors.black),
        label: const Text(
          "Agendar consulta",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.calendar_today,
          color: Color.fromARGB(255, 226, 151, 151),
        ),
      ),
    );
  }
}
