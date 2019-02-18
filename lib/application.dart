import 'package:dio/dio.dart';
import 'package:dwarf_doc/http/http_module.dart';
import 'package:dwarf_doc/http/ip_config.dart';
import 'package:dwarf_doc/manager/route_manager.dart';
import 'package:fluro/fluro.dart';
import 'package:meta/meta.dart';

class Application {
  static Application _instance;
  bool isDebug;
  HttpModule httpModule;
  Router router;

  static Application getInstance() {
    if (_instance == null) {
      _instance = Application();
    }
    return _instance;
  }

  @protected
  Application() {
    _initHttpModule();
    _initRouter();
  }

  void _initHttpModule() {
    var options = BaseOptions(
      baseUrl: IPConfig.getInstance().getApiIp(),
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    httpModule = HttpModule(Dio(options));
  }

  void _initRouter() {
    router = RouteManager.getInstance().router;
  }
}
