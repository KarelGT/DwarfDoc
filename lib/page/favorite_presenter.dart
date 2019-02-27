import 'dart:async';

import 'package:dwarf_doc/application.dart';
import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:dwarf_doc/database/db_event.dart';
import 'package:dwarf_doc/database/favorite_dao.dart';
import 'package:dwarf_doc/manager/route_manager.dart';
import 'package:dwarf_doc/page/favorite_contract.dart' as FavoriteContract;
import 'package:event_bus/event_bus.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

class FavoritePresenter implements FavoriteContract.Presenter {
  FavoriteContract.View _view;
  FavoriteDao _favoriteDao;
  EventBus _eventBus;
  StreamSubscription _subQuery;

  FavoritePresenter(this._view) {
    _favoriteDao = FavoriteDao();
  }

  @override
  void start() {
    _updateFavorite();
    _subQuery = Application.getInstance().eventBus.on<FavoriteEvent>().listen((event) {
      _updateFavorite();
    });
  }

  void _updateFavorite() {
    _favoriteDao.queryTopicResps().then((value) {
      var topics = value.map((resp) => TopicWrap(resp)).toList();
      _view.displayTopics(topics);
    });
  }

  @override
  void openMember(BuildContext context, String username) {
    Application.getInstance().router.navigateTo(
        context, '${RouteHub.memberPath}?${RouteHub.usernameParam}=$username',
        transition: TransitionType.inFromRight);
  }

  @override
  void openTopic(BuildContext context, int topicId) {
    Application.getInstance().router.navigateTo(
        context, '${RouteHub.topicPath}?${RouteHub.topicIdParam}=$topicId',
        transition: TransitionType.inFromRight);
  }

  @override
  void detach() {
    if (_subQuery != null) {
      _subQuery.cancel();
    }
  }
}
