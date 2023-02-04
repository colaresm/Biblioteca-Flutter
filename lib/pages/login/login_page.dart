import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libraryWDA/pages/login/components/login_form.dart';
import 'package:libraryWDA/pages/login/components/login_logo.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  double? screenSize;
  bool? isSmallScreen;
  bool? rememberMe;

  bool calculateWidth() {
    isSmallScreen = screenSize! < 600;
    return isSmallScreen!;
  }

  Widget gap() => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: calculateWidth()
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LoginLogo(screenWidth: calculateWidth()),
                    LoginForm(screenWidth: calculateWidth()),
                  ],
                )
              : Container(
                  padding: EdgeInsets.all(32),
                  constraints: BoxConstraints(maxWidth: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: LoginLogo(screenWidth: calculateWidth())),
                      Expanded(
                        child: Center(
                            child: LoginForm(screenWidth: calculateWidth())),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
