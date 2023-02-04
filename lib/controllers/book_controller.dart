import 'dart:convert';
import 'package:get/get.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/http/url_buider.dart';
import 'package:libraryWDA/mapper/mapper.dart';
import 'package:libraryWDA/models/query_list_item.dart';
import 'package:libraryWDA/models/exam_list_item.dart';
import 'package:http/http.dart' as http;
import 'package:libraryWDA/http/HttpRequestHandler.dart';

HttpRequestHandler httpRequestHandler = new HttpRequestHandler();
Mapper mapper = new Mapper();

class BookController extends GetxController {
  static var client = http.Client();

  static var urlBuider = UrlBuider();
  static var encoding = Encoding.getByName('utf-8');
  static Map<String, dynamic> params = {};

  static Future<dynamic> getBooks(patientId) async {
    return httpRequestHandler.getList('/books/list', mapper.toBookListItem);
  }

  static Future<dynamic> getExamsList(patientId) async {
    return httpRequestHandler.getList(
        '/queries/get-exams-by-patientId/', mapper.toBookListItem);
  }

  static Future<dynamic> getBook(id) async {
    return httpRequestHandler.getItemWithBody('/books/', id);
  }

  static Future<void> confirmSchedule(String scheduleId) async {
    final url = urlBuider.defaultUrl('/schedules/set-to-confirmed/$scheduleId');
    final response = await client.patch(url, headers: {
      "Authorization":
          'Bearer ' + AuthenticationController.tokens['access_token']
    });
  }
}
