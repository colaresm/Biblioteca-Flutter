import 'dart:convert';

import 'package:get/get.dart';
import 'package:libraryWDA/http/url_builder_with_params.dart';
import 'package:libraryWDA/http/http.dart';
import 'package:libraryWDA/main.dart';
import 'package:libraryWDA/models/recover_password.dart';
import 'package:http/http.dart' as http;

class RecoverPasswordController extends GetxController {
  static var client = http.Client();
  static var urlBuider = UrlBuilderWithParams();
  static var encoding = Encoding.getByName('utf-8');
  static Map<String, dynamic> params = {};
  static Map<String, String> headers = {...HttpConfig.headers};
  RecoverPassword formFields = RecoverPassword();
  static String message = '';
  int step = 1;
  String actionText = 'Insira o email para recuperação';
  String inputLabel = 'Email';

  Future<bool> recoverPassword(RecoverPassword recoverRequest) async {
    String path = '';
    switch (step) {
      case 1:
        path = '/recover-password';
        break;
      case 2:
        path = '/recover-password/confirm';
        break;
      case 3:
        path = '/recover-password/change-password';
        break;
    }
    headers.addAll({'Content-Type': 'application/json', 'Accept': '*/*'});
    final response = await client.post(
      urlBuider.defaultUrl('/authentication$path', params),
      headers: headers,
      encoding: encoding,
      body: jsonEncode(recoverRequest.toJson()),
    );
    message = response.body;
    if (response.statusCode == 200) {
      Get.snackbar('Sucesso', message,
          backgroundColor: companyColors.shade400,
          borderWidth: 4,
          colorText: companyColors.shade100,
          borderColor: companyColors.shade100);
      return true;
    } else {
      Get.snackbar('Erro', message,
          backgroundColor: companyColors.shade600,
          borderWidth: 4,
          colorText: companyColors.shade100,
          borderColor: companyColors.shade100);
      return false;
    }
  }
}
