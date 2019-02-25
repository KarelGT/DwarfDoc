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

  Future<int> saveOrUpdateTopicResp(TopicResp topicResp) async {
    var database = await Application.getInstance().getDatabase();
    var ret = await _queryTopicResps(database, topicId: topicResp.id);
    if(ret == null || ret.isEmpty) {
      //todo Karel save
    } else {
      //todo Karel update
    }
  }

  Future<List<TopicResp>> queryTopicRespsById(int id) async {
    var database = await Application.getInstance().getDatabase();
    var ret = await _queryTopicResps(database, id: id);
    await database.close();
    return ret;
  }

  Future<List<TopicResp>> queryTopicRespsByTopicId(int topicId) async {
    var database = await Application.getInstance().getDatabase();
    var ret = await _queryTopicResps(database, topicId: topicId);
    await database.close();
    return ret;
  }

  Future<List<TopicResp>> _queryTopicResps(Database database, {int id, int topicId}) async {
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
        columns: [_ID, _TOPIC_ID, _TOPIC_ID],
        where: where,
        whereArgs: whereArgs);
    ret = list.map((value) => TopicResp.fromJson(value)).toList();
    return ret;
  }
}
