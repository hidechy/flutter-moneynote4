import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/walk_record.dart';
import '../../utility/utility.dart';
import 'walk_record_response_state.dart';

////////////////////////////////////////////////

final walkRecordProvider =
    StateNotifierProvider.autoDispose.family<WalkRecordNotifier, WalkRecordResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return WalkRecordNotifier(const WalkRecordResponseState(), client, utility)..getYearlyWalkRecord(date: date);
});

class WalkRecordNotifier extends StateNotifier<WalkRecordResponseState> {
  WalkRecordNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getYearlyWalkRecord({required DateTime date}) async {
    await client.post(path: APIPath.getWalkRecord2, body: {'date': date.yyyymmdd}).then((value) {
      final list = <WalkRecord>[];
      final map = <String, WalkRecord>{};

      // ignore: avoid_dynamic_calls
      for (var i = 0; i < value.length.toString().toInt(); i++) {
        // ignore: avoid_dynamic_calls
        final val = WalkRecord.fromJson(value[i] as Map<String, dynamic>);

        if (date.year == val.date.year) {
          list.add(val);
          map[val.date.yyyymmdd] = val;
        }
      }

      state = state.copyWith(walkRecordList: AsyncValue.data(list), walkRecordMap: AsyncValue.data(map));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
