import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:dwarf_doc/page/favorite_contract.dart' as FavoriteContract;
import 'package:dwarf_doc/page/favorite_presenter.dart';
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
    _presenter = FavoritePresenter(this);
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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => _createTopicItemView(_topics[index]),
        itemCount: _topics.length,
      ),
    );
  }

  Widget _createTopicItemView(TopicWrap topicWrap) {
    return GestureDetector(
      onTap: () => _presenter.openTopic(context, topicWrap.id),
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  topicWrap.title,
                  style: TextStyle(
                      fontSize: 18, color: Theme.of(context).highlightColor),
                ),
              ),
              Row(
                children: <Widget>[
                  Image.network(
                    topicWrap.member.avatar,
                    fit: BoxFit.contain,
                    width: 32,
                    height: 32,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => _presenter.openMember(
                              context, topicWrap.member.name),
                          child: Text(
                            topicWrap.member.name,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          topicWrap.createdTime,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
  void dispose() {
    _presenter.detach();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
