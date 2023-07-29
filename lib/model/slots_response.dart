// To parse this JSON data, do
//
//     final slotsResponse = slotsResponseFromJson(jsonString);

import 'dart:convert';

SlotsResponse slotsResponseFromJson(String str) => SlotsResponse.fromJson(json.decode(str));

String slotsResponseToJson(SlotsResponse data) => json.encode(data.toJson());

class SlotsResponse {
  final List<ParkingSlot>? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  SlotsResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory SlotsResponse.fromJson(Map<String, dynamic> json) => SlotsResponse(
    data: json["data"] == null ? [] : List<ParkingSlot>.from(json["data"]!.map((x) => ParkingSlot.fromJson(x))),
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

class ParkingSlot {
  final ParkingSlotDto? parkingSlotDto;
  final int? isBooked;

  ParkingSlot({
    this.parkingSlotDto,
    this.isBooked,
  });

  factory ParkingSlot.fromJson(Map<String, dynamic> json) => ParkingSlot(
    parkingSlotDto: json["parkingSlotDto"] == null ? null : ParkingSlotDto.fromJson(json["parkingSlotDto"]),
    isBooked: json["isBooked"],
  );

  Map<String, dynamic> toJson() => {
    "parkingSlotDto": parkingSlotDto?.toJson(),
    "isBooked": isBooked,
  };
}

class ParkingSlotDto {
  final int? parkingSlotId;
  final String? name;
  final bool? isAvailable;
  final int? rowIndex;
  final int? columnIndex;
  final int? floorId;

  ParkingSlotDto({
    this.parkingSlotId,
    this.name,
    this.isAvailable,
    this.rowIndex,
    this.columnIndex,
    this.floorId,
  });

  factory ParkingSlotDto.fromJson(Map<String, dynamic> json) => ParkingSlotDto(
    parkingSlotId: json["parkingSlotId"],
    name: json["name"],
    isAvailable: json["isAvailable"],
    rowIndex: json["rowIndex"],
    columnIndex: json["columnIndex"],
    floorId: json["floorId"],
  );

  Map<String, dynamic> toJson() => {
    "parkingSlotId": parkingSlotId,
    "name": name,
    "isAvailable": isAvailable,
    "rowIndex": rowIndex,
    "columnIndex": columnIndex,
    "floorId": floorId,
  };
}
