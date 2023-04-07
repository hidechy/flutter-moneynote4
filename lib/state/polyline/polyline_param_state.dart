import 'package:freezed_annotation/freezed_annotation.dart';

part 'polyline_param_state.freezed.dart';

@freezed
class PolylineParamState with _$PolylineParamState {
  const factory PolylineParamState({
    @Default('') String origin,
    @Default('') String destination,
  }) = _PolylineParamState;
}
