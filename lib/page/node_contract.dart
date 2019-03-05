import 'package:dwarf_doc/bean/node_wrap.dart';
import 'package:flutter/widgets.dart';

class View {
  void displayNodes(List<NodeWrap> nodeWraps) {}
}

class Presenter {
  void start() {}

  Future fetchNodes() async {}

  void openTopicList(BuildContext context, NodeWrap nodeWrap) {}
}
