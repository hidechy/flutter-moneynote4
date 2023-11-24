// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/home_fix.dart';

part 'home_fix_response_state.freezed.dart';

@freezed
class HomeFixResponseState with _$HomeFixResponseState {
  const factory HomeFixResponseState({
    @Default(AsyncValue<List<HomeFix>>.loading()) AsyncValue<List<HomeFix>> homeFixList,
  }) = _HomeFixResponseState;
}
