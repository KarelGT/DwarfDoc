import 'dart:convert';

import 'package:dwarf_doc/application.dart';
import 'package:dwarf_doc/bean/node_wrap.dart';
import 'package:dwarf_doc/http/node_api.dart';
import 'package:dwarf_doc/http/node_resp.dart';
import 'package:dwarf_doc/manager/route_manager.dart';
import 'package:dwarf_doc/page/node_contract.dart' as NodeContract;
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

class NodePresenter implements NodeContract.Presenter {
  static const String _TAG = "NodePresenter";
  NodeApi _nodeApi;
  NodeContract.View _view;

  NodePresenter(NodeContract.View view) {
    _view = view;
    _nodeApi = NodeApi(Application.getInstance().httpModule);
  }

  @override
  void start() {
    _fetchNodes().then((List<NodeWrap> nodeWraps) {
      _view.displayNodes(nodeWraps);
    });
  }

  Future<List<NodeWrap>> _fetchNodes() async {
    List<NodeResp> nodeResps = await _nodeApi.queryAllNodes();
    List<NodeWrap> nodeWraps = List<NodeWrap>();
    nodeResps.forEach((item) {
      nodeWraps.add(NodeWrap(item));
    });
    nodeWraps.sort((a, b) => b.topics - a.topics);
    return nodeWraps;
  }

  @override
  void openTopicList(BuildContext context, NodeWrap nodeWrap) {
    String nodeParam = jsonEncode(nodeWrap.resp);
    nodeParam = Uri.encodeComponent(nodeParam);
    Application.getInstance().router.navigateTo(
        context, '${RouteHub.topicListPath}?${RouteHub.nodeParam}=$nodeParam',
        transition: TransitionType.inFromRight);
  }
}
