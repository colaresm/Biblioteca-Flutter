import 'package:libraryWDA/utils/configurations.dart';

class UrlBuilderWithParamsHealthAPI {
  Uri defaultUrl(String path, Map<String, dynamic> params) {
    return Uri.http(Configurations.baseUrlHealthApi, path, params);
  }
}
