// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/temple_photos.dart';
import '../../utility/utility.dart';
import 'temple_photos_response_state.dart';

////////////////////////////////////////////////

final templePhotosProvider = StateNotifierProvider.autoDispose<TemplePhotosNotifier, TemplePhotosResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return TemplePhotosNotifier(const TemplePhotosResponseState(), client, utility)..getTemplePhoto();
});

class TemplePhotosNotifier extends StateNotifier<TemplePhotosResponseState> {
  TemplePhotosNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getTemplePhoto() async {
    await client.post(path: APIPath.getTempleDatePhoto).then((value) {
      final list = <TemplePhoto>[];

      final dateMap = <String, List<TemplePhoto>>{};
      final templeMap = <String, List<TemplePhoto>>{};

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final val = TemplePhoto.fromJson(value['data'][i] as Map<String, dynamic>);

        list.add(val);

        dateMap[val.date.yyyymmdd] = [];
        templeMap[val.temple] = [];
      }

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final val = TemplePhoto.fromJson(value['data'][i] as Map<String, dynamic>);

        dateMap[val.date.yyyymmdd]?.add(val);
        templeMap[val.temple]?.add(val);
      }

      state = state.copyWith(
        templePhotoList: AsyncValue.data(list),
        templePhotoDateMap: dateMap,
        templePhotoTempleMap: templeMap,
      );
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
