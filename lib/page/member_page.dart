import 'package:dwarf_doc/bean/member_wrap.dart';
import 'package:dwarf_doc/page/member_contract.dart' as MemberContract;
import 'package:dwarf_doc/page/member_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MemberPage extends StatefulWidget {
  final String _username;

  MemberPage(this._username);

  @override
  State<StatefulWidget> createState() {
    return MemberState(_username);
  }
}

class MemberState extends State<MemberPage> implements MemberContract.View {
  String _username;
  MemberWrap _member;
  MemberContract.Presenter _presenter;

  MemberState(this._username) {
    _presenter = MemberPresenter(this, _username);
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
        title: Text(_username),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: _createUserContent(_member),
      ),
    );
  }

  Widget _createUserContent(MemberWrap memberWrap) {
    if (memberWrap == null) {
      return Container();
    } else {
      return Column(
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                        memberWrap.avatar,
                        width: 64,
                        height: 64,
                        fit: BoxFit.contain,
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                memberWrap.name,
                                style: TextStyle(
                                    color: Theme.of(context).highlightColor,
                                    fontSize: 22),
                              ),
                              Padding(padding: EdgeInsets.only(top: 5)),
                              Text(
                                'V2EX第${memberWrap.id}号会员\n加入于${memberWrap.createTime}',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Offstage(
                    offstage: memberWrap.bio == null || memberWrap.bio.isEmpty,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Text(
                          memberWrap.bio,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          _createUserItem('Website', memberWrap.website),
          _createUserItem('Github', memberWrap.github),
          _createUserItem('Twitter', memberWrap.twitter),
          _createUserItem('PSN', memberWrap.psn),
        ],
      );
    }
  }

  Widget _createUserItem(String title, String content) {
    return Offstage(
      offstage: content == null || content.isEmpty,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).highlightColor, fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(content,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 18)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void displayUser(MemberWrap memberWrap) {
    setState(() {
      _member = memberWrap;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.detach();
  }
}
