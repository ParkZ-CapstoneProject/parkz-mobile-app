// To parse this JSON data, do
//
//     final vehicleListResponse = vehicleListResponseFromJson(jsonString);

import 'dart:convert';

VehicleListResponse vehicleListResponseFromJson(String str) => VehicleListResponse.fromJson(json.decode(str));

String vehicleListResponseToJson(VehicleListResponse data) => json.encode(data.toJson());

class VehicleListResponse {
  final List<Vehicle>? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  VehicleListResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory VehicleListResponse.fromJson(Map<String, dynamic> json) => VehicleListResponse(
    data: json["data"] == null ? [] : List<Vehicle>.from(json["data"]!.map((x) => Vehicle.fromJson(x))),
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

class Vehicle {
  final int? vehicleInforId;
  final String? licensePlate;
  final String? vehicleName;
  final String? color;
  final String? trafficName;

  Vehicle({
    this.vehicleInforId,
    this.licensePlate,
    this.vehicleName,
    this.color,
    this.trafficName,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    vehicleInforId: json["vehicleInforId"],
    licensePlate: json["licensePlate"],
    vehicleName: json["vehicleName"],
    color: json["color"],
    trafficName: json["trafficName"],
  );

  Map<String, dynamic> toJson() => {
    "vehicleInforId": vehicleInforId,
    "licensePlate": licensePlate,
    "vehicleName": vehicleName,
    "color": color,
    "trafficName": trafficName,
  };
}
