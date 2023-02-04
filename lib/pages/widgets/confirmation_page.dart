import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:get/get.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () {
      Get.to(
        MainPage('queries-list-page', {}, 1),
        duration: Duration(seconds: 2),
        transition: Transition.fade,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/confirmation.png"),
            fit: BoxFit.cover,
          ),
        )));
  }
}
