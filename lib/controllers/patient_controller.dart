import 'package:get/get.dart';
import 'package:libraryWDA/http/HttpRequestHandler.dart';
import 'package:http/http.dart' as http;

HttpRequestHandler httpRequestHandler = new HttpRequestHandler();

class PatientController extends GetxController {
  static Future<dynamic> getUserDetails(String patientId) async {
    return httpRequestHandler.getItemWithBody('/patients/', patientId);
  }

  static Future<dynamic> getUserDetailsToUpdate(String patientId) async {
    return httpRequestHandler.getItemWithBody(
        '/patients/patient-details/', patientId);
  }

  static Future<dynamic> updateDetails(patient) async {
    return httpRequestHandler.put('/patients/update-details', patient);
  }

  static Future<dynamic> updatePassword(patient) async {
    return httpRequestHandler.put('/patients/update-password', patient);
  }

  static Future<dynamic> updateProfilePicture(patient) async {
    return httpRequestHandler.updateProfilePicture(
        '/patients/update-profile-picture', patient);
  }
}
