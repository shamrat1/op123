// To parse this JSON data, do
//
//     final match = matchFromMap(jsonString);

import 'dart:convert';
import 'package:op123/app/models/BetsForMatch.dart';
import 'package:op123/app/models/Tournament.dart';

List<Match> matchFromMap(String str) =>
    List<Match>.from(json.decode(str).map((x) => Match.fromMap(x)));

String matchToMap(List<Match> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Match {
  Match({
    this.id,
    this.name,
    this.matchTime,
    this.status,
    this.tournamentMatchNo,
    this.score,
    this.team1,
    this.team2,
    this.sportType,
    this.tournamentId,
    this.createdAt,
    this.updatedAt,
    this.uniqueId,
    this.tournament,
    this.betsForMatch,
  });

  final int? id;
  final String? name;
  final DateTime? matchTime;
  final String? status;
  final String? tournamentMatchNo;
  final String? score;
  final String? team1;
  final String? team2;
  final String? sportType;
  final int? tournamentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? uniqueId;
  final Tournament? tournament;
  final List<BetsForMatch>? betsForMatch;

  factory Match.fromMap(Map<String, dynamic> json) => Match(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        matchTime: json["match_time"] == null
            ? null
            : DateTime.parse(json["match_time"]),
        status: json["status"] == null ? null : json["status"],
        tournamentMatchNo: json["tournament_match_no"] == null
            ? null
            : json["tournament_match_no"],
        score: json["score"] == null ? null : json["score"],
        team1: json["team1"] == null ? null : json["team1"],
        team2: json["team2"] == null ? null : json["team2"],
        sportType: json["sport_type"] == null ? null : json["sport_type"],
        tournamentId:
            json["tournament_id"] == null ? null : json["tournament_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        uniqueId: json["unique_id"] == null ? null : json["unique_id"],
        tournament: json["tournament"] == null
            ? null
            : Tournament.fromMap(json["tournament"]),
        betsForMatch: json["bets_for_match"] == null
            ? null
            : List<BetsForMatch>.from(
                json["bets_for_match"].map((x) => BetsForMatch.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "match_time": matchTime == null ? null : matchTime.toString(),
        "status": status == null ? null : status,
        "tournament_match_no":
            tournamentMatchNo == null ? null : tournamentMatchNo,
        "score": score == null ? null : score,
        "team1": team1 == null ? null : team1,
        "team2": team2 == null ? null : team2,
        "sport_type": sportType == null ? null : sportType,
        "tournament_id": tournamentId == null ? null : tournamentId,
        "created_at": createdAt == null ? null : createdAt.toString(),
        "updated_at": updatedAt == null ? null : updatedAt.toString(),
        "unique_id": uniqueId == null ? null : uniqueId,
        "tournament": tournament == null ? null : tournament?.toMap(),
        "bets_for_match": betsForMatch == null
            ? null
            : List<dynamic>.from(betsForMatch!.map((x) => x.toMap())),
      };
}

class PlaceBetObjectModel {
  final String matchName;
  final String matchId;
  final String betOptionName;
  final String betForMatchId;
  final String betDetailKey;
  final String betDetailValue;
  final String betDetailsId;

  const PlaceBetObjectModel({
    required this.matchName,
    required this.betDetailKey,
    required this.betDetailValue,
    required this.betForMatchId,
    required this.betOptionName,
    required this.matchId,
    required this.betDetailsId,
  });
}
