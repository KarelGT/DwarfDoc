class MemberResp {
  int id;
  String username;
  String website;
  String github;
  String psn;
  String avatarNormal;
  String avatarLarge;
  String avatarMini;
  String bio;
  String url;
  String tagline;
  String twitter;
  int created;
  String location;
  String btc;

  MemberResp(
      {this.id,
      this.username,
      this.website,
      this.github,
      this.psn,
      this.avatarNormal,
      this.avatarLarge,
      this.avatarMini,
      this.bio,
      this.url,
      this.tagline,
      this.twitter,
      this.created,
      this.location,
      this.btc});

  factory MemberResp.fromJson(Map<String, dynamic> json) {
    return MemberResp(
        id: json['id'],
        username: json['username'],
        website: json['website'],
        github: json['github'],
        psn: json['psn'],
        bio: json['bio'],
        url: json['url'],
        tagline: json['tagline'],
        twitter: json['twitter'],
        created: json['created'],
        avatarMini: json['avatar_mini'],
        avatarNormal: json['avatar_normal'],
        avatarLarge: json['avatar_large'],
        location: json['location'],
        btc: json['btc']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'username': username,
        'website': website,
        'github': github,
        'psn': psn,
        'bio': bio,
        'url': url,
        'tagline': tagline,
        'twitter': twitter,
        'created': created,
        'avatar_mini': avatarMini,
        'avatar_normal': avatarNormal,
        'avatar_large': avatarLarge,
        'location': location,
        'btc': btc,
      };
}
