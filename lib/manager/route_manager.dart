import 'dart:convert';

import 'package:dwarf_doc/bean/node_wrap.dart';
import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:dwarf_doc/http/node_resp.dart';
import 'package:dwarf_doc/http/topic_resp.dart';
import 'package:dwarf_doc/page/member_page.dart';
import 'package:dwarf_doc/page/topic_list_page.dart';
import 'package:dwarf_doc/page/topic_page.dart';
import 'package:dwarf_doc/util/logger.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class RouteManager {
  static const String _TAG = "RouteManager";
  static RouteManager _instance;
  Router router;

  static RouteManager getInstance() {
    if (_instance == null) {
      _instance = RouteManager();
    }
    return _instance;
  }

  @protected
  RouteManager() {
    router = Router();
    configureRoutes(router);
  }

  void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      Logger.d(_TAG, params.toString());
    });
    router.define(RouteHub.topicListPath,
        handler: RouteHandler.topicListHandler);
    router.define(RouteHub.topicPath, handler: RouteHandler.topicHandler);
    router.define(RouteHub.memberPath, handler: RouteHandler.memberHandler);
  }
}

class RouteHandler {
  static Handler topicListHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var nodeWrap;
    var nodeJson = params[RouteHub.nodeParam]?.first;
    if (nodeJson != null && nodeJson.isNotEmpty) {
      nodeWrap = NodeWrap(NodeResp.fromJson(json.decode(nodeJson)));
    }
    return TopicListPage(nodeWrap);
  });

  static Handler topicHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var topicJson = params[RouteHub.topicParam]?.first;
    var topicId = params[RouteHub.topicIdParam]?.first;
    if (topicJson != null && topicJson.isNotEmpty) {
      var topicWrap = TopicWrap(TopicResp.fromJson(json.decode(topicJson)));
      return TopicPage(topicWrap.id, topicWrap);
    } else if(topicId != null && topicId.isNotEmpty){
      return TopicPage(int.parse(topicId), null);
    } else {
      return TopicPage(-1, null);
    }
  });

  static Handler memberHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var username = params[RouteHub.usernameParam]?.first;
    return MemberPage(username);
  });
}

class RouteHub {
  static String topicListPath = '/topicList';
  static String nodeParam = 'node';

  static String topicPath = '/topic';
  static String topicParam = 'topic';
  static String topicIdParam = 'id';

  static String memberPath = '/member';
  static String usernameParam = 'username';
}
