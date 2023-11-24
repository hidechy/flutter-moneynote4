// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/wells.dart';

part 'wells_response_state.freezed.dart';

@freezed
class WellsResponseState with _$WellsResponseState {
  const factory WellsResponseState({
    @Default(AsyncValue<List<Wells>>.loading()) AsyncValue<List<Wells>> wellsList,
  }) = _WellsResponseState;
}
