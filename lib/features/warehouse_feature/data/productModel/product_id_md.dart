// To parse this JSON data, do
//
//     final productId = productIdFromJson(jsonString);

import 'dart:convert';

ProductId productIdFromJson(String str) => ProductId.fromJson(json.decode(str));

String productIdToJson(ProductId data) => json.encode(data.toJson());

class ProductId {
    final String? id;
    final String? orderId;
    final String? cathegory;
    final String? tissue;
    final String? title;
    final String? cost;
    final String? sale;
    final int? qty;
    final String? sum;
    final bool? isFirst;
    final bool? copied;
    final String? status;
    final bool? isActive;
    final dynamic endDate;
    final dynamic sellerId;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic dealId;
    final dynamic modelId;

    ProductId({
        this.id,
        this.orderId,
        this.cathegory,
        this.tissue,
        this.title,
        this.cost,
        this.sale,
        this.qty,
        this.sum,
        this.isFirst,
        this.copied,
        this.status,
        this.isActive,
        this.endDate,
        this.sellerId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.dealId,
        this.modelId,
    });

    factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["id"],
        orderId: json["order_id"],
        cathegory: json["cathegory"],
        tissue: json["tissue"],
        title: json["title"],
        cost: json["cost"],
        sale: json["sale"],
        qty: json["qty"],
        sum: json["sum"],
        isFirst: json["is_first"],
        copied: json["copied"],
        status: json["status"],
        isActive: json["is_active"],
        endDate: json["end_date"],
        sellerId: json["seller_id"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        dealId: json["deal_id"],
        modelId: json["model_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "cathegory": cathegory,
        "tissue": tissue,
        "title": title,
        "cost": cost,
        "sale": sale,
        "qty": qty,
        "sum": sum,
        "is_first": isFirst,
        "copied": copied,
        "status": status,
        "is_active": isActive,
        "end_date": endDate,
        "seller_id": sellerId,
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deal_id": dealId,
        "model_id": modelId,
    };
}
