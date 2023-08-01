import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/train.dart';

part 'train_response_state.freezed.dart';

@freezed
class TrainResponseState with _$TrainResponseState {
  const factory TrainResponseState({
    @Default([]) List<Train> trainList,
    @Default({}) Map<String, Train> trainMap,
  }) = _TrainResponseState;
}
