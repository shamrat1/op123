// To parse this JSON data, do
//
//     final settingResponse = settingResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SettingResponse settingResponseFromMap(String str) => SettingResponse.fromMap(json.decode(str));

String settingResponseToMap(SettingResponse data) => json.encode(data.toMap());

class SettingResponse {
    SettingResponse({
        @required this.settings,
        @required this.siteSetting,
        @required this.betSetting,
    });

    final List<Setting>? settings;
    final SiteSetting? siteSetting;
    final BetSetting? betSetting;

    factory SettingResponse.fromMap(Map<String, dynamic> json) => SettingResponse(
        settings: json["settings"] == null ? null : List<Setting>.from(json["settings"].map((x) => Setting.fromMap(x))),
        siteSetting: json["site_setting"] == null ? null : SiteSetting.fromMap(json["site_setting"]),
        betSetting: json["bet_setting"] == null ? null : BetSetting.fromMap(json["bet_setting"]),
    );

    Map<String, dynamic> toMap() => {
        "settings": settings == null ? null : List<dynamic>.from(settings!.map((x) => x.toMap())),
        "site_setting": siteSetting == null ? null : siteSetting?.toMap(),
        "bet_setting": betSetting == null ? null : betSetting?.toMap(),
    };
}

class BetSetting {
    BetSetting({
        @required this.id,
        @required this.lowestAmount,
        @required this.highestAmount,
        @required this.createdAt,
        @required this.updatedAt,
    });

    final int? id;
    final String? lowestAmount;
    final String? highestAmount;
    final dynamic? createdAt;
    final DateTime? updatedAt;

    factory BetSetting.fromMap(Map<String, dynamic> json) => BetSetting(
        id: json["id"] == null ? null : json["id"],
        lowestAmount: json["lowest_amount"] == null ? null : json["lowest_amount"],
        highestAmount: json["highest_amount"] == null ? null : json["highest_amount"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "lowest_amount": lowestAmount == null ? null : lowestAmount,
        "highest_amount": highestAmount == null ? null : highestAmount,
        "created_at": createdAt,
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    };
}

class Setting {
    Setting({
        @required this.id,
        @required this.key,
        @required this.value,
        @required this.createdAt,
        @required this.updatedAt,
    });

    final int? id;
    final String? key;
    final String? value;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Setting.fromMap(Map<String, dynamic> json) => Setting(
        id: json["id"] == null ? null : json["id"],
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "key": key == null ? null : key,
        "value": value == null ? null : value,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    };
}

class SiteSetting {
    SiteSetting({
        @required this.id,
        @required this.betting,
        @required this.backendNumber,
        @required this.notice,
        @required this.isWithdrawable,
        @required this.isDepositable,
        @required this.withdrawDate,
        @required this.createdAt,
        @required this.updatedAt,
    });

    final int? id;
    final int? betting;
    final String? backendNumber;
    final String? notice;
    final int? isWithdrawable;
    final int? isDepositable;
    final String? withdrawDate;
    final dynamic? createdAt;
    final DateTime? updatedAt;

    factory SiteSetting.fromMap(Map<String, dynamic> json) => SiteSetting(
        id: json["id"] == null ? null : json["id"],
        betting: json["betting"] == null ? null : json["betting"],
        backendNumber: json["backend_number"] == null ? null : json["backend_number"],
        notice: json["notice"] == null ? null : json["notice"],
        isWithdrawable: json["isWithdrawable"] == null ? null : json["isWithdrawable"],
        isDepositable: json["isDepositable"] == null ? null : json["isDepositable"],
        withdrawDate: json["withdraw_date"] == null ? null : json["withdraw_date"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "betting": betting == null ? null : betting,
        "backend_number": backendNumber == null ? null : backendNumber,
        "notice": notice == null ? null : notice,
        "isWithdrawable": isWithdrawable == null ? null : isWithdrawable,
        "isDepositable": isDepositable == null ? null : isDepositable,
        "withdraw_date": withdrawDate == null ? null : withdrawDate,
        "created_at": createdAt,
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    };
}
