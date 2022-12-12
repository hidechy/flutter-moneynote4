import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info_response_state.freezed.dart';

@freezed
class DeviceInfoResponseState with _$DeviceInfoResponseState {
  const factory DeviceInfoResponseState({
    required String name,
    required String systemName,
    required String model,
  }) = _DeviceInfoResponseState;
}
