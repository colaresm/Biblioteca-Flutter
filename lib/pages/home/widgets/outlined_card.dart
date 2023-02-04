import 'package:flutter/material.dart';

import '../../main/main_page.dart';

class OutlinedCard extends StatelessWidget {
  final String labelCard;
  final IconData iconCard;
  final Function function;
  OutlinedCard(this.labelCard, this.iconCard, this.function);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                const BoxShadow(color: Colors.white, spreadRadius: 1),
              ],
            ),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  elevation: 0,
                  child: Container(
                    width: 320,
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        function();
                      },
                      child: Icon(
                        iconCard,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(labelCard),
        ),
      ],
    );
  }
}
