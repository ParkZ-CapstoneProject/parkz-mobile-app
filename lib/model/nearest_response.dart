// To parse this JSON data, do
//
//     final nearestParkingResponse = nearestParkingResponseFromJson(jsonString);

import 'dart:convert';

NearestParkingResponse nearestParkingResponseFromJson(String str) => NearestParkingResponse.fromJson(json.decode(str));

String nearestParkingResponseToJson(NearestParkingResponse data) => json.encode(data.toJson());

class NearestParkingResponse {
  final List<Datum>? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  NearestParkingResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory NearestParkingResponse.fromJson(Map<String, dynamic> json) => NearestParkingResponse(
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
  final GetListParkingNearestYouQueryResponse? getListParkingNearestYouQueryResponse;
  final double? priceCar;
  final double? priceMoto;
  final double? distance;

  Datum({
    this.getListParkingNearestYouQueryResponse,
    this.priceCar,
    this.priceMoto,
    this.distance,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    getListParkingNearestYouQueryResponse: json["getListParkingNearestYouQueryResponse"] == null ? null : GetListParkingNearestYouQueryResponse.fromJson(json["getListParkingNearestYouQueryResponse"]),
    priceCar: json["priceCar"],
    priceMoto: json["priceMoto"],
    distance: json["distance"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "getListParkingNearestYouQueryResponse": getListParkingNearestYouQueryResponse?.toJson(),
    "priceCar": priceCar,
    "priceMoto": priceMoto,
    "distance": distance,
  };
}

class GetListParkingNearestYouQueryResponse {
  final int? parkingId;
  final String? name;
  final String? address;
  final double? latitude;
  final double? longitude;
  final double? stars;
  final String? avatar;
  final bool? isPrepayment;
  final bool? isOvernight;

  GetListParkingNearestYouQueryResponse({
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

  factory GetListParkingNearestYouQueryResponse.fromJson(Map<String, dynamic> json) => GetListParkingNearestYouQueryResponse(
    parkingId: json["parkingId"],
    name: json["name"],
    address: json["address"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    stars: json["stars"]?.toDouble(),
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
