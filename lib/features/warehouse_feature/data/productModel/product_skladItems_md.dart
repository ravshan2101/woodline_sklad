// To parse this JSON data, do
//
//     final transferSkladItems = transferSkladItemsFromJson(jsonString);

import 'dart:convert';

List<TransferSkladItems> transferSkladItemsFromJson(List str) =>
    List<TransferSkladItems>.from(
        str.map((x) => TransferSkladItems.fromJson(x)));

String transferSkladItemsToJson(List<TransferSkladItems> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferSkladItems {
  final String? id;
  final String? name;
  final String? companyId;
  final String? admin;
  final String? status;
  final String? type;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TransferSkladItems({
    this.id,
    this.name,
    this.companyId,
    this.admin,
    this.status,
    this.type,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory TransferSkladItems.fromJson(Map<String, dynamic> json) =>
      TransferSkladItems(
        id: json["id"],
        name: json["name"],
        companyId: json["company_id"],
        admin: json["admin"],
        status: json["status"],
        type: json["type"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "company_id": companyId,
        "admin": admin,
        "status": status,
        "type": type,
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
