import 'dart:convert';

import 'package:dwarf_doc/application.dart';
import 'package:dwarf_doc/bean/node_wrap.dart';
import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:dwarf_doc/http/topic_api.dart';
import 'package:dwarf_doc/http/topic_resp.dart';
import 'package:dwarf_doc/manager/route_manager.dart';
import 'package:dwarf_doc/page/topic_list_contract.dart' as TopListContract;
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

class TopicListPresenter implements TopListContract.Presenter {
  TopListContract.View _view;
  TopicApi _topicApi;
  NodeWrap _nodeWrap;

  TopicListPresenter(TopListContract.View view, NodeWrap nodeWrap) {
    _view = view;
    _nodeWrap = nodeWrap;
    _topicApi = new TopicApi(Application.getInstance().httpModule);
  }

  @override
  void start() {
    _fetchTopicList().then((topics) {
      _view.displayTopics(topics);
    });
  }

  Future<List<TopicWrap>> _fetchTopicList() async {
    List<TopicResp> topResps =
        await _topicApi.queryTopicsByNodeId(_nodeWrap.id);
    List<TopicWrap> topicWraps = List<TopicWrap>();
    topResps.forEach((item) {
      topicWraps.add(TopicWrap(item));
    });
    return topicWraps;
  }

  @override
  void openTopic(BuildContext context, TopicWrap topicWrap) {
    String topicParam = jsonEncode(topicWrap.resp);
    topicParam = Uri.encodeComponent(topicParam);
    Application.getInstance().router.navigateTo(
        context, '${RouteHub.topicPath}?${RouteHub.topicParam}=$topicParam',
        transition: TransitionType.inFromRight);
  }
}
