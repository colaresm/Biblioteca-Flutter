import 'dart:convert';
import 'package:get/get.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/http/url_buider.dart';
import 'package:libraryWDA/mapper/mapper.dart';
import 'package:libraryWDA/models/book_list_item.dart';
import 'package:libraryWDA/models/exam_list_item.dart';
import 'package:http/http.dart' as http;
import 'package:libraryWDA/http/HttpRequestHandler.dart';

HttpRequestHandler httpRequestHandler = new HttpRequestHandler();
Mapper mapper = new Mapper();

class PublishingCompanyController extends GetxController {
  static var client = http.Client();

  static var urlBuider = UrlBuider();
  static var encoding = Encoding.getByName('utf-8');
  static Map<String, dynamic> params = {};

  static Future<dynamic> getCompanys() async {
    return httpRequestHandler.getList(
        '/publishing-company/list', mapper.toPublishingCompanyListItem);
  }

  static Future<dynamic> create(publishingCompany) async {
    print(httpRequestHandler.post('/publishing-company', publishingCompany));
    return httpRequestHandler.post('/publishing-company', publishingCompany);
  }
}
