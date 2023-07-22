// To parse this JSON data, do
//
//     final expectedPriceResponse = expectedPriceResponseFromJson(jsonString);

import 'dart:convert';

ExpectedPriceResponse expectedPriceResponseFromJson(String str) => ExpectedPriceResponse.fromJson(json.decode(str));

String expectedPriceResponseToJson(ExpectedPriceResponse data) => json.encode(data.toJson());

class ExpectedPriceResponse {
  final double? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  ExpectedPriceResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory ExpectedPriceResponse.fromJson(Map<String, dynamic> json) => ExpectedPriceResponse(
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
