import 'package:flutter/material.dart';

class CancelButton extends StatefulWidget {
  Function function;
  CancelButton(this.function);

  @override
  State<CancelButton> createState() => _CancelButtonState(this.function);
}

class _CancelButtonState extends State<CancelButton> {
  Function function;
  _CancelButtonState(this.function);
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          function();
        },
        child: Text('CANCELAR', style: TextStyle(fontSize: 18, color: Colors.white)),
        style: TextButton.styleFrom(
            fixedSize: const Size(265, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.grey));
  }
}
