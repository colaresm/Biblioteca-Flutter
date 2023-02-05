import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/anamnese_controller.dart';
import 'package:libraryWDA/pages/anamnese/perform_anamnese.dart';
import 'package:libraryWDA/pages/anamnese/widgets/anamnese_result.dart';
import 'package:libraryWDA/pages/anamnese/widgets/anamnese_sumary.dart';
import 'package:libraryWDA/pages/home/widgets/outlined_card_small.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/pages/widgets/carousel_slider.dart';
import 'package:libraryWDA/pages/widgets/emergency_button.dart';
import './widgets/outlined_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final List<String> imgList = [
  "assets/images/lost.jpg",
  "assets/images/cdz.jpg",
  "assets/images/livro.jpg",
  "assets/images/java.jpg"
];

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.8);
  }

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
                height: 200,
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(60),
                    child: Image.asset('assets/images/header.png',
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Center(
                    child: Text(
                  'Conheça nosso acervo',
                  style: TextStyle(
                    fontSize: 28,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.black,
                  ),
                )),
              ),
              Container(
                  child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                ),
                items: imgList
                    .map((item) => Container(
                          child: Center(
                              child: Image.asset(
                            item,
                            fit: BoxFit.fill,
                            width: 1000,
                            height: 1000,
                          )),
                        ))
                    .toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
