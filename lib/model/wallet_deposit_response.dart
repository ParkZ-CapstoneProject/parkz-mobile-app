// To parse this JSON data, do
//
//     final walletDepositResponse = walletDepositResponseFromJson(jsonString);

import 'dart:convert';

WalletDepositResponse walletDepositResponseFromJson(String str) => WalletDepositResponse.fromJson(json.decode(str));

String walletDepositResponseToJson(WalletDepositResponse data) => json.encode(data.toJson());

class WalletDepositResponse {
  final String? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  WalletDepositResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory WalletDepositResponse.fromJson(Map<String, dynamic> json) => WalletDepositResponse(
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
