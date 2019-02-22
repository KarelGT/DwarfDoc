import 'package:dio/dio.dart';
import 'package:dwarf_doc/http/http_module.dart';
import 'package:dwarf_doc/http/ip_config.dart';
import 'package:dwarf_doc/manager/route_manager.dart';
import 'package:fluro/fluro.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class Application {
  static const String _dbFileName = 'v2ex.db';
  static const int _dbVersion = 1;
  static Application _instance;
  bool isDebug;
  HttpModule httpModule;
  Router router;
  Database database;

  static Application getInstance() {
    if (_instance == null) {
      _instance = Application();
    }
    return _instance;
  }

  @protected
  Application();

  void init() async {
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

  Future _initDatabase() async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbFileName);
    database = await openDatabase(path, version: _dbVersion);
  }
}
