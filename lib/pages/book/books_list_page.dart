import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/pages/book/widgets/book_card_item.dart';
import 'package:libraryWDA/pages/widgets/1add_button.dart';
import 'package:libraryWDA/pages/widgets/emergency_button.dart';
import 'package:libraryWDA/pages/widgets/rent_button.dart';
import 'package:libraryWDA/pages/widgets/back_button.dart';

class BookPageList extends StatefulWidget {
  @override
  State<BookPageList> createState() => _BookPageList();
}

class _BookPageList extends State<BookPageList> {
  @override
  int _valor = 0;

  void _change(bool isViewBookDetails) {
    if (isViewBookDetails == true) {
      setState(() {
        _valor = 1;
      });
    }
    if (isViewBookDetails == false) {
      setState(() {
        _valor = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: IndexedStack(
            index: _valor,
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
                            child: Text('Lista de livros cadastrados',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                        ],
                      ),
                      Container(
                        child: BookCardItem(
                          patientId: AuthenticationController
                              .userPayload["patientId"]
                              .toString(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: EmergencyButton('register-and-edit-book', 2));
  }
}
