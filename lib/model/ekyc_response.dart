import 'dart:convert';

EkycResponse ekycResponseFromJson(String str) => EkycResponse.fromJson(json.decode(str));

String ekycResponseToJson(EkycResponse data) => json.encode(data.toJson());

class EkycResponse {
  final String? id;
  final String? documentType;
  final List<String>? linkedFileIds;
  final RecognizedData? recognizedData;
  final int? resultCode;
  final String? message;

  EkycResponse({
    this.id,
    this.documentType,
    this.linkedFileIds,
    this.recognizedData,
    this.resultCode,
    this.message,
  });

  factory EkycResponse.fromJson(Map<String, dynamic> json) => EkycResponse(
    id: json["id"],
    documentType: json["document_type"],
    linkedFileIds: json["linked_file_ids"] == null ? [] : List<String>.from(json["linked_file_ids"]!.map((x) => x)),
    recognizedData: json["recognized_data"] == null ? null : RecognizedData.fromJson(json["recognized_data"]),
    resultCode: json["result_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "document_type": documentType,
    "linked_file_ids": linkedFileIds == null ? [] : List<dynamic>.from(linkedFileIds!.map((x) => x)),
    "recognized_data": recognizedData?.toJson(),
    "result_code": resultCode,
    "message": message,
  };
}

class RecognizedData {
  final String? address;
  final String? addressconf;
  final String? birthday;
  final String? birthdayconf;
  final String? characteristics;
  final String? characteristicsConf;
  final String? country;
  final String? countryconf;
  final String? document;
  final String? documentconf;
  final String? expiry;
  final String? expiryconf;
  final String? hometown;
  final String? hometownconf;
  final String? id;
  final String? idType;
  final String? idconf;
  final String? issueBy;
  final String? issueByConf;
  final String? issueDate;
  final String? issueDateConf;
  final String? name;
  final String? nameconf;
  final String? national;
  final String? nationalconf;
  final String? sex;
  final String? sexconf;
  final String? serverTag;
  final String? reliability;
  final List<int>? warningCode;
  final List<String>? warning;

  RecognizedData({
    this.address,
    this.addressconf,
    this.birthday,
    this.birthdayconf,
    this.characteristics,
    this.characteristicsConf,
    this.country,
    this.countryconf,
    this.document,
    this.documentconf,
    this.expiry,
    this.expiryconf,
    this.hometown,
    this.hometownconf,
    this.id,
    this.idType,
    this.idconf,
    this.issueBy,
    this.issueByConf,
    this.issueDate,
    this.issueDateConf,
    this.name,
    this.nameconf,
    this.national,
    this.nationalconf,
    this.sex,
    this.sexconf,
    this.serverTag,
    this.reliability,
    this.warningCode,
    this.warning,
  });

  factory RecognizedData.fromJson(Map<String, dynamic> json) => RecognizedData(
    address: json["address"],
    addressconf: json["addressconf"],
    birthday: json["birthday"],
    birthdayconf: json["birthdayconf"],
    characteristics: json["characteristics"],
    characteristicsConf: json["characteristics_conf"],
    country: json["country"],
    countryconf: json["countryconf"],
    document: json["document"],
    documentconf: json["documentconf"],
    expiry: json["expiry"],
    expiryconf: json["expiryconf"],
    hometown: json["hometown"],
    hometownconf: json["hometownconf"],
    id: json["id"],
    idType: json["id_type"],
    idconf: json["idconf"],
    issueBy: json["issue_by"],
    issueByConf: json["issue_by_conf"],
    issueDate: json["issue_date"],
    issueDateConf: json["issue_date_conf"],
    name: json["name"],
    nameconf: json["nameconf"],
    national: json["national"],
    nationalconf: json["nationalconf"],
    sex: json["sex"],
    sexconf: json["sexconf"],
    serverTag: json["server_tag"],
    reliability: json["reliability"],
    warningCode: json["warning_code"] == null ? [] : List<int>.from(json["warning_code"]!.map((x) => x)),
    warning: json["warning"] == null ? [] : List<String>.from(json["warning"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "addressconf": addressconf,
    "birthday": birthday,
    "birthdayconf": birthdayconf,
    "characteristics": characteristics,
    "characteristics_conf": characteristicsConf,
    "country": country,
    "countryconf": countryconf,
    "document": document,
    "documentconf": documentconf,
    "expiry": expiry,
    "expiryconf": expiryconf,
    "hometown": hometown,
    "hometownconf": hometownconf,
    "id": id,
    "id_type": idType,
    "idconf": idconf,
    "issue_by": issueBy,
    "issue_by_conf": issueByConf,
    "issue_date": issueDate,
    "issue_date_conf": issueDateConf,
    "name": name,
    "nameconf": nameconf,
    "national": national,
    "nationalconf": nationalconf,
    "sex": sex,
    "sexconf": sexconf,
    "server_tag": serverTag,
    "reliability": reliability,
    "warning_code": warningCode == null ? [] : List<dynamic>.from(warningCode!.map((x) => x)),
    "warning": warning == null ? [] : List<dynamic>.from(warning!.map((x) => x)),
  };
}
