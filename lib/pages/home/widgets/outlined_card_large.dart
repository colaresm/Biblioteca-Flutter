import 'package:flutter/material.dart';

class OutlinedCardLarge extends StatelessWidget {
  final IconData iconLeft;
  final IconData iconRight;

  OutlinedCardLarge(this.iconLeft, this.iconRight);

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
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: TextButton(
                  onPressed: () {
                    print('mensagem');
                  },
                  child: Row(
                    children: [
                      Icon(
                        iconLeft,
                        color: Color.fromRGBO(0, 191, 166, 10),
                        size: 30,
                      ),
                      Text('mensagens',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color.fromRGBO(0, 191, 166, 10),
                          ))
                    ],
                  ),
                )),
                SizedBox(width: 55),
                Container(
                    child: TextButton(
                  onPressed: () {
                    print('alertas');
                  },
                  child: Row(
                    children: [
                      Icon(
                        iconRight,
                        color: Color.fromRGBO(255, 0, 48, 10),
                        size: 30,
                      ),
                      Text('alertas',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color.fromRGBO(255, 0, 48, 10),
                          ))
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
