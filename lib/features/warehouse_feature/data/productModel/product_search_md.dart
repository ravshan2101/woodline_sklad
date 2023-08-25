// To parse this JSON data, do
//
//     final productSearchGl = productSearchGlFromJson(jsonString);

import 'dart:convert';

ProductSearchGl productSearchGlFromJson(String str) => ProductSearchGl.fromJson(json.decode(str));

String productSearchGlToJson(ProductSearchGl data) => json.encode(data.toJson());

class ProductSearchGl {
    final int? totalAmount;
    final List<Product>? products;

    ProductSearchGl({
        this.totalAmount,
        this.products,
    });

    factory ProductSearchGl.fromJson(Map<String, dynamic> json) => ProductSearchGl(
        totalAmount: json["totalAmount"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalAmount": totalAmount,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
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
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
    final String? modelId;
    final Model? model;

    Order({
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
        this.model,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
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
        model: json["model"] == null ? null : Model.fromJson(json["model"]),
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
        furnitureType: json["furniture_type"] == null ? null : FurnitureType.fromJson(json["furniture_type"]),
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