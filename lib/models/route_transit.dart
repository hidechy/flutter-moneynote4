// To parse this JSON data, do
//
//     final routeTransit = routeTransitFromJson(jsonString);

// ignore_for_file: inference_failure_on_untyped_parameter, avoid_dynamic_calls

import 'dart:convert';

import '../extensions/extensions.dart';

RouteTransit routeTransitFromJson(String str) =>
    RouteTransit.fromJson(json.decode(str) as Map<String, dynamic>);

String routeTransitToJson(RouteTransit data) => json.encode(data.toJson());

///
class RouteTransit {
  RouteTransit({required this.items, required this.unit});

  factory RouteTransit.fromJson(Map<String, dynamic> json) => RouteTransit(
        items: List<Item>.from(
          json['items'].map(
            (x) => Item.fromJson(x as Map<String, dynamic>),
          ) as Iterable<dynamic>,
        ),
        unit: Unit.fromJson(json['unit'] as Map<String, dynamic>),
      );

  List<Item> items;
  Unit unit;

  Map<String, dynamic> toJson() => {
        'items': List<dynamic>.from(items.map((x) => x.toJson())),
        'unit': unit.toJson(),
      };
}

///
class Item {
  Item({required this.marker, required this.path});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        marker: List<dynamic>.from(
          json['marker'].map((x) => x) as Iterable<dynamic>,
        ),
        path: List<Path>.from(
          json['path'].map(
            (x) => Path.fromJson(x as Map<String, dynamic>),
          ) as Iterable<dynamic>,
        ),
      );

  List<dynamic> marker;
  List<Path> path;

  Map<String, dynamic> toJson() => {
        'marker': List<dynamic>.from(marker.map((x) => x)),
        'path': List<dynamic>.from(path.map((x) => x.toJson())),
      };
}

///
class Path {
  Path({
    required this.coords,
    required this.width,
    required this.color,
    required this.opacity,
  });

  factory Path.fromJson(Map<String, dynamic> json) => Path(
        coords: List<List<double>>.from(
          json['coords'].map(
            (x) => List<double>.from(
              x.map((x) => x?.toDouble()) as Iterable<dynamic>,
            ),
          ) as Iterable<dynamic>,
        ),
        width: json['width'].toString().toInt(),
        color: json['color'].toString(),
        opacity: json['opacity'].toString().toDouble(),
      );

  List<List<double>> coords;
  int width;
  String color;
  double opacity;

  Map<String, dynamic> toJson() => {
        'coords': List<dynamic>.from(
          coords.map(
            (x) => List<dynamic>.from(x.map((x) => x)),
          ),
        ),
        'width': width,
        'color': color,
        'opacity': opacity,
      };
}

///
class Unit {
  Unit({required this.datum, required this.coordUnit});

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        datum: json['datum'].toString(),
        coordUnit: json['coord_unit'].toString(),
      );

  String datum;
  String coordUnit;

  Map<String, dynamic> toJson() => {
        'datum': datum,
        'coord_unit': coordUnit,
      };
}
