// To parse this JSON data, do
//
//     final transactionResponse = transactionResponseFromJson(jsonString);

import 'dart:convert';

TransactionResponse transactionResponseFromJson(String str) => TransactionResponse.fromJson(json.decode(str));

String transactionResponseToJson(TransactionResponse data) => json.encode(data.toJson());

class TransactionResponse {
  final List<Datum>? data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final int? count;

  TransactionResponse({
    this.data,
    this.success,
    this.message,
    this.statusCode,
    this.count,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) => TransactionResponse(
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
  final int? transactionId;
  final double? price;
  final String? status;
  final String? paymentMethod;
  final String? description;
  final DateTime? createdDate;

  Datum({
    this.transactionId,
    this.price,
    this.status,
    this.paymentMethod,
    this.description,
    this.createdDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    transactionId: json["transactionId"],
    price: json["price"],
    status: json["status"],
    paymentMethod: json["paymentMethod"],
    description: json["description"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "price": price,
    "status": status,
    "paymentMethod": paymentMethod,
    "description": description,
    "createdDate": createdDate?.toIso8601String(),
  };
}
