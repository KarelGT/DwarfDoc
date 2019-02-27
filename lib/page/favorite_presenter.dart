import 'package:dwarf_doc/application.dart';
import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:dwarf_doc/database/favorite_dao.dart';
import 'package:dwarf_doc/manager/route_manager.dart';
import 'package:dwarf_doc/page/favorite_contract.dart' as FavoriteContract;
import 'package:fluro/fluro.dart';
import 'package:flutter/src/widgets/framework.dart';

class FavoritePresenter implements FavoriteContract.Presenter {
  FavoriteContract.View _view;
  FavoriteDao _favoriteDao;

  FavoritePresenter(this._view) {
    _favoriteDao = FavoriteDao();
  }

  @override
  void start() {
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
}
