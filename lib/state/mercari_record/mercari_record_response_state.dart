// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/mercari_record.dart';

part 'mercari_record_response_state.freezed.dart';

@freezed
class MercariRecordResponseState with _$MercariRecordResponseState {
  const factory MercariRecordResponseState({
    @Default(AsyncValue<List<MercariRecord>>.loading()) AsyncValue<List<MercariRecord>> mercariRecordList,
  }) = _MercariRecordResponseState;
}
