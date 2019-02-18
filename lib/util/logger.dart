import 'package:dwarf_doc/application.dart';

class Logger {
  static void d(String tag, String log) {
    if (Application.getInstance().isDebug) {
      print('$tag: $log');
    }
  }
}
