// To parse this JSON data, do
//
//     final floorsResponse = floorsResponseFromJson(jsonString);

import 'dart:convert';

FloorsResponse floorsResponseFromJson(String str) => FloorsResponse.fromJson(json.decode(str));

String floorsResponseToJson(FloorsResponse data) => json.encode(data.toJson());

class FloorsResponse {
  final List<Floor>? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  FloorsResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory FloorsResponse.fromJson(Map<String, dynamic> json) => FloorsResponse(
    data: json["data"] == null ? [] : List<Floor>.from(json["data"]!.map((x) => Floor.fromJson(x))),
    success: json["success"],
    message: json["message"],
    statusCode: json["statusCode"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "success": success,
    "message": message,
    "statusCode": statusCode,
    "count": count,
  };
}

class Floor {
  final int? floorId;
  final String? floorName;

  Floor({
    this.floorId,
    this.floorName,
  });

  factory Floor.fromJson(Map<String, dynamic> json) => Floor(
    floorId: json["floorId"],
    floorName: json["floorName"],
  );

  Map<String, dynamic> toJson() => {
    "floorId": floorId,
    "floorName": floorName,
  };
}
