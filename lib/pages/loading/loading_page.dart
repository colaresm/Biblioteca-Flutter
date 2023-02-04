import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:hive_flutter/adapters.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final myTokens = Hive.box('tokens');
  var hasUserLogged = false;

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () async {
      if (myTokens.get('access_token') != null &&
          await AuthenticationController.payload(
              myTokens.get('access_token'))) {
        Get.offNamed('/homepage');
      } else {
        Get.offNamed('/login');
      }
    });

    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
