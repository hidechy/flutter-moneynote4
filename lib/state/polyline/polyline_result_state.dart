import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'polyline_result_state.freezed.dart';

@freezed
class PolylineResultState with _$PolylineResultState {
  const factory PolylineResultState({
    LatLngBounds? bounds,
    @Default('') String distance,
    @Default('') String duration,
    @Default([]) List<PointLatLng> polylinePoints,
    @Default(0) southwestLat,
    @Default(0) southwestLng,
    @Default(0) northeastLat,
    @Default(0) northeastLng,
  }) = _PolylineResultState;
}
