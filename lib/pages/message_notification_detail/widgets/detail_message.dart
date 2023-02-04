import 'package:flutter/material.dart';
import '../../../controllers/message_notification_controller.dart';
import 'detail_notification_iot.dart';

class DetailsMessage extends StatefulWidget {
  final String id;

  const DetailsMessage(this.id, {super.key});
  @override
  State<DetailsMessage> createState() => _DetailsMessageState();
}

class _DetailsMessageState extends State<DetailsMessage> {
  String title = "";
  String content = "";
  String deviceType = "";

  void initState() {
    MessageNotificationController.getMessageById(widget.id).then(
      (response) {
        if (response != null) {
          setState(
            () {
              content = response["content"];
              title = response["title"];
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            title == ""
                ? DetailsNotificationIoT(widget.id)
                : Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 14, 5, 2),
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 3, 25, 2),
              child: Text(
                content,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        )
      ],
    );
  }
}
