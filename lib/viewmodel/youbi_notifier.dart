import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moneynote4/extensions/extensions.dart';

import '../models/youbi.dart';

////////////////////////////////////////////////

final youbiProvider = StateNotifierProvider.autoDispose
    .family<YoubiNotifier, List<Youbi>, DateTime>((ref, date) {
  return YoubiNotifier([])..getYoubi(date: date);
});

class YoubiNotifier extends StateNotifier<List<Youbi>> {
  YoubiNotifier(super.state);

  Future<void> getYoubi({required DateTime date}) async {
    final endDay = DateTime(date.yyyy.toInt(), date.mm.toInt() - 1, 0);
    final exEndDay = endDay.toString().split(' ')[0].split('-');

    final list = <Youbi>[];
    for (var i = 1; i <= int.parse(exEndDay[2]); i++) {
      final youbiDate = DateTime(date.yyyy.toInt(), date.mm.toInt(), i);
      final youbi = DateFormat('EEEE').format(youbiDate);

      switch (youbi) {
        case 'Sunday':
          list.add(
            Youbi(
              date: youbiDate.toString().split(' ')[0],
              youbi: '日',
              youbiNum: 0,
            ),
          );
          break;
        case 'Monday':
          list.add(
            Youbi(
              date: youbiDate.toString().split(' ')[0],
              youbi: '月',
              youbiNum: 1,
            ),
          );
          break;
        case 'Tuesday':
          list.add(
            Youbi(
              date: youbiDate.toString().split(' ')[0],
              youbi: '火',
              youbiNum: 2,
            ),
          );
          break;
        case 'Wednesday':
          list.add(
            Youbi(
              date: youbiDate.toString().split(' ')[0],
              youbi: '水',
              youbiNum: 3,
            ),
          );
          break;
        case 'Thursday':
          list.add(
            Youbi(
              date: youbiDate.toString().split(' ')[0],
              youbi: '木',
              youbiNum: 4,
            ),
          );
          break;
        case 'Friday':
          list.add(
            Youbi(
              date: youbiDate.toString().split(' ')[0],
              youbi: '金',
              youbiNum: 5,
            ),
          );
          break;
        case 'Saturday':
          list.add(
            Youbi(
              date: youbiDate.toString().split(' ')[0],
              youbi: '土',
              youbiNum: 6,
            ),
          );
          break;
      }
    }

    state = list;
  }
}

////////////////////////////////////////////////
