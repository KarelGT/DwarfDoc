import 'package:dio/dio.dart';
import 'package:dwarf_doc/database/db_helper.dart';
import 'package:dwarf_doc/http/http_module.dart';
import 'package:dwarf_doc/http/ip_config.dart';
import 'package:dwarf_doc/manager/route_manager.dart';
import 'package:fluro/fluro.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

class Application {
  static Application _instance;
  bool isDebug;
  HttpModule httpModule;
  Router router;
  DBHelper _dbHelper;

  static Application getInstance() {
    if (_instance == null) {
      _instance = Application();
    }
    return _instance;
  }

  @protected
  Application();

  Future init() async {
    _initHttpModule();
    _initRouter();
    _initDatabase();
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

  void _initDatabase() async {
    _dbHelper = DBHelper();
    await _dbHelper.init();
  }

  Future<Database> getDatabase() async {
    return _dbHelper.getDatabase();
  }
}
