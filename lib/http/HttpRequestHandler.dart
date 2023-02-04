import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/http/url_buider.dart';
import 'package:libraryWDA/http/url_builder_with_params.dart';
import 'package:libraryWDA/http/url_builder_health_api.dart';

class HttpRequestHandler {
  AuthenticationController authenticationController =
      new AuthenticationController();
  var client = http.Client();
  var urlBuider = UrlBuider();
  var urlBuilderWithParams = UrlBuilderWithParams();
  var urlBuilderWithParamsHealthAPI = UrlBuilderWithParamsHealthAPI();
  getHeaders() {
    return {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": '${authenticationController.getAcessToken()}'
    };
  }

  updateProfilePicture(url, patient) async {
    var uri = urlBuider.defaultUrl(url);
    var request = http.MultipartRequest('PUT', uri)
      ..headers.addAll(getHeaders())
      ..fields['id'] = patient['id'];

    if (patient['profilePicture'] != null) {
      Uint8List bytes = patient['profilePicture']['bytes'];

      var stream = new http.ByteStream.fromBytes(bytes);

      stream.cast();

      var multipartFile = new http.MultipartFile(
          'profilePicture', stream, patient['profilePicture']['size'],
          filename: patient['profilePicture']['name']);

      request.files.add(multipartFile);
      await request.send();
    } else {
      await request.send();
    }
  }

  post(url, body) async {
    final response = await client.post(
      urlBuider.defaultUrl(url),
      headers: getHeaders(),
      body: jsonEncode(body),
    );
    if (response.statusCode == 400) return throw Exception('Erro');
  }

  put(url, body) async {
    final response = await client.put(
      urlBuider.defaultUrl(url),
      headers: getHeaders(),
      body: jsonEncode(body),
    );
  }

  geListWithBody(url, params, Function data) async {
    final response = await client.get(
      urlBuilderWithParams.defaultUrl(url, params),
      headers: getHeaders(),
    );

    if ((json.decode(response.body) as List).isNotEmpty) {
      return data((json.decode(response.body) as List));
    } else {
      throw Exception;
    }
  }

  getList(url, Function data) async {
    final response = await client.get(
      urlBuider.defaultUrl(url),
      headers: getHeaders(),
    );

    if ((json.decode(response.body) as List).isNotEmpty) {
      return data((json.decode(response.body) as List));
    } else {
      throw Exception;
    }
  }

  getItemWithBody(url, params) async {
    final response = await client.get(
      urlBuider.defaultUrl(url + params),
      headers: getHeaders(),
    );
    if (response.bodyBytes.isNotEmpty) {
      return jsonDecode(utf8.decode(response.bodyBytes))
          as Map<dynamic, dynamic>;
    } else {
      return null;
    }
  }

  delete(url, id) async {
    await client.delete(urlBuider.defaultUrl(url + id), headers: getHeaders());
  }

  patch(url, params) async {
    final response = await client.patch(urlBuider.defaultUrl(url + params),
        headers: getHeaders());
  }

  getRiskOfAVC(url, final params) async {
    Map<String, dynamic> riskOfAVCParameters = {};

    List<String> keys = params.keys.toList();
    for (var i = 0; i < keys.length; i++) {
      riskOfAVCParameters[keys[i]] = params[keys[i]].toString();
    }

    final response = await client.get(
      urlBuilderWithParamsHealthAPI.defaultUrl(url, riskOfAVCParameters),
    );

    return jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
  }
}
