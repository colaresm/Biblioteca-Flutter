import 'dart:convert';

class DecodeUTF8 {
  decodeString(String stringToDecode) {
    return utf8.decode(latin1.encode(stringToDecode), allowMalformed: true);
  }
}
