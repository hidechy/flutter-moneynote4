import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_marker_state.freezed.dart';

@freezed
class MapMarkerState with _$MapMarkerState {
  const factory MapMarkerState({
    @Default({}) Set<Marker> markers,
    @Default('') String selectTime,
  }) = _MapMarkerState;
}
