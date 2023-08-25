// To parse this JSON data, do
//
//     final productPostModel = productPostModelFromJson(jsonString);

import 'dart:convert';

ProductPostModel productPostModelFromJson(String str) => ProductPostModel.fromJson(json.decode(str));

String productPostModelToJson(ProductPostModel data) => json.encode(data.toJson());

class ProductPostModel {
    final String? id;
    final bool? isActive;
    final dynamic deletedAt;
    final String? warehouseId;
    final String? orderId;
    final DateTime? updatedAt;
    final DateTime? createdAt;

    ProductPostModel({
        this.id,
        this.isActive,
        this.deletedAt,
        this.warehouseId,
        this.orderId,
        this.updatedAt,
        this.createdAt,
    });

    factory ProductPostModel.fromJson(Map<String, dynamic> json) => ProductPostModel(
        id: json["id"],
        isActive: json["is_active"],
        deletedAt: json["deletedAt"],
        warehouseId: json["warehouse_id"],
        orderId: json["order_id"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "is_active": isActive,
        "deletedAt": deletedAt,
        "warehouse_id": warehouseId,
        "order_id": orderId,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
    };
}
