import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/temple_latlng.dart';

part 'temple_latlng_response_state.freezed.dart';

@freezed
class TempleLatLngResponseState with _$TempleLatLngResponseState {
  const factory TempleLatLngResponseState({
    @Default({}) Map<String, TempleLatLng> templeLatLngMap,

    //

    @Default(AsyncValue<List<TempleLatLng>>.loading()) AsyncValue<List<TempleLatLng>> templeLatLngList,
  }) = _TempleLatLngResponseState;
}
