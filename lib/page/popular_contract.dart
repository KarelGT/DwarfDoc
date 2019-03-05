import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:flutter/widgets.dart';

class View {
  void displayPopular(List<TopicWrap> topicWraps) {}
}

class Presenter {
  void start() {}

  Future fetchTopics() async {}

  void openTopic(BuildContext context, TopicWrap topicWrap) {}

  void dispose() {}
}
