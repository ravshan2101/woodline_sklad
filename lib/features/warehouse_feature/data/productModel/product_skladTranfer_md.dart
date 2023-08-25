// To parse this JSON data, do
//
//     final transferSkladModel = transferSkladModelFromJson(jsonString);

import 'dart:convert';

TransferSkladModel transferSkladModelFromJson(String str) =>
    TransferSkladModel.fromJson(json.decode(str));

String transferSkladModelToJson(TransferSkladModel data) =>
    json.encode(data.toJson());

class TransferSkladModel {
  final String? id;
  final bool? isCopied;
  final dynamic deletedAt;
  final String? orderId;
  final String? warehouseId;
  final bool? isActive;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  TransferSkladModel({
    this.id,
    this.isCopied,
    this.deletedAt,
    this.orderId,
    this.warehouseId,
    this.isActive,
    this.updatedAt,
    this.createdAt,
  });

  factory TransferSkladModel.fromJson(Map<String, dynamic> json) =>
      TransferSkladModel(
        id: json["id"],
        isCopied: json["is_copied"],
        deletedAt: json["deletedAt"],
        orderId: json["order_id"],
        warehouseId: json["warehouse_id"],
        isActive: json["is_active"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_copied": isCopied,
        "deletedAt": deletedAt,
        "order_id": orderId,
        "warehouse_id": warehouseId,
        "is_active": isActive,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
