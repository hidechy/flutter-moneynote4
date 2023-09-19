import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/temple_latlng.dart';

part 'temple_latlng_response_state.freezed.dart';

@freezed
class TempleLatLngResponseState with _$TempleLatLngResponseState {
  const factory TempleLatLngResponseState({
    @Default([]) List<TempleLatLng> templeLatLngList,
    @Default({}) Map<String, TempleLatLng> templeLatLngMap,
  }) = _TempleLatLngResponseState;
}
