import 'package:freezed_annotation/freezed_annotation.dart';

part 'lat_lng_address_param_state.freezed.dart';

@freezed
class LatLngAddressParamState with _$LatLngAddressParamState {
  const factory LatLngAddressParamState({
    @Default('') String latitude,
    @Default('') String longitude,
  }) = _LatLngAddressParamState;
}
