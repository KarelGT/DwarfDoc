import 'package:dwarf_doc/application.dart';
import 'package:dwarf_doc/http/topic_resp.dart';

class FavoriteDao {
  static const String _TABLE_NAME = "Favorite";
  static const String _ID = 'id';
  static const String _TOPIC_ID = 'topicId';
  static const String _TOPIC_RESP = 'topicResp';

  static const String CREATE_SQL =
      'CREATE TABLE IF NOT EXISTS $_TABLE_NAME ($_ID INTEGER PRIMARY KEY, $_TOPIC_ID INTEGER, $_TOPIC_RESP TEXT)';

  Future<int> saveOrUpdateTopicResp(TopicResp) async {
    var database = await Application.getInstance().getDatabase();
    //Todo Karel save or update
  }

  Future<List<TopicResp>> queryTopicResps({int id, int topicId}) async {
    List<TopicResp> ret = List<TopicResp>();
    var database = await Application.getInstance().getDatabase();
    String where;
    List<dynamic> whereArgs;
    database.query(_TABLE_NAME, columns: [_ID, _TOPIC_ID, _TOPIC_ID], where: where, whereArgs: whereArgs);
    //Todo Karel query
    return ret;
  }
}
