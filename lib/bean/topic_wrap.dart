import 'package:dwarf_doc/bean/member_wrap.dart';
import 'package:dwarf_doc/http/topic_resp.dart';
import 'package:dwarf_doc/util/string_utils.dart';
import 'package:intl/intl.dart';

class TopicWrap {
  int id;
  String title;
  MemberWrap member;
  String content;
  String contentHtml;
  String createdTime;
  int replies;
  TopicResp resp;

  TopicWrap(this.resp) {
    id = resp.id;
    title = StringUtils.safeString(resp.title);
    content = StringUtils.safeString(resp.content);
    contentHtml = '<body>${StringUtils.safeString(resp.contentRendered)}</body>';
    createdTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(resp.created * 1000));
    replies = resp.replies;
    if (resp.member != null) {
      member = MemberWrap(resp.member);
    }
  }
}
