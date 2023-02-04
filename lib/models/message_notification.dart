import 'package:flutter/cupertino.dart';

class MessageNotification {
  String? id;
  String? title;
  String? content;
  String? messageType;

  String? deviceType;
  String? classificationNotification;
  String? doctorName;

  MessageNotification(
      {this.id,
      this.title,
      this.content,
      this.messageType,
      this.deviceType,
      this.classificationNotification,
      this.doctorName});

  MessageNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    doctorName = json['doctorName'];
    messageType = json['messageType'];
    deviceType = json['deviceType'];
    classificationNotification = json['classificationNotification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['doctorName'] = doctorName;
    data['messageType'] = messageType;
    data['deviceType'] = deviceType;
    data['classificationNotification'] = classificationNotification;

    return data;
  }
}
