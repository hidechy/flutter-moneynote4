// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/time_location.dart';

part 'time_location_response_state.freezed.dart';

@freezed
class TimeLocationResponseState with _$TimeLocationResponseState {
  const factory TimeLocationResponseState({
    @Default(AsyncValue<List<TimeLocation>>.loading()) AsyncValue<List<TimeLocation>> timeLocationList,
  }) = _TimeLocationResponseState;
}
