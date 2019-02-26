import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:dwarf_doc/database/favorite_dao.dart';
import 'package:dwarf_doc/page/favorite_contract.dart' as FavoriteContract;

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
}
