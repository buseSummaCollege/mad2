import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformServices {
  static bool get isMobile {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isIOS || Platform.isAndroid;
    }
  }

  static bool get isDesktop {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isLinux ||
          Platform.isFuchsia ||
          Platform.isWindows ||
          Platform.isMacOS;
    }
  }

  static bool get isAndroid {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isAndroid;
    }
  }
}
