import 'package:dwarf_doc/bean/node_wrap.dart';
import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:dwarf_doc/page/topic_list_contract.dart' as TopicListContract;
import 'package:dwarf_doc/page/topic_list_presenter.dart';
import 'package:flutter/material.dart';

class TopicListPage extends StatefulWidget {
  final NodeWrap _nodeWrap;

  TopicListPage(this._nodeWrap);

  @override
  State<StatefulWidget> createState() {
    return _TopicState(_nodeWrap);
  }
}

class _TopicState extends State<TopicListPage>
    implements TopicListContract.View {
  TopicListContract.Presenter _presenter;
  List<TopicWrap> _topics;
  NodeWrap _nodeWrap;

  _TopicState(this._nodeWrap) {
    _presenter = TopicListPresenter(this, _nodeWrap);
    _topics = List<TopicWrap>();
  }

  @override
  void initState() {
    super.initState();
    _presenter.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(_nodeWrap.title),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return _createTopicItem(_topics[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(color: Theme.of(context).primaryColor);
            },
            itemCount: _topics.length),
      ),
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
  void displayTopics(List<TopicWrap> topics) {
    setState(() {
      _topics.clear();
      if (topics != null) {
        _topics.addAll(topics);
      }
    });
  }
}
