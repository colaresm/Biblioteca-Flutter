import 'package:flutter/material.dart';

IconData messageTypeIcon(String type) {
  IconData icon = Icons.mark_email_read;
  switch (type) {
    case "NEW_MESSAGE":
      icon = Icons.email;
      break;
    case "NEW_ALERT":
      icon = Icons.warning;
      break;
    case "ALERT_READ":
      icon = Icons.mark_email_read;
      break;
  }
  return icon;
}
