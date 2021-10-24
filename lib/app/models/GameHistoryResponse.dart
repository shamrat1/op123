// To parse this JSON data, do
//
//     final gameHistoryResponse = gameHistoryResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GameHistoryResponse gameHistoryResponseFromMap(String str) => GameHistoryResponse.fromMap(json.decode(str));

String gameHistoryResponseToMap(GameHistoryResponse data) => json.encode(data.toMap());

class GameHistoryResponse {
    GameHistoryResponse({
        required this.gameHistory,
        required this.reward,
    });

    final GameHistory? gameHistory;
    final int? reward;

    factory GameHistoryResponse.fromMap(Map<String, dynamic> json) => GameHistoryResponse(
        gameHistory: json["gameHistory"] == null ? null : GameHistory.fromMap(json["gameHistory"]),
        reward: json["reward"] == null ? null : json["reward"],
    );

    Map<String, dynamic> toMap() => {
        "gameHistory": gameHistory == null ? null : gameHistory?.toMap(),
        "reward": reward == null ? null : reward,
    };
}

class GameHistory {
    GameHistory({
        required this.id,
        required this.userId,
        required this.gameType,
        required this.rate,
        required this.value,
        required this.amount,
        required this.status,
        required this.score,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final int? userId;
    final String? gameType;
    final String? rate;
    final String? value;
    final String? amount;
    final String? status;
    final String? score;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory GameHistory.fromMap(Map<String, dynamic> json) => GameHistory(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        gameType: json["game_type"] == null ? null : json["game_type"],
        rate: json["rate"] == null ? null : json["rate"],
        value: json["value"] == null ? null : json["value"],
        amount: json["amount"] == null ? null : json["amount"],
        status: json["status"] == null ? null : json["status"],
        score: json["score"] == null ? null : json["score"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "game_type": gameType == null ? null : gameType,
        "rate": rate == null ? null : rate,
        "value": value == null ? null : value,
        "amount": amount == null ? null : amount,
        "status": status == null ? null : status,
        "score": score == null ? null : score,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    };
}
