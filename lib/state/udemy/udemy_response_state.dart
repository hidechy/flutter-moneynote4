// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/udemy.dart';

part 'udemy_response_state.freezed.dart';

@freezed
class UdemyResponseState with _$UdemyResponseState {
  const factory UdemyResponseState({
    @Default(AsyncValue<List<Udemy>>.loading()) AsyncValue<List<Udemy>> udemyList,
  }) = _UdemyResponseState;
}
