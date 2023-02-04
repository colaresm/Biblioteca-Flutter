import 'package:get/get.dart';
import 'package:libraryWDA/http/HttpRequestHandler.dart';
import 'package:libraryWDA/mapper/mapper.dart';

Mapper mapper = new Mapper();
HttpRequestHandler httpRequestHandler = new HttpRequestHandler();

class DoctorController extends GetxController {
  static Future<dynamic> getDoctorsList(params) async {
    return httpRequestHandler.geListWithBody(
        '/professionals/doctors/filtered-by-speciality-and-cityLocation',
        params,
        mapper.toDoctorListItem);
  }

  static Future<dynamic> getLinkedDoctorsList(String patientId) async {
    return httpRequestHandler.geListWithBody(
        '/professionals/doctors/linked-to-patient',
        {'patientId': patientId},
        mapper.toDoctorListItem);
  }

  static Future<dynamic> deleteAccompayingDoctor(String doctorId) async {
    return httpRequestHandler.delete('/accompanying-doctors/', doctorId);
  }
}
