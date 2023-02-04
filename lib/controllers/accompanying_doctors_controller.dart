import 'package:get/get.dart';
import 'package:libraryWDA/http/HttpRequestHandler.dart';

HttpRequestHandler httpRequestHandler = new HttpRequestHandler();

class AccompanyingDoctorsController extends GetxController {
  static Future<dynamic> create(accompanyingDoctor) async {
    httpRequestHandler.post('/accompanying-doctors', accompanyingDoctor);
  }
}
