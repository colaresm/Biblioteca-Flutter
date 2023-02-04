import 'dart:convert';
import 'package:get/get.dart';
import 'package:libraryWDA/http/url_builder_with_params.dart';
import 'package:libraryWDA/http/url_buider.dart';
import 'package:libraryWDA/http/http.dart';
import 'package:libraryWDA/main.dart';
import 'package:libraryWDA/models/user_authenticate.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:http/http.dart' as http;

class AuthenticationController extends GetxController {
  static var client = http.Client();
  final myTokens = Hive.box('tokens');
  static Map<String, dynamic> tokens = {};
  static var urlBuider = UrlBuilderWithParams();
  static var urlBuiderPatient = UrlBuider();
  static var encoding = Encoding.getByName('utf-8');
  static Map<String, dynamic> params = {};
  static Map<dynamic, dynamic> userPayload = {}.obs;
  static Map<String, String> headers = {...HttpConfig.headers};
  static String _access_token = '';
  Future<void> login(UserAuthenticate user, bool keepConnection) async {
    params.addAll({
      'username': user.username,
      'password': user.password,
    });

    final response = await http.post(
      urlBuider.defaultUrl('/authentication/login', params),
      headers: headers,
      encoding: encoding,
      body: user.toJson(),
    );
    params = {};

    if (response.statusCode == 200) {
      tokens = jsonDecode(utf8.decode(response.bodyBytes));
      Get.snackbar('Sucesso', 'Logado no sistema',
          backgroundColor: companyColors.shade400,
          borderWidth: 4,
          colorText: companyColors.shade100,
          borderColor: companyColors.shade100);

      if (keepConnection) {
        for (var token in tokens.entries) {
          myTokens.put(token.key, 'Bearer ${token.value}');
        }
        await payload(myTokens.get('access_token'));
        Get.offNamed('/homepage');
      } else {
        await payload('Bearer ${tokens['access_token']}');
        Get.offNamed('/homepage');
      }
    } else {
      Get.snackbar('Erro', 'Credenciais inválidas',
          backgroundColor: companyColors.shade600,
          borderWidth: 4,
          colorText: companyColors.shade100,
          borderColor: companyColors.shade100);
    }
  }

  getAcessToken() {
    return _access_token;
  }

  static Future<bool> payload(token) async {
    if (token == null) return false;
    Map<String, String> customHeader = {...headers};

    customHeader.addAll({'Authorization': token});
    _access_token = token.toString();
    final response = await client.get(
      urlBuider.defaultUrl('/authentication/token/payload', params),
      headers: customHeader,
    );
    if (response.statusCode == 200) {
      userPayload =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;

      return true;
    }
    return false;
  }
}
