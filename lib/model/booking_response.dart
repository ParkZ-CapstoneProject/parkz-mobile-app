// To parse this JSON data, do
//
//     final bookingResponse = bookingResponseFromJson(jsonString);

import 'dart:convert';

BookingResponse bookingResponseFromJson(String str) => BookingResponse.fromJson(json.decode(str));

String bookingResponseToJson(BookingResponse data) => json.encode(data.toJson());

class BookingResponse {
  final int? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  BookingResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) => BookingResponse(
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
