import 'package:get/get.dart';
import 'package:libraryWDA/http/HttpRequestHandler.dart';

HttpRequestHandler httpRequestHandler = new HttpRequestHandler();

class AnamneseController extends GetxController {
  static Future<dynamic> getRiskOfAVC(anamnese) async {
    return httpRequestHandler.getRiskOfAVC('/get_risks', anamnese);
  }

  static Future<dynamic> create(anamnese) async {
    return httpRequestHandler.post('/health-questionnaire', anamnese);
  }

  static Future<dynamic> getByPatientId(patientId) async {
    return httpRequestHandler.getItemWithBody(
        '/health-questionnaire/', patientId);
  }
}
