import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/widgets/back_button.dart';
import 'package:libraryWDA/pages/widgets/emergency_button.dart';

import 'widgets/publishingCompanyCardItem.dart';

class PublishingCompanyList extends StatefulWidget {
  const PublishingCompanyList({super.key});

  @override
  State<PublishingCompanyList> createState() => _PublishingCompanyListState();
}

class _PublishingCompanyListState extends State<PublishingCompanyList> {
  @override
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
                            child: Text('Lista de editoras cadastradas',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                        ],
                      ),
                      Container(
                        child: PublishingCompanyCardItem(),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        floatingActionButton:
            EmergencyButton('register-and-edit-publishing-company', 1));
  }
}
