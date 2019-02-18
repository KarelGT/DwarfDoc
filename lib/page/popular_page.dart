import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:dwarf_doc/page/popular_contract.dart' as PopularContract;
import 'package:dwarf_doc/page/popular_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PopularPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PopularState();
  }
}

class _PopularState extends State<PopularPage>
    with AutomaticKeepAliveClientMixin
    implements PopularContract.View {
  List<TopicWrap> _topics;
  PopularContract.Presenter _presenter;

  _PopularState() {
    _topics = List<TopicWrap>();
    _presenter = PopularPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.start();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _createTopicItem(_topics[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Theme.of(context).primaryColor);
          },
          itemCount: _topics.length),
    );
  }

  Widget _createTopicItem(TopicWrap topicWrap) {
    return ListTile(
      leading: Image.network(
        topicWrap.member.avatar,
        height: 48,
        width: 48,
        fit: BoxFit.contain,
      ),
      title: Text(
        topicWrap.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 18, color: Theme.of(context).highlightColor),
      ),
      subtitle: Row(
        children: <Widget>[
          Text(
            topicWrap.member.name,
            style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          Text(
            ' ${topicWrap.createdTime}',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      trailing: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Text(
          topicWrap.replies.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () => _presenter.openTopic(context, topicWrap),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void displayPopular(List<TopicWrap> topicWraps) {
    setState(() {
      _topics.clear();
      if (topicWraps != null) {
        _topics.addAll(topicWraps);
      }
    });
  }
}
