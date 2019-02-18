import 'package:dwarf_doc/http/member_resp.dart';
import 'package:dwarf_doc/util/string_utils.dart';
import 'package:intl/intl.dart';

class MemberWrap {
  int id;
  String avatar;
  String name;
  String createTime;
  String website;
  String twitter;
  String psn;
  String github;
  String bio;

  MemberResp resp;

  MemberWrap(this.resp) {
    if (resp.avatarNormal != null) {
      avatar = 'http:' + resp.avatarNormal;
    }
    name = StringUtils.safeString(resp.username);
    id = resp.id;
    createTime = DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(DateTime.fromMillisecondsSinceEpoch(resp.created * 1000));
    website = StringUtils.safeString(resp.website);
    psn = StringUtils.safeString(resp.psn);
    twitter = StringUtils.safeString(resp.twitter);
    github = StringUtils.safeString(resp.github);
    bio = StringUtils.safeString(resp.bio);
  }
}
