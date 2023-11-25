import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/temple_photos.dart';

part 'temple_photos_response_state.freezed.dart';

@freezed
class TemplePhotosResponseState with _$TemplePhotosResponseState {
  const factory TemplePhotosResponseState({
    @Default({}) Map<String, List<TemplePhoto>> templePhotoDateMap,
    @Default({}) Map<String, List<TemplePhoto>> templePhotoTempleMap,

    //

    @Default(AsyncValue<List<TemplePhoto>>.loading()) AsyncValue<List<TemplePhoto>> templePhotoList,
  }) = _TemplePhotosResponseState;
}
