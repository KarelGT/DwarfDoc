import 'package:meta/meta.dart';

class IPConfig {
  static IPConfig _instance;
  String _api;

  static IPConfig getInstance() {
    if(_instance == null) {
      _instance = IPConfig();
    }
    return _instance;
  }

  @protected
  IPConfig() {
    _api = 'https://www.v2ex.com';
  }

  String getApiIp() {
    return _api;
  }
}
