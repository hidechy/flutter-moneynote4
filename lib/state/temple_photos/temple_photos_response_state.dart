import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/temple_photos.dart';

part 'temple_photos_response_state.freezed.dart';

@freezed
class TemplePhotosResponseState with _$TemplePhotosResponseState {
  const factory TemplePhotosResponseState({
    @Default([]) List<TemplePhoto> templePhotoList,
    @Default({}) Map<String, TemplePhoto> templePhotoDateMap,
    @Default({}) Map<String, TemplePhoto> templePhotoTempleMap,
  }) = _TemplePhotosResponseState;
}
