// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  final String? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  Register({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    data: json["data"],
    success: json["success"],
    message: json["message"],
    statusCode: json["statusCode"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "success": success,
    "message": message,
    "statusCode": statusCode,
    "count": count,
  };
}
