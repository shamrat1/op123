class BetDetail {
  BetDetail({
    this.id,
    this.name,
    this.value,
    this.betsForMatchId,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? value;
  final int? betsForMatchId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory BetDetail.fromMap(Map<String, dynamic> json) => BetDetail(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        value: json["value"] == null ? null : json["value"],
        betsForMatchId: json["bets_for_match_id"] == null
            ? null
            : json["bets_for_match_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "value": value == null ? null : value,
        "bets_for_match_id": betsForMatchId == null ? null : betsForMatchId,
        "created_at": createdAt == null ? null : createdAt.toString(),
        "updated_at": updatedAt == null ? null : updatedAt.toString(),
      };
}