import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/book_controller.dart';
import 'package:libraryWDA/pages/widgets/confirmation_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class Confirmbutton extends StatelessWidget {
  String scheduleId;
  Confirmbutton(this.scheduleId);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          BookController.confirmSchedule(scheduleId);

          Get.to(
            ConfirmationPage(),
            duration: Duration(seconds: 2),
            transition: Transition.fade,
          );
        },
        style: TextButton.styleFrom(
            fixedSize: const Size(265, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.blue),
        label: const Text(
          "CONFIRMAR",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Fredoka",
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}
