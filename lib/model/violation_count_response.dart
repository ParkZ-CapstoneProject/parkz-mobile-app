// To parse this JSON data, do
//
//     final violationCountResponse = violationCountResponseFromJson(jsonString);

import 'dart:convert';

ViolationCountResponse violationCountResponseFromJson(String str) => ViolationCountResponse.fromJson(json.decode(str));

String violationCountResponseToJson(ViolationCountResponse data) => json.encode(data.toJson());

class ViolationCountResponse {
  final Data? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  ViolationCountResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory ViolationCountResponse.fromJson(Map<String, dynamic> json) => ViolationCountResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    success: json["success"],
    message: json["message"],
    statusCode: json["statusCode"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "success": success,
    "message": message,
    "statusCode": statusCode,
    "count": count,
  };
}

class Data {
  final int? banCount;

  Data({
    this.banCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    banCount: json["banCount"],
  );

  Map<String, dynamic> toJson() => {
    "banCount": banCount,
  };
}
