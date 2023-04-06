import 'package:freezed_annotation/freezed_annotation.dart';

part 'polyline_param_state.freezed.dart';

@freezed
class PolylineParamState with _$PolylineParamState {
  const factory PolylineParamState({
    required String origin,
    required String destination,
  }) = _PolylineParamState;
}
