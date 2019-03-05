import 'package:dwarf_doc/bean/node_wrap.dart';
import 'package:dwarf_doc/page/node_contract.dart' as NodeContract;
import 'package:dwarf_doc/page/node_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NodeState();
  }
}

class _NodeState extends State<NodePage>
    with AutomaticKeepAliveClientMixin
    implements NodeContract.View {
  NodeContract.Presenter _presenter;
  List<NodeWrap> _nodeWraps;

  _NodeState() {
    _presenter = new NodePresenter(this);
    _nodeWraps = new List<NodeWrap>();
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
      child: RefreshIndicator(
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) {
              return _createNodeItemView(_nodeWraps[index]);
            },
            itemCount: _nodeWraps.length,
          ),
          onRefresh: ()=>_presenter.fetchNodes()),
    );
  }

  Widget _createNodeItemView(NodeWrap nodeWrap) {
    return GestureDetector(
      onTap: () => _presenter.openTopicList(context, nodeWrap),
      child: Container(
        decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 0.5)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                nodeWrap.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: 18,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  nodeWrap.topics.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void displayNodes(List<NodeWrap> nodeWraps) {
    setState(() {
      _nodeWraps.clear();
      if (nodeWraps != null) {
        _nodeWraps.addAll(nodeWraps);
      }
    });
  }
}
