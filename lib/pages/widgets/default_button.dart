import 'package:flutter/material.dart';

class DefaultButton extends StatefulWidget {
  String label;
  Icon icon;
  Function function;
  DefaultButton(this.label, this.icon, this.function);

  @override
  State<DefaultButton> createState() =>
      _DefaultButtonState(this.label, this.icon, this.function);
}

class _DefaultButtonState extends State<DefaultButton> {
  String label;
  Icon icon;
  Function function;
  _DefaultButtonState(this.label, this.icon, this.function);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
          onPressed: () {
            function();
          },
          style: TextButton.styleFrom(
              fixedSize: const Size(265, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: Colors.black),
          label: Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          icon: icon),
    );
  }
}
