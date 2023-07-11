// To parse this JSON data, do
//
//     final locationSuggestion = locationSuggestionFromJson(jsonString);

import 'dart:convert';

LocationSuggestion locationSuggestionFromJson(String str) => LocationSuggestion.fromJson(json.decode(str));

String locationSuggestionToJson(LocationSuggestion data) => json.encode(data.toJson());

class LocationSuggestion {
  final int? placeId;
  final String? licence;
  final String? osmType;
  final int? osmId;
  final List<String>? boundingbox;
  final String? lat;
  final String? lon;
  final String? displayName;
  final String? locationSuggestionClass;
  final String? type;
  final double? importance;

  LocationSuggestion({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.boundingbox,
    this.lat,
    this.lon,
    this.displayName,
    this.locationSuggestionClass,
    this.type,
    this.importance,
  });

  factory LocationSuggestion.fromJson(Map<String, dynamic> json) => LocationSuggestion(
    placeId: json["place_id"],
    licence: json["licence"],
    osmType: json["osm_type"],
    osmId: json["osm_id"],
    boundingbox: json["boundingbox"] == null ? [] : List<String>.from(json["boundingbox"]!.map((x) => x)),
    lat: json["lat"],
    lon: json["lon"],
    displayName: json["display_name"],
    locationSuggestionClass: json["class"],
    type: json["type"],
    importance: json["importance"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "place_id": placeId,
    "licence": licence,
    "osm_type": osmType,
    "osm_id": osmId,
    "boundingbox": boundingbox == null ? [] : List<dynamic>.from(boundingbox!.map((x) => x)),
    "lat": lat,
    "lon": lon,
    "display_name": displayName,
    "class": locationSuggestionClass,
    "type": type,
    "importance": importance,
  };
}
