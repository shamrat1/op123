import 'package:op123/app/models/BetDetail.dart';
import 'package:op123/app/models/BetOption.dart';

class BetsForMatch {
  BetsForMatch({
    this.id,
    this.bfmId,
    this.matchId,
    this.betOptionId,
    this.correctBet,
    this.isLive,
    this.score,
    this.isResultPublished,
    this.createdAt,
    this.updatedAt,
    this.betOption,
    this.betDetails,
  });

  final int? id;
  final dynamic bfmId;
  final int? matchId;
  final int? betOptionId;
  final int? correctBet;
  final int? isLive;
  final int? score;
  final int? isResultPublished;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final BetOption? betOption;
  final List<BetDetail>? betDetails;

  factory BetsForMatch.fromMap(Map<String, dynamic> json) => BetsForMatch(
        id: json["id"] == null ? null : json["id"],
        bfmId: json["bfm_id"],
        matchId: json["match_id"] == null ? null : json["match_id"],
        betOptionId:
            json["bet_option_id"] == null ? null : json["bet_option_id"],
        correctBet: json["correctBet"] == null ? null : json["correctBet"],
        isLive: json["isLive"] == null ? null : json["isLive"],
        score: json["score"] == null ? null : json["score"],
        isResultPublished: json["isResultPublished"] == null
            ? null
            : json["isResultPublished"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        betOption: json["bet_option"] == null
            ? null
            : BetOption.fromMap(json["bet_option"]),
        betDetails: json["bet_details"] == null
            ? null
            : List<BetDetail>.from(
                json["bet_details"].map((x) => BetDetail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "bfm_id": bfmId,
        "match_id": matchId == null ? null : matchId,
        "bet_option_id": betOptionId == null ? null : betOptionId,
        "correctBet": correctBet == null ? null : correctBet,
        "isLive": isLive == null ? null : isLive,
        "score": score == null ? null : score,
        "isResultPublished":
            isResultPublished == null ? null : isResultPublished,
        "created_at": createdAt == null ? null : createdAt.toString(),
        "updated_at": updatedAt == null ? null : updatedAt.toString(),
        "bet_option": betOption == null ? null : betOption?.toMap(),
        "bet_details": betDetails == null
            ? null
            : List<dynamic>.from(betDetails!.map((x) => x.toMap())),
      };
}