import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/station.dart';

part 'station_response_state.freezed.dart';

@freezed
class StationResponseState with _$StationResponseState {
  const factory StationResponseState({
    @Default([]) List<Station> stationList,
    @Default({}) Map<String, Station> stationMap,
  }) = _StationResponseState;
}
