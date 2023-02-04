import 'package:libraryWDA/utils/configurations.dart';

class UrlBuilderWithParams {
  Uri defaultUrl(String path, Map<String, dynamic> params) {
    return Uri.http(Configurations.baseUrl, '/api$path', params);
  }
}
