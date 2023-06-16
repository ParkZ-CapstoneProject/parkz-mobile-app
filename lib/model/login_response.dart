// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final String? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  LoginResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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
