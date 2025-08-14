import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

// Config for different devices..
class AppConfig {
  static String get baseUrl {
    if (kIsWeb) {
      // For web..
      return 'http://127.0.0.1:5000';
    }
    if (Platform.isAndroid) {
      // For Android..
      return 'http://10.0.2.2:5000';
    } else if (Platform.isIOS) {
      // For iOS..
      return 'http://127.0.0.1:5000';
    } else {
      // For Desktop..
      return 'http://127.0.0.1:5000';
    }
  }
}
