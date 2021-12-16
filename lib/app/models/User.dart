import 'package:OnPlay365/app/models/Credit.dart';

class User {
  User(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.country,
      this.mobile,
      this.sponserEmail,
      this.clubId,
      this.credit,
      this.token});

  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final dynamic? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;
  final String? country;
  final String? mobile;
  final String? sponserEmail;
  final int? clubId;
  final Credit? credit;
  final String? token;

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        country: json["country"] == null ? null : json["country"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        sponserEmail:
            json["sponser_email"] == null ? null : json["sponser_email"],
        clubId: json["club_id"] == null ? null : json["club_id"],
        credit: json["credit"] == null ? null : Credit.fromMap(json["credit"]),
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt == null ? null : createdAt.toString(),
        "updated_at": updatedAt == null ? null : updatedAt.toString(),
        "country": country == null ? null : country,
        "mobile": mobile == null ? null : mobile,
        "sponser_email": sponserEmail == null ? null : sponserEmail,
        "club_id": clubId == null ? null : clubId,
        "credit": credit == null ? null : credit!.toMap(),
        "token": token == null ? null : token,
      };
}
