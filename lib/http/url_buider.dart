import 'package:libraryWDA/utils/configurations.dart';

class UrlBuider {
  Uri defaultUrl(String path) {
    return Uri.http(Configurations.baseUrl, '/api$path');
  }
}
