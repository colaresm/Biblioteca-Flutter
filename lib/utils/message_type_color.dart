import 'dart:ui';

Color messageTypeColor(String type) {
  Color color = const Color.fromRGBO(137, 137, 137, 100);
  switch (type) {
    case "NEW_MESSAGE":
      color = const Color.fromRGBO(0, 191, 166, 100);
      break;
    case "NEW_ALERT":
      color = const Color.fromRGBO(255, 0, 51, 100);
      break;
    case "ALERT_READ":
      color = const Color.fromRGBO(137, 137, 137, 100);
      break;
  }
  return color;
}
