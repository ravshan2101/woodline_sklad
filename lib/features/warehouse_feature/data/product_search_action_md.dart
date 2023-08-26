// To parse this JSON data, do
//
//     final productSearch = productSearchFromJson(jsonString);

import 'dart:convert';

List<ProductSearch> productSearchFromJson(List str) =>
    List<ProductSearch>.from(str.map((x) => ProductSearch.fromJson(x)));

String productSearchToJson(List<ProductSearch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductSearch {
  final String? id;
  final String? name;
  final String? price;
  final dynamic sale;
  final dynamic code;
  final bool? isActive;
  final String? companyId;
  final Status? status;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? typeId;
  final FurnitureType? furnitureType;

  ProductSearch({
    this.id,
    this.name,
    this.price,
    this.sale,
    this.code,
    this.isActive,
    this.companyId,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.typeId,
    this.furnitureType,
  });

  factory ProductSearch.fromJson(Map<String, dynamic> json) => ProductSearch(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        sale: json["sale"],
        code: json["code"],
        isActive: json["is_active"],
        companyId: json["company_id"],
        status: statusValues.map[json["status"]]!,
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        typeId: json["type_id"],
        furnitureType: json["furniture_type"] == null
            ? null
            : FurnitureType.fromJson(json["furniture_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "sale": sale,
        "code": code,
        "is_active": isActive,
        "company_id": companyId,
        "status": statusValues.reverse[status],
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "type_id": typeId,
        "furniture_type": furnitureType?.toJson(),
      };
}

class FurnitureType {
  final String? id;
  final String? name;

  FurnitureType({
    this.id,
    this.name,
  });

  factory FurnitureType.fromJson(Map<String, dynamic> json) => FurnitureType(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

enum Status { NEW }

final statusValues = EnumValues({"NEW": Status.NEW});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
