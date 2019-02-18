import 'dart:async';

import 'package:dwarf_doc/application.dart';
import 'package:dwarf_doc/bean/reply_wrap.dart';
import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:dwarf_doc/http/reply_resp.dart';
import 'package:dwarf_doc/http/topic_api.dart';
import 'package:dwarf_doc/manager/route_manager.dart';
import 'package:dwarf_doc/page/topic_contract.dart' as TopicContract;
import 'package:dwarf_doc/util/logger.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class TopicPresenter implements TopicContract.Presenter {
  static const _TAG = 'TopicPresenter';
  TopicApi _topicApi;
  TopicContract.View _view;
  TopicWrap _topicWrap;
  StreamSubscription _replySubscription;

  TopicPresenter(this._view, this._topicWrap) {
    _topicApi = TopicApi(Application.getInstance().httpModule);
  }

  @override
  void start() {
    _replySubscription = _fetchReplies(_topicWrap.id)
        .asStream()
        .listen((replyWraps) => notifyDisplayReplies(replyWraps));
  }

  Future<List<ReplyWrap>> _fetchReplies(int topicId) async {
    List<ReplyResp> replyResps = await _topicApi.queryRepliesByTopicId(topicId);
    List<ReplyWrap> replyWraps = List<ReplyWrap>();
    replyResps.forEach((value) {
      replyWraps.add(ReplyWrap(value));
    });
    return replyWraps;
  }

  void notifyDisplayReplies(List<ReplyWrap> replyWraps) {
    _view.displayReplies(replyWraps);
  }

  @override
  void openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Logger.d(_TAG, 'Could not launch $url');
    }
  }

  @override
  void openMember(BuildContext context, String username) {
    Application.getInstance().router.navigateTo(
        context, '${RouteHub.memberPath}?${RouteHub.usernameParam}=$username',
        transition: TransitionType.inFromRight);
  }

  @override
  void detach() {
    if (_replySubscription != null) {
      _replySubscription.cancel();
    }
  }
}
