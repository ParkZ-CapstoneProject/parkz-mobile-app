// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
  final Data? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  ProfileResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
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
  final int? userId;
  final String? name;
  final String? phone;
  final String? avatar;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? idCardNo;
  final DateTime? idCardDate;
  final String? idCardIssuedBy;
  final String? address;

  Data({
    this.userId,
    this.name,
    this.phone,
    this.avatar,
    this.dateOfBirth,
    this.gender,
    this.idCardNo,
    this.idCardDate,
    this.idCardIssuedBy,
    this.address,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["userId"],
    name: json["name"],
    phone: json["phone"],
    avatar: json["avatar"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    gender: json["gender"],
    idCardNo: json["idCardNo"],
    idCardDate: json["idCardDate"] == null ? null : DateTime.parse(json["idCardDate"]),
    idCardIssuedBy: json["idCardIssuedBy"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "phone": phone,
    "avatar": avatar,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "gender": gender,
    "idCardNo": idCardNo,
    "idCardDate": idCardDate?.toIso8601String(),
    "idCardIssuedBy": idCardIssuedBy,
    "address": address,
  };
}
