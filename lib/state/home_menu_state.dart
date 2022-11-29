import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_menu_state.freezed.dart';

@freezed
class HomeMenuState with _$HomeMenuState {
  const factory HomeMenuState({
    required String menuFlag,
    required String menuName,
  }) = _HomeMenuState;
}
