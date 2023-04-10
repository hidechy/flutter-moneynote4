import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_transit_result_state.freezed.dart';

@freezed
class RouteTransitState with _$RouteTransitState {
  const factory RouteTransitState({
    @Default([]) list,
  }) = _RouteTransitState;
}

@freezed
class RouteTransitResultItemState with _$RouteTransitResultItemState {
  const factory RouteTransitResultItemState({
    @Default('') String latitude,
    @Default('') String longitude,
  }) = _RouteTransitResultItemState;
}
