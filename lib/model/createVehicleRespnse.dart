// To parse this JSON data, do
//
//     final createVehicleResponse = createVehicleResponseFromJson(jsonString);

import 'dart:convert';

CreateVehicleResponse createVehicleResponseFromJson(String str) => CreateVehicleResponse.fromJson(json.decode(str));

String createVehicleResponseToJson(CreateVehicleResponse data) => json.encode(data.toJson());

class CreateVehicleResponse {
  final int? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  CreateVehicleResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory CreateVehicleResponse.fromJson(Map<String, dynamic> json) => CreateVehicleResponse(
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
