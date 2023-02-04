import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/main/main_page.dart';

class OutlinedCardSmall extends StatelessWidget {
  final String labelCard;
  final IconData iconCard;
  final Color color;
  late Object id;
  Function function;
  OutlinedCardSmall(this.labelCard, this.iconCard, this.color, this.function);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: SizedBox(
            width: 120,
            height: 40,
            child: Row(
              children: [
                Container(
                    child: TextButton(
                  onPressed: () {
                    function();
                  },
                  child: Row(
                    children: [
                      Icon(
                        iconCard,
                        color: color,
                        size: 30,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          labelCard,
                          style: TextStyle(fontSize: 14, color: color),
                        ),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
