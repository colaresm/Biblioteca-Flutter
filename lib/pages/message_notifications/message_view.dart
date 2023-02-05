import 'package:flutter/material.dart';
import 'package:libraryWDA/pages/widgets/emergency_button.dart';
import 'package:libraryWDA/pages/widgets/rent_button.dart';
import 'package:libraryWDA/pages/widgets/back_button.dart';
import 'package:libraryWDA/pages/message_notifications/widgets/list_message_card.dart';
import '../../controllers/authentication_controller.dart';

class WidgetMessageView extends StatelessWidget {
  final Object patientId;

  const WidgetMessageView({
    super.key,
    required this.patientId,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Backbutton("home", ""),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 25,
                ),
                child: const Text(
                  "Suas Mensagens",
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: WidgetMessageNotification(
                patientId: AuthenticationController.userPayload['patientId']
                    .toString(),
              ),
            )
          ],
        ),
        floatingActionButton: EmergencyButton('', 1));
  }
}
