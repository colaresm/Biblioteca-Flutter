import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/anamnese_controller.dart';
import 'package:libraryWDA/pages/anamnese/perform_anamnese.dart';
import 'package:libraryWDA/pages/anamnese/widgets/anamnese_result.dart';
import 'package:libraryWDA/pages/anamnese/widgets/anamnese_sumary.dart';
import 'package:libraryWDA/pages/home/widgets/outlined_card_small.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/pages/widgets/emergency_button.dart';
import './widgets/outlined_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  viewMessages() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage("messages-page", "", 0),
      ),
    );
  }

  peformAnamnese() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PerformAnamnese(),
      ),
    );
  }

  previewAnamnese() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnamneseSumary(
            AuthenticationController.userPayload["patientId"].toString()),
      ),
    );
  }

  goToBooks() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(
          "books-list",
          "",
          1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(60),
                    child: Image.asset('assets/images/header.png',
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    child: const Text(
                      'Alugéis',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 3, 10),
                        child: OutlinedCard(
                            'Alugar livro', Icons.menu_book, goToBooks),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: const Text('Livros',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 3, 10),
                        child: OutlinedCard('Ver Livros',
                            Icons.book_online_outlined, goToBooks),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
