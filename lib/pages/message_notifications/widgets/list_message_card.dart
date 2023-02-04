import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libraryWDA/controllers/message_notification_controller.dart';
import 'package:libraryWDA/utils/utf8_decode.dart';

import '../../../utils/message_type_color.dart';
import '../../../utils/message_type_icon.dart';
import 'card_message.dart';

class WidgetMessageNotification extends StatefulWidget {
  final String patientId;

  const WidgetMessageNotification({super.key, required this.patientId});

  @override
  State<WidgetMessageNotification> createState() =>
      _WidgetMessageNotificationState();
}

class _WidgetMessageNotificationState extends State<WidgetMessageNotification> {
  @override
  Widget build(BuildContext context) {
    final DecodeUTF8 decodeUTF8 = new DecodeUTF8();
    return FutureBuilder(
      future: MessageNotificationController.getAll(widget.patientId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Não existe mensagem!",
                  style: TextStyle(
                    fontFamily: "Fredoka",
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                reverse: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                ),
                itemBuilder: (context, index) {
                  final message = snapshot.data?[index];
                  return WidgetCardMessage(
                    id: message.id,
                    title: decodeUTF8.decodeString(
                        message?.messageType == "NEW_MESSAGE"
                            ? message.title
                            : message.deviceType),
                    color: messageTypeColor(message?.messageType),
                    icon: messageTypeIcon(message?.messageType),
                    typeMessege: message?.messageType,
                  );
                },
              );
            }
        }
      },
    );
  }
}
