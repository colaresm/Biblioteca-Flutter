import 'dart:convert';

import 'package:get/get.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/http/url_buider.dart';
import 'package:http/http.dart' as http;
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/models/message_notification.dart';

AuthenticationController authenticationController =
    new AuthenticationController();

class MessageNotificationController extends GetxController {
  static var urlBuider = UrlBuider();
  static var encoding = Encoding.getByName('utf-8');

  static Map<String, String> headers = {
    'Accept': 'application/json',
    'Accept-Language': 'en',
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000"
  };

  static Future<dynamic> getAll(patientId) async {
    try {
      headers.addAll(
          {"Authorization": '${authenticationController.getAcessToken()}'});
      final response = await http.get(
        urlBuider.defaultUrl(
            '/message-notifications/notifications-by-patient/$patientId'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final data = jsonResponse['messageNotificationsListItemResponse'] +
            jsonResponse['notificationsFromIoTListItemResponse'];
        return data.map((item) => MessageNotification.fromJson(item)).toList();
      } else {
        throw Exception("Não existem mensagens");
      }
    } catch (e) {
      return List.empty();
    }
  }

  static Future<dynamic> getMessageById(id) async {
    try {
      headers.addAll(
          {"Authorization": '${authenticationController.getAcessToken()}'});
      final response = await http.get(
        urlBuider.defaultUrl('/message-notifications/details/$id'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            as Map<dynamic, dynamic>;
      } else {
        throw Exception("Notificação de mensagem não econtrada");
      }
    } catch (e) {
      return List.empty();
    }
  }

  static Future<dynamic> getIoTById(id) async {
    try {
      headers.addAll({
        'Authorization':
            "Bearer ${AuthenticationController.tokens['access_token']}"
      });
      final response = await http.get(
        urlBuider.defaultUrl('/ioT-devices/$id'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes))
            as Map<dynamic, dynamic>;
      } else {
        throw Exception("Notificação de IoT não econtrada");
      }
    } catch (e) {
      return List.empty();
    }
  }
}
