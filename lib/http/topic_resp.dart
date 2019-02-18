import 'package:dwarf_doc/http/member_resp.dart';
import 'package:dwarf_doc/http/node_resp.dart';

class TopicResp {
  NodeResp node;
  MemberResp member;
  String lastReplyBy;
  int lastTouched;
  String title;
  String url;
  String content;
  String contentRendered;
  int created;
  int lastModified;
  int replies;
  int id;

  TopicResp(
      {this.node,
      this.member,
      this.lastReplyBy,
      this.lastTouched,
      this.title,
      this.url,
      this.content,
      this.contentRendered,
      this.created,
      this.lastModified,
      this.replies,
      this.id});

  factory TopicResp.fromJson(Map<String, dynamic> json) {
    return TopicResp(
      node: NodeResp.fromJson(json['node']),
      member: MemberResp.fromJson(json['member']),
      lastModified: json['last_modified'],
      lastReplyBy: json['last_reply_by'],
      lastTouched: json['last_touched'],
      title: json['title'],
      url: json['url'],
      content: json['content'],
      contentRendered: json['content_rendered'],
      created: json['created'],
      replies: json['replies'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'node': node.toJson(),
        'member': member.toJson(),
        'last_modified': lastModified,
        'last_reply_by': lastReplyBy,
        'last_touched': lastTouched,
        'title': title,
        'url': url,
        'content': content,
        'content_rendered': contentRendered,
        'created': created,
        'replies': replies,
        'id': id,
      };
}
