// To parse this JSON data, do
//
//     final bookingDetailResponse = bookingDetailResponseFromJson(jsonString);

import 'dart:convert';

BookingDetailResponse bookingDetailResponseFromJson(String str) => BookingDetailResponse.fromJson(json.decode(str));

String bookingDetailResponseToJson(BookingDetailResponse data) => json.encode(data.toJson());

class BookingDetailResponse {
  final DetailBooking? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  BookingDetailResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory BookingDetailResponse.fromJson(Map<String, dynamic> json) => BookingDetailResponse(
    data: json["data"] == null ? null : DetailBooking.fromJson(json["data"]),
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

class DetailBooking {
  final BookingDetails? bookingDetails;
  final User? user;
  final VehicleInfor? vehicleInfor;
  final ParkingWithBookingDetailDto? parkingWithBookingDetailDto;
  final ParkingSlotWithBookingDetailDto? parkingSlotWithBookingDetailDto;
  final FloorWithBookingDetailDto? floorWithBookingDetailDto;
  final List<TransactionWithBookingDetailDto>? transactionWithBookingDetailDtos;

  DetailBooking({
    this.bookingDetails,
    this.user,
    this.vehicleInfor,
    this.parkingWithBookingDetailDto,
    this.parkingSlotWithBookingDetailDto,
    this.floorWithBookingDetailDto,
    this.transactionWithBookingDetailDtos,
  });

  factory DetailBooking.fromJson(Map<String, dynamic> json) => DetailBooking(
    bookingDetails: json["bookingDetails"] == null ? null : BookingDetails.fromJson(json["bookingDetails"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    vehicleInfor: json["vehicleInfor"] == null ? null : VehicleInfor.fromJson(json["vehicleInfor"]),
    parkingWithBookingDetailDto: json["parkingWithBookingDetailDto"] == null ? null : ParkingWithBookingDetailDto.fromJson(json["parkingWithBookingDetailDto"]),
    parkingSlotWithBookingDetailDto: json["parkingSlotWithBookingDetailDto"] == null ? null : ParkingSlotWithBookingDetailDto.fromJson(json["parkingSlotWithBookingDetailDto"]),
    floorWithBookingDetailDto: json["floorWithBookingDetailDto"] == null ? null : FloorWithBookingDetailDto.fromJson(json["floorWithBookingDetailDto"]),
    transactionWithBookingDetailDtos: json["transactionWithBookingDetailDtos"] == null ? [] : List<TransactionWithBookingDetailDto>.from(json["transactionWithBookingDetailDtos"]!.map((x) => TransactionWithBookingDetailDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bookingDetails": bookingDetails?.toJson(),
    "user": user?.toJson(),
    "vehicleInfor": vehicleInfor?.toJson(),
    "parkingWithBookingDetailDto": parkingWithBookingDetailDto?.toJson(),
    "parkingSlotWithBookingDetailDto": parkingSlotWithBookingDetailDto?.toJson(),
    "floorWithBookingDetailDto": floorWithBookingDetailDto?.toJson(),
    "transactionWithBookingDetailDtos": transactionWithBookingDetailDtos == null ? [] : List<dynamic>.from(transactionWithBookingDetailDtos!.map((x) => x.toJson())),
  };
}

class BookingDetails {
  final int? bookingId;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? checkinTime;
  final DateTime? checkoutTime;
  final String? status;
  final String? guestName;
  final String? guestPhone;
  final double? totalPrice;
  final String? qrImage;
  final bool? isRating;

  BookingDetails({
    this.bookingId,
    this.startTime,
    this.endTime,
    this.checkinTime,
    this.checkoutTime,
    this.status,
    this.guestName,
    this.guestPhone,
    this.totalPrice,
    this.qrImage,
    this.isRating,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
    bookingId: json["bookingId"],
    startTime: json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
    endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
    checkinTime: json["checkinTime"] == null ? null : DateTime.parse(json["checkinTime"]),
    checkoutTime: json["checkoutTime"] == null ? null : DateTime.parse(json["checkoutTime"]),
    status: json["status"],
    guestName: json["guestName"],
    guestPhone: json["guestPhone"],
    totalPrice: json["totalPrice"]?.toDouble(),
    qrImage: json["qrImage"],
    isRating: json["isRating"],
  );

  Map<String, dynamic> toJson() => {
    "bookingId": bookingId,
    "startTime": startTime?.toIso8601String(),
    "endTime": endTime?.toIso8601String(),
    "checkinTime": checkinTime?.toIso8601String(),
    "checkoutTime": checkoutTime?.toIso8601String(),
    "status": status,
    "guestName": guestName,
    "guestPhone": guestPhone,
    "totalPrice": totalPrice,
    "qrImage": qrImage,
    "isRating": isRating,
  };
}

class FloorWithBookingDetailDto {
  final int? floorId;
  final String? floorName;

  FloorWithBookingDetailDto({
    this.floorId,
    this.floorName,
  });

  factory FloorWithBookingDetailDto.fromJson(Map<String, dynamic> json) => FloorWithBookingDetailDto(
    floorId: json["floorId"],
    floorName: json["floorName"],
  );

  Map<String, dynamic> toJson() => {
    "floorId": floorId,
    "floorName": floorName,
  };
}

class ParkingSlotWithBookingDetailDto {
  final int? parkingSlotId;
  final String? name;

  ParkingSlotWithBookingDetailDto({
    this.parkingSlotId,
    this.name,
  });

  factory ParkingSlotWithBookingDetailDto.fromJson(Map<String, dynamic> json) => ParkingSlotWithBookingDetailDto(
    parkingSlotId: json["parkingSlotId"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "parkingSlotId": parkingSlotId,
    "name": name,
  };
}

class ParkingWithBookingDetailDto {
  final int? parkingId;
  final String? name;
  final String? address;
  final double? latitude;
  final double? longitude;

  ParkingWithBookingDetailDto({
    this.parkingId,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
  });

  factory ParkingWithBookingDetailDto.fromJson(Map<String, dynamic> json) => ParkingWithBookingDetailDto(
    parkingId: json["parkingId"],
    name: json["name"],
    address: json["address"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "parkingId": parkingId,
    "name": name,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
  };
}

class TransactionWithBookingDetailDto {
  final int? transactionId;
  final double? price;
  final String? status;
  final String? paymentMethod;

  TransactionWithBookingDetailDto({
    this.transactionId,
    this.price,
    this.status,
    this.paymentMethod,
  });

  factory TransactionWithBookingDetailDto.fromJson(Map<String, dynamic> json) => TransactionWithBookingDetailDto(
    transactionId: json["transactionId"],
    price: json["price"]?.toDouble(),
    status: json["status"],
    paymentMethod: json["paymentMethod"],
  );

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "price": price,
    "status": status,
    "paymentMethod": paymentMethod,
  };
}

class User {
  final int? userId;
  final String? name;
  final String? phone;

  User({
    this.userId,
    this.name,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["userId"],
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "phone": phone,
  };
}

class VehicleInfor {
  final int? vehicleInforId;
  final String? licensePlate;
  final String? vehicleName;
  final String? color;

  VehicleInfor({
    this.vehicleInforId,
    this.licensePlate,
    this.vehicleName,
    this.color,
  });

  factory VehicleInfor.fromJson(Map<String, dynamic> json) => VehicleInfor(
    vehicleInforId: json["vehicleInforId"],
    licensePlate: json["licensePlate"],
    vehicleName: json["vehicleName"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "vehicleInforId": vehicleInforId,
    "licensePlate": licensePlate,
    "vehicleName": vehicleName,
    "color": color,
  };
}
