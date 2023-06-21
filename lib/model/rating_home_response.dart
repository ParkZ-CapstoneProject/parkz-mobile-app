// To parse this JSON data, do
//
//     final ratingHomeResponse = ratingHomeResponseFromJson(jsonString);

import 'dart:convert';

RatingHomeResponse ratingHomeResponseFromJson(String str) => RatingHomeResponse.fromJson(json.decode(str));

String ratingHomeResponseToJson(RatingHomeResponse data) => json.encode(data.toJson());

class RatingHomeResponse {
  final List<Datum>? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  RatingHomeResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory RatingHomeResponse.fromJson(Map<String, dynamic> json) => RatingHomeResponse(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  final ParkingShowInCusDto? parkingShowInCusDto;
  final double? priceCar;
  final double? priceMoto;

  Datum({
    this.parkingShowInCusDto,
    this.priceCar,
    this.priceMoto,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    parkingShowInCusDto: json["parkingShowInCusDto"] == null ? null : ParkingShowInCusDto.fromJson(json["parkingShowInCusDto"]),
    priceCar: json["priceCar"],
    priceMoto: json["priceMoto"],
  );

  Map<String, dynamic> toJson() => {
    "parkingShowInCusDto": parkingShowInCusDto?.toJson(),
    "priceCar": priceCar,
    "priceMoto": priceMoto,
  };
}

class ParkingShowInCusDto {
  final int? parkingId;
  final String? name;
  final String? address;
  final String? avatar;
  final double? stars;

  ParkingShowInCusDto({
    this.parkingId,
    this.name,
    this.address,
    this.avatar,
    this.stars,
  });

  factory ParkingShowInCusDto.fromJson(Map<String, dynamic> json) => ParkingShowInCusDto(
    parkingId: json["parkingId"],
    name: json["name"],
    address: json["address"],
    avatar: json["avatar"],
    stars: json["stars"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "parkingId": parkingId,
    "name": name,
    "address": address,
    "avatar": avatar,
    "stars": stars,
  };
}
