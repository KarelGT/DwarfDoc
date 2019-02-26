import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:dwarf_doc/page/favorite_contract.dart' as FavoriteContract;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FavoriteState();
  }
}

class FavoriteState extends State<FavoritePage>
    with AutomaticKeepAliveClientMixin
    implements FavoriteContract.View {
  List<TopicWrap> _topics;
  FavoriteContract.Presenter _presenter;

  FavoriteState() {
    _topics = List<TopicWrap>();
    _presenter = new FavoriteContract.Presenter();
  }

  @override
  void initState() {
    super.initState();
    _presenter.start();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) => _createTopicItemView(_topics[index]),
        itemCount: _topics.length,
      ),
    );
  }

  Widget _createTopicItemView(TopicWrap topicWrap) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Text(topicWrap.title),
    );
  }

  @override
  displayTopics(List<TopicWrap> topics) {
    setState(() {
      _topics.clear();
      if (topics != null) {
        _topics.addAll(topics);
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
