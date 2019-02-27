import 'dart:convert';

import 'package:dwarf_doc/application.dart';
import 'package:dwarf_doc/http/topic_resp.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDao {
  static const String _TABLE_NAME = "Favorite";
  static const String _ID = 'id';
  static const String _TOPIC_ID = 'topicId';
  static const String _TOPIC_RESP = 'topicResp';

  static const String CREATE_SQL =
      'CREATE TABLE IF NOT EXISTS $_TABLE_NAME ($_ID INTEGER PRIMARY KEY, $_TOPIC_ID INTEGER, $_TOPIC_RESP TEXT)';

  //添加或者更新Topic
  Future<int> saveOrUpdateTopicResp(TopicResp topicResp) async {
    int id = 0;
    var database = await Application.getInstance().getDatabase();
    var ret = await _queryTopicResps(database, topicId: topicResp.id);
    if (ret == null || ret.isEmpty) {
      id = await database.rawInsert(
          'INSERT INTO $_TABLE_NAME($_TOPIC_ID, $_TOPIC_RESP) VALUES (?, ?)',
          [topicResp.id, jsonEncode(topicResp)]);
    } else {
      id = ret.first.id;
      await database.rawUpdate(
          'UPDATE $_TABLE_NAME SET $_TOPIC_RESP = ? WHERE $_TOPIC_ID = ?',
          [jsonEncode(topicResp), topicResp.id]);
    }
    await database.close();
    return id;
  }

  Future<int> deleteTopicResp(int topicId) async {
    int id = 0;
    var database = await Application.getInstance().getDatabase();
    id = await database
        .delete(_TABLE_NAME, where: '$_TOPIC_ID = ?', whereArgs: [topicId]);
    await database.close();
    return id;
  }

  //通过数据库id查询Topic
  Future<List<TopicResp>> queryTopicRespsById(int id) async {
    var database = await Application.getInstance().getDatabase();
    var ret = await _queryTopicResps(database, id: id);
    await database.close();
    return ret;
  }

  //通过topicId查询Topic
  Future<List<TopicResp>> queryTopicRespsByTopicId(int topicId) async {
    var database = await Application.getInstance().getDatabase();
    var ret = await _queryTopicResps(database, topicId: topicId);
    await database.close();
    return ret;
  }

  //查询所有Topic
  Future<List<TopicResp>> queryTopicResps() async {
    var database = await Application.getInstance().getDatabase();
    var ret = await _queryTopicResps(database);
    await database.close();
    return ret;
  }

  Future<List<TopicResp>> _queryTopicResps(Database database,
      {int id, int topicId}) async {
    List<TopicResp> ret = List<TopicResp>();
    String where;
    List<dynamic> whereArgs;
    if (id != null) {
      where = '$_ID = ?';
      whereArgs = [id];
    } else if (topicId != null) {
      where = '$_TOPIC_ID = ?';
      whereArgs = [topicId];
    }
    var list = await database.query(_TABLE_NAME,
        columns: [_ID, _TOPIC_ID, _TOPIC_RESP],
        where: where,
        whereArgs: whereArgs);
    ret = list
        .map((value) => TopicResp.fromJson(jsonDecode(value[_TOPIC_RESP])))
        .toList();
    return ret;
  }
}
