// To parse this JSON data, do
//
//     final betHistoryResponse = betHistoryResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:OnPlay365/app/models/BetDetail.dart';
import 'package:OnPlay365/app/models/Match.dart';

BetHistoryResponse betHistoryResponseFromMap(String str) =>
    BetHistoryResponse.fromMap(json.decode(str));

String betHistoryResponseToMap(BetHistoryResponse data) =>
    json.encode(data.toMap());

class BetHistoryResponse {
  BetHistoryResponse({
    this.status,
    this.msg,
    this.placedBets,
  });

  final String? status;
  final String? msg;
  final PlacedBets? placedBets;

  factory BetHistoryResponse.fromMap(Map<String, dynamic> json) =>
      BetHistoryResponse(
        status: json["status"] == null ? null : json["status"],
        msg: json["msg"] == null ? null : json["msg"],
        placedBets: json["placedBets"] == null
            ? null
            : PlacedBets.fromMap(json["placedBets"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "msg": msg == null ? null : msg,
        "placedBets": placedBets == null ? null : placedBets!.toMap(),
      };
}

class PlacedBets {
  PlacedBets({
    this.currentPage,
    this.bets,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  final int? currentPage;
  final List<Bet>? bets;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  factory PlacedBets.fromMap(Map<String, dynamic> json) => PlacedBets(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        bets: json["data"] == null
            ? null
            : List<Bet>.from(json["data"].map((x) => Bet.fromMap(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage == null ? null : currentPage,
        "bets": bets == null
            ? null
            : List<dynamic>.from(bets!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

class Bet {
  Bet({
    this.id,
    this.userId,
    this.matchId,
    this.transactionId,
    this.betOptionDetailId,
    this.amount,
    this.betName,
    this.betValue,
    this.createdAt,
    this.updatedAt,
    this.isWin,
    this.match,
    this.betDetail,
  });

  final int? id;
  final int? userId;
  final int? matchId;
  final int? transactionId;
  final int? betOptionDetailId;
  final int? amount;
  final String? betName;
  final double? betValue;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic isWin;
  final Match? match;
  final BetDetail? betDetail;

  factory Bet.fromMap(Map<String, dynamic> json) => Bet(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        matchId: json["match_id"] == null ? null : json["match_id"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        betOptionDetailId: json["bet_option_detail_id"] == null
            ? null
            : json["bet_option_detail_id"],
        amount: json["amount"] == null ? null : json["amount"],
        betName: json["bet_name"] == null ? null : json["bet_name"],
        betValue:
            json["bet_value"] == null ? null : json["bet_value"].toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isWin: json["isWin"],
        match: json["match"] == null ? null : Match.fromMap(json["match"]),
        betDetail: json["bet_detail"] == null
            ? null
            : BetDetail.fromMap(json["bet_detail"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "match_id": matchId == null ? null : matchId,
        "transaction_id": transactionId == null ? null : transactionId,
        "bet_option_detail_id":
            betOptionDetailId == null ? null : betOptionDetailId,
        "amount": amount == null ? null : amount,
        "bet_name": betName == null ? null : betName,
        "bet_value": betValue == null ? null : betValue,
        "created_at": createdAt != null ? createdAt?.toIso8601String() : null,
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "isWin": isWin,
        "match": match == null ? null : match?.toMap(),
        "bet_detail": betDetail == null ? null : betDetail?.toMap(),
      };
}
