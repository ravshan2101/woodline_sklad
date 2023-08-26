// To parse this JSON data, do
//
//     final transferedGetMd = transferedGetMdFromJson(jsonString);

import 'dart:convert';

TransferedGetMd transferedGetMdFromJson(String str) =>
    TransferedGetMd.fromJson(json.decode(str));

String transferedGetMdToJson(TransferedGetMd data) =>
    json.encode(data.toJson());

class TransferedGetMd {
  final int? totalAmount;
  final List<Product>? products;

  TransferedGetMd({
    this.totalAmount,
    this.products,
  });

  factory TransferedGetMd.fromJson(Map<String, dynamic> json) =>
      TransferedGetMd(
        totalAmount: json["totalAmount"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalAmount": totalAmount,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  final String? id;
  final String? orderId;
  final String? warehouseId;
  final bool? isActive;
  final bool? isCopied;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Order? order;

  Product({
    this.id,
    this.orderId,
    this.warehouseId,
    this.isActive,
    this.isCopied,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.order,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        orderId: json["order_id"],
        warehouseId: json["warehouse_id"],
        isActive: json["is_active"],
        isCopied: json["is_copied"],
        deletedAt: json["deletedAt"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "warehouse_id": warehouseId,
        "is_active": isActive,
        "is_copied": isCopied,
        "deletedAt": deletedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "order": order?.toJson(),
      };
}

class Order {
  final String? orderId;
  final int? qty;
  final String? tissue;
  final String? cost;
  final String? sale;
  final String? title;
  final String? sum;
  final String? status;
  final Model? model;

  Order({
    this.orderId,
    this.qty,
    this.tissue,
    this.cost,
    this.sale,
    this.title,
    this.sum,
    this.status,
    this.model,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["order_id"],
        qty: json["qty"],
        tissue: json["tissue"],
        cost: json["cost"],
        sale: json["sale"],
        title: json["title"],
        sum: json["sum"],
        status: json["status"],
        model: json["model"] == null ? null : Model.fromJson(json["model"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "qty": qty,
        "tissue": tissue,
        "cost": cost,
        "sale": sale,
        "title": title,
        "sum": sum,
        "status": status,
        "model": model?.toJson(),
      };
}

class Model {
  final String? id;
  final String? name;
  final FurnitureType? furnitureType;

  Model({
    this.id,
    this.name,
    this.furnitureType,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["id"],
        name: json["name"],
        furnitureType: json["furniture_type"] == null
            ? null
            : FurnitureType.fromJson(json["furniture_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
