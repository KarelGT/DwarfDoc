import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:dwarf_doc/application.dart';
import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:dwarf_doc/http/topic_api.dart';
import 'package:dwarf_doc/http/topic_resp.dart';
import 'package:dwarf_doc/manager/route_manager.dart';
import 'package:dwarf_doc/page/popular_contract.dart' as PopularContract;
import 'package:fluro/fluro.dart';
import 'package:flutter/src/widgets/framework.dart';

class PopularPresenter implements PopularContract.Presenter {
  PopularContract.View _view;
  TopicApi _topicApi;
  CancelableOperation<List<TopicWrap>> _cancelableOperation;

  PopularPresenter(this._view) {
    _topicApi = TopicApi(Application.getInstance().httpModule);
  }

  @override
  void start() {
    _fetchTopics().then((value) => _view.displayPopular(value));
  }

  @override
  void dispose() {
    if (_cancelableOperation != null) {
      _cancelableOperation.cancel();
      _cancelableOperation = null;
    }
  }

  @override
  void openTopic(BuildContext context, TopicWrap topicWrap) {
    String topicParam = jsonEncode(topicWrap.resp);
    topicParam = Uri.encodeComponent(topicParam);
    Application.getInstance().router.navigateTo(
        context, '${RouteHub.topicPath}?${RouteHub.topicParam}=$topicParam',
        transition: TransitionType.inFromRight);
  }

  @override
  Future fetchTopics() async {
    await _fetchTopics().then((value) => _view.displayPopular(value));
  }

  Future<List<TopicWrap>> _fetchTopics() async {
    if (_cancelableOperation != null) {
      _cancelableOperation.cancel();
      _cancelableOperation = null;
    }
    var future =
        Future.wait([_topicApi.queryHotTopics(), _topicApi.queryLatestTopics()])
            .then((value) {
      var list = List<TopicResp>();
      for (int i = 0; i < value.length; i++) {
        list.addAll(value[i]);
      }
      return list;
    }).then((value) {
      return value.map((resp) => TopicWrap(resp)).toList();
    });
    _cancelableOperation = CancelableOperation.fromFuture(future);
    return _cancelableOperation.value;
  }
}
