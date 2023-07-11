// To parse this JSON data, do
//
//     final searchParkingResponse = searchParkingResponseFromJson(jsonString);

import 'dart:convert';

SearchParkingResponse searchParkingResponseFromJson(String str) => SearchParkingResponse.fromJson(json.decode(str));

String searchParkingResponseToJson(SearchParkingResponse data) => json.encode(data.toJson());

class SearchParkingResponse {
  final List<Datum>? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  SearchParkingResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory SearchParkingResponse.fromJson(Map<String, dynamic> json) => SearchParkingResponse(
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
  final GetListParkingNearestWithDistanceResponse? getListParkingNearestWithDistanceResponse;
  final double? priceCar;
  final double? priceMoto;
  final double? distance;

  Datum({
    this.getListParkingNearestWithDistanceResponse,
    this.priceCar,
    this.priceMoto,
    this.distance,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    getListParkingNearestWithDistanceResponse: json["getListParkingNearestWithDistanceResponse"] == null ? null : GetListParkingNearestWithDistanceResponse.fromJson(json["getListParkingNearestWithDistanceResponse"]),
    priceCar: json["priceCar"],
    priceMoto: json["priceMoto"],
    distance: json["distance"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "getListParkingNearestWithDistanceResponse": getListParkingNearestWithDistanceResponse?.toJson(),
    "priceCar": priceCar,
    "priceMoto": priceMoto,
    "distance": distance,
  };
}

class GetListParkingNearestWithDistanceResponse {
  final int? parkingId;
  final String? name;
  final String? address;
  final double? latitude;
  final double? longitude;
  final int? stars;
  final String? avatar;
  final bool? isPrepayment;
  final bool? isOvernight;

  GetListParkingNearestWithDistanceResponse({
    this.parkingId,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.stars,
    this.avatar,
    this.isPrepayment,
    this.isOvernight,
  });

  factory GetListParkingNearestWithDistanceResponse.fromJson(Map<String, dynamic> json) => GetListParkingNearestWithDistanceResponse(
    parkingId: json["parkingId"],
    name: json["name"],
    address: json["address"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    stars: json["stars"],
    avatar: json["avatar"],
    isPrepayment: json["isPrepayment"],
    isOvernight: json["isOvernight"],
  );

  Map<String, dynamic> toJson() => {
    "parkingId": parkingId,
    "name": name,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "stars": stars,
    "avatar": avatar,
    "isPrepayment": isPrepayment,
    "isOvernight": isOvernight,
  };
}
