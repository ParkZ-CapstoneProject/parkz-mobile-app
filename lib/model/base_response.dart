// To parse this JSON data, do
//
//     final baseResponse = baseResponseFromJson(jsonString);

import 'dart:convert';

BaseResponse baseResponseFromJson(String str) => BaseResponse.fromJson(json.decode(str));

String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse {
  final dynamic data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  BaseResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
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
