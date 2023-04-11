import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_transit_result_state.freezed.dart';

@freezed
class RouteTransitResultState with _$RouteTransitResultState {
  const factory RouteTransitResultState({
    @Default([]) list,
  }) = _RouteTransitResultState;
}

@freezed
class RouteTransitResultItemState with _$RouteTransitResultItemState {
  const factory RouteTransitResultItemState({
    @Default('') String latitude,
    @Default('') String longitude,
  }) = _RouteTransitResultItemState;
}
