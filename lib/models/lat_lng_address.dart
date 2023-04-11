// To parse this JSON data, do
//
//     final latLngAddress = latLngAddressFromJson(jsonString);

// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter

import 'dart:convert';

import 'package:moneynote4/extensions/extensions.dart';

LatLngAddress latLngAddressFromJson(String str) =>
    LatLngAddress.fromJson(json.decode(str) as Map<String, dynamic>);

String latLngAddressToJson(LatLngAddress data) => json.encode(data.toJson());

class LatLngAddress {
  LatLngAddress({
    required this.response,
  });

  factory LatLngAddress.fromJson(Map<String, dynamic> json) => LatLngAddress(
        response: Response.fromJson(json['response'] as Map<String, dynamic>),
      );

  Response response;

  Map<String, dynamic> toJson() => {
        'response': response.toJson(),
      };
}

class Response {
  Response({
    required this.location,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        location: List<LocationAddress>.from(json['location']
                .map((x) => LocationAddress.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
      );

  List<LocationAddress> location;

  Map<String, dynamic> toJson() => {
        'location': List<dynamic>.from(location.map((x) => x.toJson())),
      };
}

class LocationAddress {
  LocationAddress({
    required this.city,
    required this.cityKana,
    required this.town,
    required this.townKana,
    required this.x,
    required this.y,
    required this.distance,
    required this.prefecture,
    required this.postal,
  });

  factory LocationAddress.fromJson(Map<String, dynamic> json) =>
      LocationAddress(
        city: json['city'].toString(),
        cityKana: json['city_kana'].toString(),
        town: json['town'].toString(),
        townKana: json['town_kana'].toString(),
        x: json['x'].toString(),
        y: json['y'].toString(),
        distance: json['distance'].toString().toDouble(),
        prefecture: json['prefecture'].toString(),
        postal: json['postal'].toString(),
      );

  String city;
  String cityKana;
  String town;
  String townKana;
  String x;
  String y;
  double distance;
  String prefecture;
  String postal;

  Map<String, dynamic> toJson() => {
        'city': city,
        'city_kana': cityKana,
        'town': town,
        'town_kana': townKana,
        'x': x,
        'y': y,
        'distance': distance,
        'prefecture': prefecture,
        'postal': postal,
      };
}
