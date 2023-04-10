import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_transit_param_state.freezed.dart';

@freezed
class RouteTransitParamState with _$RouteTransitParamState {
  const factory RouteTransitParamState({
    @Default('') String start,
    @Default('') String goal,
    @Default('') String startTime,
  }) = _RouteTransitParamState;
}
