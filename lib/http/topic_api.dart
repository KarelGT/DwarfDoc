import 'package:dwarf_doc/http/http_module.dart';
import 'package:dwarf_doc/http/reply_resp.dart';
import 'package:dwarf_doc/http/topic_resp.dart';

class TopicApi {
  static final String TAG = 'TopicApi';
  HttpModule _httpModule;

  TopicApi(this._httpModule);

  Future<List<TopicResp>> queryHotTopics() async {
    List response = await _httpModule.get('/api/topics/hot.json');
    List<TopicResp> resps =
        response.map((value) => TopicResp.fromJson(value)).toList();
    return resps;
  }

  Future<List<TopicResp>> queryLatestTopics() async {
    List response = await _httpModule.get('/api/topics/latest.json');
    List<TopicResp> resps =
        response.map((value) => TopicResp.fromJson(value)).toList();
    return resps;
  }

  Future<List<TopicResp>> queryTopicsByNodeId(int nodeId) async {
    List response = await _httpModule.get('/api/topics/show.json',
        params: <String, String>{'node_id': '$nodeId'});
    List<TopicResp> resps =
        response.map((value) => TopicResp.fromJson(value)).toList();
    return resps;
  }

  Future<TopicResp> queryTopicById(int topicId) async {
    List response = await _httpModule.get('/api/topics/show.json',
        params: <String, String>{'id': '$topicId'});
    List<TopicResp> resps =
        response.map((value) => TopicResp.fromJson(value)).toList();
    return resps.isEmpty ? null : resps.first;
  }

  Future<List<ReplyResp>> queryRepliesByTopicId(int topicId) async {
    List response = await _httpModule.get('/api/replies/show.json',
        params: <String, String>{'topic_id': '$topicId'});
    List<ReplyResp> resps =
        response.map((value) => ReplyResp.fromJson(value)).toList();
    return resps;
  }
}
