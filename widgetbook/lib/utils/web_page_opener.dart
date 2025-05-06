// platform_specific_web.dart

import 'package:web/web.dart';

abstract class PageOpener {
  static void openUrl(String url) {
    window.open(url, '_blank');
  }
}
