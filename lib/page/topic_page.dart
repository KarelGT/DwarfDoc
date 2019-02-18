import 'package:dwarf_doc/bean/reply_wrap.dart';
import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:dwarf_doc/page/topic_contract.dart' as TopicContract;
import 'package:dwarf_doc/page/topic_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';

class TopicPage extends StatefulWidget {
  final TopicWrap _topic;

  TopicPage(this._topic);

  @override
  State<StatefulWidget> createState() {
    return TopicState(_topic);
  }
}

class TopicState extends State<TopicPage> implements TopicContract.View {
  TopicWrap _topic;
  List<ReplyWrap> _replies;
  TopicContract.Presenter _presenter;

  TopicState(this._topic) {
    _replies = new List<ReplyWrap>();
    _presenter = new TopicPresenter(this, _topic);
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
        title: Text(_topic.title),
      ),
      body: Container(
        child: _createBody(_topic, _replies),
      ),
    );
  }

  Widget _createBody(TopicWrap _topicWrap, List<ReplyWrap> _replyWraps) {
    return ListView.builder(
      itemBuilder: (BuildContext context, index) {
        if (index == 0 && _topicWrap != null) {
          return _createContent(_topicWrap);
        } else {
          return _createReplyItem(
              _replyWraps[index - (_topicWrap != null ? 1 : 0)]);
        }
      },
      itemCount: _replyWraps.length + (_topicWrap != null ? 1 : 0),
    );
  }

  Widget _createContent(TopicWrap topicWrap) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () =>
                      _presenter.openMember(context, _topic.member.name),
                  child: Image.network(
                    topicWrap.member.avatar,
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(topicWrap.title,
                            softWrap: true,
                            style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 18)),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => _presenter.openMember(
                                  context, _topic.member.name),
                              child: Text(
                                topicWrap.member.name,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              ' ${topicWrap.createdTime}',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: 1,
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Html(
              defaultTextStyle: TextStyle(
                  color: Theme.of(context).highlightColor, fontSize: 16),
              data: _topic.contentHtml,
              onLinkTap: (url) {
                _presenter.openUrl(url);
              },
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: 1,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('${_topic.replies} 回复',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 12)),
              ],
            ),
            margin: EdgeInsets.only(top: 10),
          )
        ],
      ),
    );
  }

  Widget _createReplyItem(ReplyWrap replyWrap) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () => _presenter.openMember(context, replyWrap.member.name),
                child: Image.network(
                  replyWrap.member.avatar,
                  width: 24,
                  height: 24,
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => _presenter.openMember(
                                context, replyWrap.member.name),
                            child: Text(
                              replyWrap.member.name,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(' ${replyWrap.createdTime}',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12)),
                        ],
                      ),
                      Html(
                        defaultTextStyle: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontSize: 16),
                        data: replyWrap.contentHtml,
                        onLinkTap: (url) {
                          _presenter.openUrl(url);
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            height: 1,
          ),
        ],
      ),
    );
  }

  @override
  void displayReplies(List<ReplyWrap> replies) {
    setState(() {
      _replies.clear();
      if (replies != null) {
        _replies.addAll(replies);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.detach();
  }
}
