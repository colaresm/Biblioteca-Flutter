import 'package:flutter/material.dart';

class RentButton extends StatelessWidget {
  Function function;
  RentButton(this.function);

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
        label: const Text(
          "Alugar livro",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.bookmark_add,
          color: Colors.white,
        ),
      ),
    );
  }
}
