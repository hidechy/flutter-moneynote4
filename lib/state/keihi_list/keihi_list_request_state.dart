// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'keihi_list_request_state.freezed.dart';

@freezed
class KeihiListRequestState with _$KeihiListRequestState {
  const factory KeihiListRequestState({
    DateTime? selectDate,
    @Default('') String selectOrder,
  }) = _KeihiListRequestState;
}
