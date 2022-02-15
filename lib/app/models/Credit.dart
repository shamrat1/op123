
class Credit {
    Credit({
        this.id,
        this.userId,
        this.amount,
        this.bonusPoint,
        this.createdAt,
        this.updatedAt,
    });

    final int? id;
    final int? userId;
    final String? amount;
    final String? bonusPoint;
    final String? createdAt;
    final String? updatedAt;

    factory Credit.fromMap(Map<String, dynamic> json) => Credit(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        amount: json["amount"] == null ? null : json["amount"],
        bonusPoint: json["bonus_point"] == null ? null : json["bonus_point"].toString(),
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "amount": amount == null ? null : amount,
        "bonus_point": bonusPoint == null ? null : bonusPoint,
        "created_at": createdAt == null ? null : createdAt.toString(),
        "updated_at": updatedAt == null ? null : updatedAt.toString(),
    };
}