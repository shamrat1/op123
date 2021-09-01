class BetOption {
  BetOption({
    this.id,
    this.name,
    this.description,
    this.type,
    this.isMultipleSupported,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? description;
  final dynamic type;
  final int? isMultipleSupported;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory BetOption.fromMap(Map<String, dynamic> json) => BetOption(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        type: json["type"],
        isMultipleSupported: json["isMultipleSupported"] == null
            ? null
            : json["isMultipleSupported"],
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
        "description": description == null ? null : description,
        "type": type,
        "isMultipleSupported":
            isMultipleSupported == null ? null : isMultipleSupported,
        "created_at": createdAt == null ? null : createdAt.toString(),
        "updated_at": updatedAt == null ? null : updatedAt.toString(),
      };
}