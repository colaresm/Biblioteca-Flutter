import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  bool screenWidth;

  LoginLogo({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).size.height < 580
          ? EdgeInsets.only(bottom: 20)
          : EdgeInsets.only(bottom: 40),
      child: Image.asset(
        'assets/images/login-image.png',
        width: screenWidth ? 1000 : 2000,
      ),
    );
  }
}
