import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'device_info_request_state.dart';
import 'device_info_response_state.dart';

////////////////////////////////////////////////

final deviceInfoProvider = StateNotifierProvider.autoDispose<DeviceInfoNotifier,
    DeviceInfoResponseState>((ref) {
  return DeviceInfoNotifier(const DeviceInfoResponseState());
});

class DeviceInfoNotifier extends StateNotifier<DeviceInfoResponseState> {
  DeviceInfoNotifier(super.state);

  Future<void> setDeviceInfo({required DeviceInfoRequestState param}) async {
    state = DeviceInfoResponseState(
      name: param.name,
      systemName: param.systemName,
      model: param.model,
    );
  }
}

////////////////////////////////////////////
