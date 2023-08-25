// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  final Token? token;

  AuthModel({
    this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        token: json["token"] == null ? null : Token.fromJson(json["token"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token?.toJson(),
      };
}

class Token {
  final String? token;
  final String? companyId;
  final String? role;
  final String? name;

  Token({
    this.token,
    this.companyId,
    this.role,
    this.name,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"],
        companyId: json["company_id"],
        role: json["role"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "company_id": companyId,
        "role": role,
        "name": name,
      };
}
