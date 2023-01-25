import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/spend_yearly.dart';
import '../../viewmodel/spend_notifier.dart';

class SamedaySpendGraphAlert extends ConsumerWidget {
  SamedaySpendGraphAlert({super.key, required this.date});

  final DateTime date;

  List<List<Map<String, dynamic>>> samedayGraphData = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeComparisonMap();

    return Container();
  }

  ///
  void makeComparisonMap() {
    //---------------------------------------(1)
    final list = <DateTime>[];

    var flag = 1;
    if (date.year == 2020) {
      flag = (date.month < 6) ? 0 : 1;
    }

    switch (flag) {
      case 0:
        for (var i = 6; i >= 1; i--) {
          list.add(DateTime(date.yyyy.toInt(), i));
        }
        break;
      case 1:
        for (var i = 0; i < 6; i++) {
          list.add(DateTime(date.yyyy.toInt(), date.mm.toInt() - i));
        }
        break;
    }
    //---------------------------------------(1)

    print(list);

    //
    //
    //
    //
    // list.forEach((element) {
    //   final spendMonthDetailState =
    //       _ref.watch(spendMonthDetailProvider(element));
    //
    //   List<Map<String, dynamic>> list2 = [];
    //   var keepYm = '';
    //   var sum = 0;
    //
    //   spendMonthDetailState.list.forEach((element2) {
    //     if (element2.date.yyyymm != keepYm) {
    //       list2 = [];
    //       sum = 0;
    //     }
    //
    //     for (var i = 1; i <= 31; i++) {
    //       sum += (element2.date.day == i) ? element2.spend : 0;
    //       Map<String, dynamic> map = {};
    //       map['day'] = i;
    //       map['price'] = sum;
    //
    //       list2.add(map);
    //     }
    //
    //     keepYm = element2.date.yyyymm;
    //   });
    //
    //   samedayGraphData.add(list2);
    // });
    //
    // print(samedayGraphData);
    //
    //
    //
    //
    //

/*




    List<List<Map<String, dynamic>>> samedayGraphData = [];


*/

    /*
      SpendYearly({
    required this.date,
    required this.spend,
//    required this.item,
  });
    */
  }
}
