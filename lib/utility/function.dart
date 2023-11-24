import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../models/credit_spend_monthly.dart';
import '../state/credit/credit_notifier.dart';

Map<String, List<CreditSpendMonthly>> getNext2MonthCreditSpend({required WidgetRef ref, required DateTime creDate}) {
  final threeMonthAfter = DateTime(creDate.year, creDate.month + 3);

  final diff = threeMonthAfter.difference(creDate).inDays;

  final creditSpendMap = <String, List<CreditSpendMonthly>>{};

  for (var i = 0; i <= diff; i++) {
    final genDate = creDate.add(Duration(days: i));

    creditSpendMap[genDate.yyyymmdd] = [];
  }

  for (var i = 0; i <= diff; i++) {
    final genDate = creDate.add(Duration(days: i));

    if (genDate.day == 1) {
      // ref
      //     .watch(creditSpendMonthlyProvider(genDate))
      //     .forEach((element) => creditSpendMap[element.date.yyyymmdd]?.add(element));
      //
      //
      //

      final creditSpendMonthlyList =
          ref.watch(creditSpendMonthlyProvider(genDate).select((value) => value.creditSpendMonthlyList));

      creditSpendMonthlyList.value?.forEach((element) => creditSpendMap[element.date.yyyymmdd]?.add(element));
    }
  }

  return creditSpendMap;
}
