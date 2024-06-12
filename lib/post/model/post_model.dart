import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  PostModel({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
      };
}
