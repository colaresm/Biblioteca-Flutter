import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/rent/widgets/rent_cards_list.dart';
import 'package:libraryWDA/pages/widgets/back_button.dart';
import 'package:libraryWDA/pages/widgets/emergency_button.dart';

class RentList extends StatefulWidget {
  RentList();

  @override
  State<RentList> createState() => _RentListState();
}

class _RentListState extends State<RentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: IndexedStack(
          index: 0,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(3, 0, 10, 5),
                      child: Backbutton('home', ""),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(40, 8, 5, 2),
                          child: Text('Lista de aluguéis cadastrados',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                        ),
                      ],
                    ),
                    RentCardItem(),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
