import 'dart:async';
import 'package:dwarf_doc/database/favorite_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const String _dbFileName = 'v2ex.db';
  static const int _dbVersion = 1;
  String _databasesPath;
  Database database;

  Future init() async => _initDatabase();

  Future _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    _databasesPath = join(databasesPath, _dbFileName);
  }

  Future<Database> getDatabase() async {
    if (database == null || !database.isOpen) {
      database = await openDatabase(_databasesPath, version: _dbVersion,
          onCreate: (database, version) async {
        await database.execute(FavoriteDao.CREATE_SQL);
      });
    }
    return database;
  }

  Future closeDatabase() async {
    if (database != null && database.isOpen) {
      database.close();
    }
  }
}
