import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:flutter/src/widgets/framework.dart';

class View {
  displayTopics(List<TopicWrap> topics){}
}

class Presenter {
  void start() {}

  void openMember(BuildContext context, String username) {}

  void openTopic(BuildContext context, int topicId){}

  void detach() {}
}
