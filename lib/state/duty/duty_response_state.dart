// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/duty.dart';

part 'duty_response_state.freezed.dart';

@freezed
class DutyResponseState with _$DutyResponseState {
  const factory DutyResponseState({
    @Default(AsyncValue<List<Duty>>.loading()) AsyncValue<List<Duty>> dutyList,
  }) = _DutyResponseState;
}
