import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info_request_state.freezed.dart';

@freezed
class DeviceInfoRequestState with _$DeviceInfoRequestState {
  const factory DeviceInfoRequestState({
    @Default('') String name,
    @Default('') String systemName,
    @Default('') String model,
  }) = _DeviceInfoRequestState;
}
