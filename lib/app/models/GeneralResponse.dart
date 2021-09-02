// To parse this JSON data, do
//
//     final generalResponse = generalResponseFromMap(jsonString);

import 'dart:convert';

import 'package:op123/app/models/User.dart';

GeneralResponse generalResponseFromMap(String str) => GeneralResponse.fromMap(json.decode(str));

String generalResponseToMap(GeneralResponse data) => json.encode(data.toMap());

class GeneralResponse {
    GeneralResponse({
        this.status,
        this.msg,
        this.user,
    });

    final String? status;
    final String? msg;
    final User? user;

    factory GeneralResponse.fromMap(Map<String, dynamic> json) => GeneralResponse(
        status: json["status"] == null ? null : json["status"],
        msg: json["msg"] == null ? null : json["msg"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "msg": msg == null ? null : msg,
        "user": user == null ? null : user!.toMap(),
    };
}
