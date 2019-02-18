import 'dart:async';
import 'dart:convert';

import 'package:dwarf_doc/application.dart';
import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:dwarf_doc/http/topic_api.dart';
import 'package:dwarf_doc/manager/route_manager.dart';
import 'package:dwarf_doc/page/popular_contract.dart' as PopularContract;
import 'package:fluro/fluro.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rxdart/rxdart.dart';

class PopularPresenter implements PopularContract.Presenter {
  PopularContract.View _view;
  TopicApi _topicApi;
  StreamSubscription _topicSubscription;

  PopularPresenter(this._view) {
    _topicApi = TopicApi(Application.getInstance().httpModule);
  }

  @override
  void start() {
    _topicSubscription = Observable.merge([
      _topicApi.queryHotTopics().asStream(),
      _topicApi.queryLatestTopics().asStream()
    ])
        .flatMap((value) => Observable.fromIterable(value))
        .map((topicResp) => TopicWrap(topicResp))
        .toList()
        .asStream()
        .listen((topicWraps) {
      _view.displayPopular(topicWraps);
    });
  }

  @override
  void dispose() {
    if (_topicSubscription != null) {
      _topicSubscription.cancel();
    }
  }

  @override
  void openTopic(BuildContext context, TopicWrap topicWrap) {
    String topicParam = jsonEncode(topicWrap.resp);
    topicParam = Uri.encodeComponent(topicParam);
    Application.getInstance().router.navigateTo(context,
        '${RouteHub.topicPath}?${RouteHub.topicParam}=$topicParam',
        transition: TransitionType.inFromRight);
  }
}
