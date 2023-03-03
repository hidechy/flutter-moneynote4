import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info_response_state.freezed.dart';

@freezed
class DeviceInfoResponseState with _$DeviceInfoResponseState {
  const factory DeviceInfoResponseState({
    @Default('') String name,
    @Default('') String systemName,
    @Default('') String model,
  }) = _DeviceInfoResponseState;
}
