// To parse this JSON data, do
//
//     final balanceResponse = balanceResponseFromJson(jsonString);

import 'dart:convert';

BalanceResponse balanceResponseFromJson(String str) => BalanceResponse.fromJson(json.decode(str));

String balanceResponseToJson(BalanceResponse data) => json.encode(data.toJson());

class BalanceResponse {
  final Data? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  BalanceResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory BalanceResponse.fromJson(Map<String, dynamic> json) => BalanceResponse(
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
  final int? walletId;
  final double? balance;
  final double? debt;

  Data({
    this.walletId,
    this.balance,
    this.debt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    walletId: json["walletId"],
    balance: json["balance"],
    debt: json["debt"],
  );

  Map<String, dynamic> toJson() => {
    "walletId": walletId,
    "balance": balance,
    "debt": debt,
  };
}
