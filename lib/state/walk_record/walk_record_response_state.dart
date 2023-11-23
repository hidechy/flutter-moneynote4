// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/walk_record.dart';

part 'walk_record_response_state.freezed.dart';

@freezed
class WalkRecordResponseState with _$WalkRecordResponseState {
  const factory WalkRecordResponseState({
    @Default(AsyncValue<List<WalkRecord>>.loading()) AsyncValue<List<WalkRecord>> walkRecordList,
    @Default(AsyncValue<Map<String, WalkRecord>>.loading()) AsyncValue<Map<String, WalkRecord>> walkRecordMap,
  }) = _WalkRecordResponseState;
}
