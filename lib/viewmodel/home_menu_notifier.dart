import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/home_menu_state.dart';

////////////////////////////////////////////////

final homeMenuProvider =
    StateNotifierProvider.autoDispose<HomeMenuNotifier, HomeMenuState>((ref) {
  return HomeMenuNotifier(
    const HomeMenuState(
      menuFlag: '',
      menuName: '',
    ),
  );
});

class HomeMenuNotifier extends StateNotifier<HomeMenuState> {
  HomeMenuNotifier(super.state);

  Future<void> setHomeMenu(
      {required String menuFlag, required String menuName}) async {
    state = state.copyWith(menuFlag: menuFlag, menuName: menuName);
  }
}

////////////////////////////////////////////
