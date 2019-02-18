import 'package:dwarf_doc/bean/member_wrap.dart';
import 'package:dwarf_doc/http/reply_resp.dart';
import 'package:dwarf_doc/util/string_utils.dart';
import 'package:intl/intl.dart';

class ReplyWrap {
  String content;
  String contentHtml;
  String createdTime;
  MemberWrap member;
  ReplyResp resp;

  ReplyWrap(this.resp) {
    content = StringUtils.safeString(resp.content);
    contentHtml = StringUtils.safeString(resp.contentRendered);
    createdTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(resp.created * 1000));
    if (resp.member != null) {
      member = MemberWrap(resp.member);
    }
  }
}
