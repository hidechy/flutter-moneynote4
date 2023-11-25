import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/train.dart';

part 'train_response_state.freezed.dart';

@freezed
class TrainResponseState with _$TrainResponseState {
  const factory TrainResponseState({
    @Default({}) Map<String, Train> trainMap,
    @Default(AsyncValue<List<Train>>.loading()) AsyncValue<List<Train>> trainList,
  }) = _TrainResponseState;
}
