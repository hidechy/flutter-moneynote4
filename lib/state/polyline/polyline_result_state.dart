import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';

part 'polyline_result_state.freezed.dart';

@freezed
class PolylineResultState with _$PolylineResultState {
  const factory PolylineResultState({
    required LatLngBounds bounds,
    required String distance,
    required String duration,
    required List<PointLatLng> polylinePoints,
  }) = _PolylineResultState;
}
