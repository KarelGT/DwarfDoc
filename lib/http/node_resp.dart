class NodeResp {
  int id;
  String name;
  String url;
  String title;
  String titleAlternative;
  int topics;
  String footer;
  String header;
  String avatarLarge;
  String avatarNormal;
  String avatarMini;
  int stars;
  bool root;
  String parentNodeName;

  NodeResp(
      {this.id,
      this.name,
      this.url,
      this.title,
      this.titleAlternative,
      this.topics,
      this.footer,
      this.header,
      this.avatarLarge,
      this.avatarNormal,
      this.avatarMini,
      this.stars,
      this.root,
      this.parentNodeName});

  factory NodeResp.fromJson(Map<String, dynamic> json) {
    return new NodeResp(
        id: json['id'],
        name: json['name'],
        url: json['url'],
        title: json['title'],
        titleAlternative: json['title_alternative'],
        avatarLarge: json['avatar_large'],
        avatarMini: json['avatar_mini'],
        avatarNormal: json['avatar_normal'],
        topics: json['topics'],
        footer: json['footer'],
        header: json['header'],
        stars: json['stars'],
        root: json['root'],
        parentNodeName: json['parent_node_name']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'url': url,
        'title': title,
        'title_alternative': titleAlternative,
        'avatar_large': avatarLarge,
        'avatar_normal': avatarNormal,
        'avatar_mini': avatarMini,
        'topics': topics,
        'footer': footer,
        'header': header,
        'stars': stars,
        'root': root,
        'parent_node_name': parentNodeName,
      };
}
