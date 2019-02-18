import 'package:dwarf_doc/http/member_resp.dart';

class ReplyResp {
  int id;
  int thanks;
  String content;
  String contentRendered;
  int created;
  int lastModified;
  MemberResp member;

  ReplyResp(
      {this.id,
      this.thanks,
      this.content,
      this.contentRendered,
      this.created,
      this.lastModified,
      this.member});

  factory ReplyResp.fromJson(Map<String, dynamic> json) {
    return ReplyResp(
      id: json['id'],
      thanks: json['thanks'],
      content: json['content'],
      contentRendered: json['content_rendered'],
      created: json['created'],
      lastModified: json['last_modified'],
      member: MemberResp.fromJson(json['member']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'thanks': thanks,
        'content': content,
        'content_rendered': contentRendered,
        'created': created,
        'last_modified': lastModified,
        'member': member.toJson()
      };
}
