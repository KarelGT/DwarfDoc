import 'dart:async';

import 'package:dwarf_doc/application.dart';
import 'package:dwarf_doc/bean/reply_wrap.dart';
import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:dwarf_doc/database/favorite_dao.dart';
import 'package:dwarf_doc/http/reply_resp.dart';
import 'package:dwarf_doc/http/topic_api.dart';
import 'package:dwarf_doc/manager/route_manager.dart';
import 'package:dwarf_doc/page/topic_contract.dart' as TopicContract;
import 'package:dwarf_doc/util/logger.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class TopicPresenter implements TopicContract.Presenter {
  static const _TAG = 'TopicPresenter';
  TopicApi _topicApi;
  TopicContract.View _view;
  TopicWrap _topicWrap;
  int _topicId;
  StreamSubscription _replySubscription;
  FavoriteDao _favoriteDao;

  TopicPresenter(this._view, this._topicId, _topicWrap) {
    _topicApi = TopicApi(Application.getInstance().httpModule);
    _favoriteDao = FavoriteDao();
  }

  @override
  void start() {
    if (_topicWrap != null) {
      notifyDisplayTopic(_topicWrap);
      _replySubscription = _fetchReplies(_topicId)
          .asStream()
          .listen((replyWraps) => notifyDisplayReplies(replyWraps));
    } else {
      _replySubscription = Observable.zip2(
              _fetchTopic(_topicId).asStream(),
              _fetchReplies(_topicId).asStream(),
              (topicWrap, replyWraps) => TopicContent(topicWrap, replyWraps))
          .listen((topicContent) {
        _topicWrap = topicContent.topicWrap;
        notifyDisplayTopic(_topicWrap);
        notifyDisplayReplies(topicContent.replayWraps);
      });
    }
    _favoriteDao.queryTopicRespsByTopicId(_topicId).then((topics) {
      _view.displayFavorite(topics != null && topics.isNotEmpty);
    });
  }

  Future<TopicWrap> _fetchTopic(int topicId) async {
    TopicWrap topicWrap;
    var resp = await _topicApi.queryTopicById(topicId);
    if (resp != null) {
      topicWrap = TopicWrap(resp);
    }
    return topicWrap;
  }

  Future<List<ReplyWrap>> _fetchReplies(int topicId) async {
    List<ReplyResp> replyResps = await _topicApi.queryRepliesByTopicId(topicId);
    List<ReplyWrap> replyWraps = List<ReplyWrap>();
    replyResps.forEach((value) {
      replyWraps.add(ReplyWrap(value));
    });
    return replyWraps;
  }

  void notifyDisplayTopic(TopicWrap topicWrap) {
    _view.displayTopic(topicWrap);
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

  @override
  void doFavorite(bool isFavorite, TopicWrap topic) {
    Observable.just(isFavorite).flatMap((it) {
      if (it) {
        return _favoriteDao.saveOrUpdateTopicResp(topic.resp).asStream();
      } else {
        return _favoriteDao.deleteTopicResp(topic.id).asStream();
      }
    }).listen((value) => _view.displayFavorite(isFavorite));
  }
}

class TopicContent {
  TopicWrap topicWrap;
  List<ReplyWrap> replayWraps;

  TopicContent(this.topicWrap, this.replayWraps);
}
