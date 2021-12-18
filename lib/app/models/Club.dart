// To parse this JSON data, do
//
//     final club = clubFromJson(jsonString);

import 'dart:convert';

List<Club> clubFromJson(String str) => List<Club>.from(json.decode(str).map((x) => Club.fromJson(x)));

String clubToJson(List<Club> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Club {
  Club({
    this.id,
    this.name,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? userId;
  dynamic createdAt;
  dynamic updatedAt;

  factory Club.fromJson(Map<String, dynamic> json) => Club(
    id: json["id"],
    name: json["name"],
    userId: json["user_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "user_id": userId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
