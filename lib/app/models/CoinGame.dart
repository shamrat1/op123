// To parse this JSON data, do
//
//     final coinGame = coinGameFromMap(jsonString);

import 'dart:convert';

CoinGame coinGameFromMap(String str) => CoinGame.fromMap(json.decode(str));

String coinGameToMap(CoinGame data) => json.encode(data.toMap());

class CoinGame {
    CoinGame({
        this.status,
        this.msg,
        required this.isWin,
    });

    final String? status;
    final String? msg;
    final bool isWin;

    factory CoinGame.fromMap(Map<String, dynamic> json) => CoinGame(
        status: json["status"] == null ? null : json["status"],
        msg: json["msg"] == null ? null : json["msg"],
        isWin: json["isWin"] == null ? null : json["isWin"],
    );

    Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "msg": msg == null ? null : msg,
        "isWin": isWin == null ? null : isWin,
    };
}
