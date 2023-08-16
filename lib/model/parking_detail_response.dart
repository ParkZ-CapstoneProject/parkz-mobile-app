// To parse this JSON data, do
//
//     final parkingDetailResponse = parkingDetailResponseFromJson(jsonString);

import 'dart:convert';

ParkingDetailResponse parkingDetailResponseFromJson(String str) => ParkingDetailResponse.fromJson(json.decode(str));

String parkingDetailResponseToJson(ParkingDetailResponse data) => json.encode(data.toJson());

class ParkingDetailResponse {
  final Data? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  ParkingDetailResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory ParkingDetailResponse.fromJson(Map<String, dynamic> json) => ParkingDetailResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    success: json["success"],
    message: json["message"],
    statusCode: json["statusCode"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "success": success,
    "message": message,
    "statusCode": statusCode,
    "count": count,
  };
}

class Data {
  final Parking? parking;

  Data({
    this.parking,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    parking: json["parking"] == null ? null : Parking.fromJson(json["parking"]),
  );

  Map<String, dynamic> toJson() => {
    "parking": parking?.toJson(),
  };
}

class Parking {
  final int? parkingId;
  final String? name;
  final String? address;
  final String? description;
  final double? stars;
  final double? totalStars;
  final int? starsCount;
  final int? motoSpot;
  final int? carSpot;
  final bool? isFull;
  final bool? isPrepayment;
  final bool? isOvernight;
  final List<ParkingHasPrice>? parkingHasPrices;
  final List<ParkingSpotImage>? parkingSpotImages;

  Parking({
    this.parkingId,
    this.name,
    this.address,
    this.description,
    this.stars,
    this.totalStars,
    this.starsCount,
    this.motoSpot,
    this.carSpot,
    this.isFull,
    this.isPrepayment,
    this.isOvernight,
    this.parkingHasPrices,
    this.parkingSpotImages,
  });

  factory Parking.fromJson(Map<String, dynamic> json) => Parking(
    parkingId: json["parkingId"],
    name: json["name"],
    address: json["address"],
    description: json["description"],
    stars: json["stars"]?.toDouble(),
    totalStars: json["totalStars"]?.toDouble(),
    starsCount: json["starsCount"],
    motoSpot: json["motoSpot"],
    carSpot: json["carSpot"],
    isFull: json["isFull"],
    isPrepayment: json["isPrepayment"],
    isOvernight: json["isOvernight"],
    parkingHasPrices: json["parkingHasPrices"] == null ? [] : List<ParkingHasPrice>.from(json["parkingHasPrices"]!.map((x) => ParkingHasPrice.fromJson(x))),
    parkingSpotImages: json["parkingSpotImages"] == null ? [] : List<ParkingSpotImage>.from(json["parkingSpotImages"]!.map((x) => ParkingSpotImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "parkingId": parkingId,
    "name": name,
    "address": address,
    "description": description,
    "stars": stars,
    "totalStars": totalStars,
    "starsCount": starsCount,
    "motoSpot": motoSpot,
    "carSpot": carSpot,
    "isFull": isFull,
    "isPrepayment": isPrepayment,
    "isOvernight": isOvernight,
    "parkingHasPrices": parkingHasPrices == null ? [] : List<dynamic>.from(parkingHasPrices!.map((x) => x.toJson())),
    "parkingSpotImages": parkingSpotImages == null ? [] : List<dynamic>.from(parkingSpotImages!.map((x) => x.toJson())),
  };
}

class ParkingHasPrice {
  final ParkingPrice? parkingPrice;

  ParkingHasPrice({
    this.parkingPrice,
  });

  factory ParkingHasPrice.fromJson(Map<String, dynamic> json) => ParkingHasPrice(
    parkingPrice: json["parkingPrice"] == null ? null : ParkingPrice.fromJson(json["parkingPrice"]),
  );

  Map<String, dynamic> toJson() => {
    "parkingPrice": parkingPrice?.toJson(),
  };
}

class ParkingPrice {
  final int? parkingPriceId;
  final String? parkingPriceName;
  final int? startingTime;
  final Traffic? traffic;
  final int? extraTimeStep;
  final List<TimeLine>? timeLines;
  final double? penaltyPrice;
  final int? penaltyPriceStepTime;

  ParkingPrice({
    this.parkingPriceId,
    this.parkingPriceName,
    this.startingTime,
    this.traffic,
    this.extraTimeStep,
    this.timeLines,
    this.penaltyPrice,
    this.penaltyPriceStepTime,
  });

  factory ParkingPrice.fromJson(Map<String, dynamic> json) => ParkingPrice(
    parkingPriceId: json["parkingPriceId"],
    parkingPriceName: json["parkingPriceName"],
    startingTime: json["startingTime"],
    traffic: json["traffic"] == null ? null : Traffic.fromJson(json["traffic"]),
    extraTimeStep: json["extraTimeStep"],
    timeLines: json["timeLines"] == null ? [] : List<TimeLine>.from(json["timeLines"]!.map((x) => TimeLine.fromJson(x))),
    penaltyPrice: json["penaltyPrice"]?.toDouble(),
    penaltyPriceStepTime: json["penaltyPriceStepTime"],
  );

  Map<String, dynamic> toJson() => {
    "parkingPriceId": parkingPriceId,
    "parkingPriceName": parkingPriceName,
    "startingTime": startingTime,
    "traffic": traffic?.toJson(),
    "extraTimeStep": extraTimeStep,
    "timeLines": timeLines == null ? [] : List<dynamic>.from(timeLines!.map((x) => x.toJson())),
    "penaltyPrice": penaltyPrice,
    "penaltyPriceStepTime": penaltyPriceStepTime,
  };
}

class TimeLine {
  final int? timeLineId;
  final String? name;
  final double? price;
  final bool? isActive;
  final String? startTime;
  final String? endTime;
  final double? extraFee;

  TimeLine({
    this.timeLineId,
    this.name,
    this.price,
    this.isActive,
    this.startTime,
    this.endTime,
    this.extraFee,
  });

  factory TimeLine.fromJson(Map<String, dynamic> json) => TimeLine(
    timeLineId: json["timeLineId"],
    name: json["name"],
    price: json["price"]?.toDouble(),
    isActive: json["isActive"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    extraFee: json["extraFee"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "timeLineId": timeLineId,
    "name": name,
    "price": price,
    "isActive": isActive,
    "startTime": startTime,
    "endTime": endTime,
    "extraFee": extraFee,
  };
}

class Traffic {
  final int? trafficId;
  final String? name;

  Traffic({
    this.trafficId,
    this.name,
  });

  factory Traffic.fromJson(Map<String, dynamic> json) => Traffic(
    trafficId: json["trafficId"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "trafficId": trafficId,
    "name": name,
  };
}

class ParkingSpotImage {
  final int? parkingSpotImageId;
  final String? imgPath;

  ParkingSpotImage({
    this.parkingSpotImageId,
    this.imgPath,
  });

  factory ParkingSpotImage.fromJson(Map<String, dynamic> json) => ParkingSpotImage(
    parkingSpotImageId: json["parkingSpotImageId"],
    imgPath: json["imgPath"],
  );

  Map<String, dynamic> toJson() => {
    "parkingSpotImageId": parkingSpotImageId,
    "imgPath": imgPath,
  };
}
