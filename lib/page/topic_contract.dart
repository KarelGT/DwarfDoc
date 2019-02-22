import 'package:dwarf_doc/bean/reply_wrap.dart';
import 'package:dwarf_doc/bean/topic_wrap.dart';
import 'package:flutter/widgets.dart';

class View {
  void displayTopic(TopicWrap topic) {}

  void displayReplies(List<ReplyWrap> replies) {}
}

class Presenter {
  void start() {}

  void openUrl(String url) {}

  void openMember(BuildContext context, String username) {}

  void detach() {}
}
