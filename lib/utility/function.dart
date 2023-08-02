import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../models/credit_spend_monthly.dart';
import '../viewmodel/credit_notifier.dart';
import 'utility.dart';

Map<String, List<CreditSpendMonthly>> getNext2MonthCreditSpend({
  required WidgetRef ref,
  required DateTime creDate,
  required Utility utility,
}) {
  final creditSpendMap = <String, List<CreditSpendMonthly>>{};

  var list = <CreditSpendMonthly>[];
  var keepDate = '';

  //---------------------//
  final after1 = utility.makeSpecialDate(date: creDate, usage: 'month', plusminus: 'plus', num: 1);

  final creditSpendMonthlyState1 = ref.watch(creditSpendMonthlyProvider(after1!));

  list = <CreditSpendMonthly>[];
  keepDate = '';

  creditSpendMonthlyState1.forEach((element) {
    if (keepDate != element.date.yyyymmdd) {
      list = [];
    }

    if (creDate.yyyymm == element.date.yyyymm) {
      list.add(element);
    }

    if (list.isNotEmpty) {
      creditSpendMap[element.date.yyyymmdd] = list;
    }

    keepDate = element.date.yyyymmdd;
  });
  //---------------------//

  //---------------------//

  final after2 = utility.makeSpecialDate(date: creDate, usage: 'month', plusminus: 'plus', num: 2);

  final creditSpendMonthlyState2 = ref.watch(creditSpendMonthlyProvider(after2!));

  list = <CreditSpendMonthly>[];
  keepDate = '';

  creditSpendMonthlyState2.forEach((element) {
    if (keepDate != element.date.yyyymmdd) {
      list = [];
    }

    if (creDate.yyyymm == element.date.yyyymm) {
      list.add(element);
    }

    if (list.isNotEmpty) {
      creditSpendMap[element.date.yyyymmdd] = list;
    }

    keepDate = element.date.yyyymmdd;
  });
  //---------------------//

  return creditSpendMap;
}
