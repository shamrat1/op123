// To parse this JSON data, do
//
//     final offersResponse = offersResponseFromJson(jsonString);

import 'dart:convert';

List<OffersResponse> offersResponseFromJson(String str) => List<OffersResponse>.from(json.decode(str).map((x) => OffersResponse.fromJson(x)));

String offersResponseToJson(List<OffersResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OffersResponse {
  OffersResponse({
    this.id,
    this.name,
    this.effectiveOn,
    this.status,
    this.minAmount,
    this.maxAmount,
    this.rewardAmount,
    this.amountType,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? effectiveOn;
  String? status;
  String? minAmount;
  String? maxAmount;
  String? rewardAmount;
  String? amountType;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory OffersResponse.fromJson(Map<String, dynamic> json) => OffersResponse(
    id: json["id"],
    name: json["name"],
    effectiveOn: json["effective_on"],
    status: json["status"],
    minAmount: json["min_amount"],
    maxAmount: json["max_amount"],
    rewardAmount: json["reward_amount"],
    amountType: json["amount_type"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "effective_on": effectiveOn,
    "status": status,
    "min_amount": minAmount,
    "max_amount": maxAmount,
    "reward_amount": rewardAmount,
    "amount_type": amountType,
    "start_date": startDate.toString(),
    "end_date": endDate.toString(),
    "created_at": createdAt == null ? null : createdAt.toString(),
    "updated_at": updatedAt.toString(),
  };
}
