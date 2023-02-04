import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libraryWDA/main.dart';

class RecoverPasswordSuccess extends StatelessWidget {
  const RecoverPasswordSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 10), () {
      Get.offNamed('/login');
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(
                  'assets/images/confirmed-image.png',
                  height: MediaQuery.of(context).size.height * 0.8,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Text(
                    'Confirmado',
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.height > 600 ? 42 : 35,
                      fontWeight: FontWeight.w500,
                      color: companyColors.shade50,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: companyColors.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'VOLTAR',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                onPressed: () {
                  Get.offNamed('/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
