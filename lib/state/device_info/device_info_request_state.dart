import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info_request_state.freezed.dart';

@freezed
class DeviceInfoRequestState with _$DeviceInfoRequestState {
  const factory DeviceInfoRequestState({
    required String name,
    required String systemName,
    required String model,
  }) = _DeviceInfoRequestState;
}
