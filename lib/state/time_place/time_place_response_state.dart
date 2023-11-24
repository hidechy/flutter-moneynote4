// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/spend_timeplace.dart';

part 'time_place_response_state.freezed.dart';

@freezed
class TimePlaceResponseState with _$TimePlaceResponseState {
  const factory TimePlaceResponseState({
    @Default(AsyncValue<List<SpendTimeplace>>.loading()) AsyncValue<List<SpendTimeplace>> timePlaceList,
  }) = _TimePlaceResponseState;
}
