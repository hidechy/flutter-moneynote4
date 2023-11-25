// ignore_for_file: must_be_immutable, cast_nullable_to_non_nullable, parameter_assignments

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/benefit/benefit_notifier.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/duty/duty_notifier.dart';
import '../../../state/keihi_list/keihi_list_notifier.dart';
import '../../../utility/utility.dart';

///
class CsvData {
  CsvData({
    required this.category1,
    required this.category2,
    required this.taxItem,
  });

  String category1;
  String category2;
  int taxItem;
}

class TaxPaymentDisplayPage extends ConsumerWidget {
  TaxPaymentDisplayPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Map<String, int> taxPaymentDisplayValue = {};

  Map<String, int> taxPaymentItemValue = {};

  List<CsvData> csvDataList = [];

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    makeTaxPaymentDisplayValue();

    final deviceInfoState = ref.read(deviceInfoProvider);

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              Expanded(
                child: FutureBuilder(
                  future: getCsvData(path: 'assets/csv/tax_payment.csv'),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    csvDataList = snapshot.data as List<CsvData>;

                    return displayCategoryList();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<List<CsvData>> getCsvData({required String path}) async {
    final list = <CsvData>[];

    final csv = await rootBundle.loadString(path);

    for (final line in csv.split('\n')) {
      final rows = line.split(',');

      final rowData = CsvData(
        category1: rows[0].trim(),
        category2: rows[1].trim(),
        taxItem: rows[2].trim().toInt(),
      );

      list.add(rowData);
    }

    return list;
  }

  ///
  Widget displayCategoryList() {
    final list = <Widget>[];

    var keepCategory1 = '';
    var i = 1;

    csvDataList.forEach((element) {
      if (element.category1 != keepCategory1) {
        list.add(
          Container(
            width: _context.screenSize.width,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
            decoration: BoxDecoration(
              color: _utility.getLeadingBgColor(month: i.toString()),
            ),
            child: Text(element.category1),
          ),
        );

        i++;
      }

      //------------------------------------------------//
      if (element.category2 == '事業所得') {
        list.add(
          getDisplayRow(
            category2: '経費',
            color: Colors.yellowAccent.withOpacity(0.8),
          ),
        );
      }
      //------------------------------------------------//

      list.add(getDisplayRow(category2: element.category2));

      ///////////////////////////////////////////////
      if (element.category2 == '所得金額配当') {
        list.add(
          getDisplayRow(
            category2: '所得金額合計',
            color: const Color(0xFFFBB6CE),
          ),
        );
      }

      if (element.category2 == '寄附金控除') {
        list.add(
          getDisplayRow(
            category2: '所得から差し引かれる金額合計',
            color: const Color(0xFFFBB6CE),
          ),
        );
      }

      ///////////////////////////////////////////////

      keepCategory1 = element.category1;
    });

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }

  ///
  Widget getDisplayRow({required String category2, Color? color}) {
    final addLineItems = [
      '事業所得',
      '課税される所得金額',
      '課税される所得金額に対する税額',
      '差引所得税額',
      '復興特別所得税額',
      '所得税及び復興特別所得税の額',
      '申告納税額',
      '第3期分の税額（納付金額）',
      '第3期分の税額（還付金額）',
    ];

    final calculationItem = ['事業所得', '課税される所得金額', '課税される所得金額に対する税額', '差引所得税額', '復興特別所得税額', '所得税及び復興特別所得税の額', '申告納税額'];

    if (calculationItem.contains(category2)) {
      color = Colors.lightBlueAccent;
    }

    final resultItem = ['第3期分の税額（納付金額）', '第3期分の税額（還付金額）'];

    if (resultItem.contains(category2)) {
      color = Colors.greenAccent;
    }

    return Container(
      width: _context.screenSize.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
        color: (category2 == '申告納税額') ? Colors.pinkAccent.withOpacity(0.1) : Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: TextStyle(
              color: (color != null) ? color : Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(category2),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    (taxPaymentDisplayValue[category2] != null)
                        ? taxPaymentDisplayValue[category2].toString().toCurrency()
                        : 0.toString(),
                  ),
                ),
              ],
            ),
          ),
          if (addLineItems.contains(category2)) getAddLineWidget(category2: category2),
        ],
      ),
    );
  }

  ///
  Widget getAddLineWidget({required String category2}) {
    switch (category2) {
      case '事業所得':
        return const Text('事業収入 - 経費 - 青色申告特別控除額');

      case '課税される所得金額':
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('事業所得 - （差し引かれる金額）'),
            Text(' ⇨　1000円以下の端数を切る'),
          ],
        );

      case '課税される所得金額に対する税額':
        return const Text('課税される所得金額 ⇨　法定処理');

      case '差引所得税額':
        return const Text('課税される所得金額に対する税額 - 配当控除');

      case '復興特別所得税額':
        return const Text('差引所得税額 * 2.1%');

      case '所得税及び復興特別所得税の額':
        return const Text('差引所得税額 + 復興特別所得税額');

      case '申告納税額':
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('所得税及び復興特別所得税の額 - 源泉徴収税額 '),
            Text(' ⇨　100円以下の端数を切る'),
          ],
        );

      case '第3期分の税額（納付金額）':
        return const Text('予定納税額 < 申告納税額　の場合、支払う');
      case '第3期分の税額（還付金額）':
        return const Text('予定納税額 > 申告納税額　の場合、戻される');

      default:
        return const Text('');
    }
  }

  ///
  Future<void> makeTaxPaymentDisplayValue() async {
    makeTaxPaymentItemValue();

    taxPaymentDisplayValue['基礎控除'] = 480000;

    //-----------------------------------//

    if (date.year == DateTime.now().year) {
      taxPaymentDisplayValue['事業収入'] = getBenefit();
      taxPaymentDisplayValue['予定納税額'] = getYoteiNouzei();
      taxPaymentDisplayValue['経費'] = getKeihi();
      taxPaymentDisplayValue['社会保険料控除'] = getShakaiHoken();

      taxPaymentDisplayValue['生命保険料控除'] = 71361;
    }
    //-----------------------------------//

    taxPaymentDisplayValue['事業所得'] =
        taxPaymentDisplayValue['事業収入']! - taxPaymentDisplayValue['経費']! - taxPaymentDisplayValue['青色申告特別控除額']!;

    final shotokuSumList = [taxPaymentDisplayValue['事業所得'], taxPaymentDisplayValue['所得金額配当']];

    taxPaymentDisplayValue['所得金額合計'] = shotokuSumList.reduce((a, b) => a! + b!)!;

    final sashihikareSumList = [
      taxPaymentDisplayValue['社会保険料控除'],
      taxPaymentDisplayValue['小規模企業共済等掛金控除'],
      taxPaymentDisplayValue['生命保険料控除'],
      taxPaymentDisplayValue['基礎控除'],
      taxPaymentDisplayValue['寄附金控除']
    ];

    taxPaymentDisplayValue['所得から差し引かれる金額合計'] = sashihikareSumList.reduce((a, b) => a! + b!)!;

    final aaa = taxPaymentDisplayValue['所得金額合計']! - taxPaymentDisplayValue['所得から差し引かれる金額合計']!;

    taxPaymentDisplayValue['課税される所得金額'] = (aaa / 1000).floor() * 1000;

    taxPaymentDisplayValue['課税される所得金額に対する税額'] =
        makeKazeiShotokuKingaku(kazeiShotoku: taxPaymentDisplayValue['課税される所得金額']);

    taxPaymentDisplayValue['差引所得税額'] = taxPaymentDisplayValue['課税される所得金額に対する税額']! - taxPaymentDisplayValue['配当控除']!;

    taxPaymentDisplayValue['復興特別所得税額'] =
        (taxPaymentDisplayValue['差引所得税額']! * 0.021).round().toString().split('.')[0].toInt();

    taxPaymentDisplayValue['所得税及び復興特別所得税の額'] = taxPaymentDisplayValue['差引所得税額']! + taxPaymentDisplayValue['復興特別所得税額']!;

    taxPaymentDisplayValue['申告納税額'] =
        ((taxPaymentDisplayValue['所得税及び復興特別所得税の額']! - taxPaymentDisplayValue['源泉徴収税額']!) / 100).floor() * 100;

    taxPaymentDisplayValue['予定納税額'] = getYoteiNouzei();

    makeNoufuKanpu(
      shinkoku: taxPaymentDisplayValue['申告納税額'],
      yotei: taxPaymentDisplayValue['予定納税額'],
    );
  }

  ///
  void makeTaxPaymentItemValue() {
    // final taxPaymentItemState = _ref.watch(taxPaymentItemProvider(date));
    //
    // taxPaymentDisplayValue['事業収入'] = taxPaymentItemState.businessIncome;
    // taxPaymentDisplayValue['収入金額配当'] = taxPaymentItemState.incomeDividend;
    // taxPaymentDisplayValue['給与収入'] = taxPaymentItemState.salaryIncome;
    // taxPaymentDisplayValue['経費'] = taxPaymentItemState.expenses;
    // taxPaymentDisplayValue['所得金額配当'] = taxPaymentItemState.incomeAmountDividend;
    // taxPaymentDisplayValue['社会保険料控除'] = taxPaymentItemState.socialInsuranceDeduction;
    // taxPaymentDisplayValue['小規模企業共済等掛金控除'] = taxPaymentItemState.smallBusinessDeduction;
    // taxPaymentDisplayValue['生命保険料控除'] = taxPaymentItemState.lifeInsuranceDeduction;
    // taxPaymentDisplayValue['寄附金控除'] = taxPaymentItemState.donationDeduction;
    // taxPaymentDisplayValue['配当控除'] = taxPaymentItemState.dividendDeduction;
    // taxPaymentDisplayValue['源泉徴収税額'] = taxPaymentItemState.withholdingTaxAmount;
    // taxPaymentDisplayValue['青色申告特別控除額'] = taxPaymentItemState.blueSpecialDeduction;
    //
    //
    //

    final taxPaymentItem = _ref.watch(taxPaymentItemProvider(date).select((value) => value.taxPaymentItem));

    if (taxPaymentItem != null) {
      taxPaymentDisplayValue['事業収入'] = taxPaymentItem.businessIncome;
      taxPaymentDisplayValue['収入金額配当'] = taxPaymentItem.incomeDividend;
      taxPaymentDisplayValue['給与収入'] = taxPaymentItem.salaryIncome;
      taxPaymentDisplayValue['経費'] = taxPaymentItem.expenses;
      taxPaymentDisplayValue['所得金額配当'] = taxPaymentItem.incomeAmountDividend;
      taxPaymentDisplayValue['社会保険料控除'] = taxPaymentItem.socialInsuranceDeduction;
      taxPaymentDisplayValue['小規模企業共済等掛金控除'] = taxPaymentItem.smallBusinessDeduction;
      taxPaymentDisplayValue['生命保険料控除'] = taxPaymentItem.lifeInsuranceDeduction;
      taxPaymentDisplayValue['寄附金控除'] = taxPaymentItem.donationDeduction;
      taxPaymentDisplayValue['配当控除'] = taxPaymentItem.dividendDeduction;
      taxPaymentDisplayValue['源泉徴収税額'] = taxPaymentItem.withholdingTaxAmount;
      taxPaymentDisplayValue['青色申告特別控除額'] = taxPaymentItem.blueSpecialDeduction;
    }
  }

  ///
  int getBenefit() {
    var ret = 0;

    final benefitList = _ref.watch(benefitProvider.select((value) => value.benefitList));

    benefitList.value?.forEach((element) {
      if (element.date.year == date.year) {
        ret += element.salary.toInt();
      }
    });

    //
    //
    // final benefitState = _ref.watch(benefitProvider);
    //
    // benefitState.benefitList.forEach((element) {
    //   if (element.date.year == date.year) {
    //     ret += element.salary.toInt();
    //   }
    // });
    //
    //

    return ret;
  }

  ///
  int getYoteiNouzei() {
    final july = DateTime(date.year, 7);
    final august = DateTime(date.year, 8);
    final november = DateTime(date.year, 11);

    final yoteiYearMonth = [july.yyyymm, august.yyyymm, november.yyyymm];

    var ret = 0;

    final dutyList = _ref.watch(dutyProvider(date).select((value) => value.dutyList));

    dutyList.value?.forEach((element) {
      if (element.duty == '所得税') {
        if (yoteiYearMonth.contains(DateTime.parse(element.date).yyyymm)) {
          ret += element.price;
        }
      }
    });

    // final dutyState = _ref.watch(dutyProvider(date));
    //
    // dutyState.forEach((element) {
    //   if (element.duty == '所得税') {
    //     if (yoteiYearMonth.contains(DateTime.parse(element.date).yyyymm)) {
    //       ret += element.price;
    //     }
    //   }
    // });

    return ret;
  }

  ///
  int getKeihi() {
    var ret = 0;

    // final keihiListState = _ref.watch(keihiListProvider(date));
    //
    // keihiListState.forEach((element) {
    //   ret += element.price;
    // });
    //
    //
    //

    final keihiList = _ref.watch(keihiListProvider(date).select((value) => value.keihiList));

    keihiList.value?.forEach((element) => ret += element.price);

    return ret;
  }

  ///
  int getShakaiHoken() {
    final shakaiHokenItems = ['年金', '国民年金基金', '国民健康保険'];

    var ret = 0;

    final dutyList = _ref.watch(dutyProvider(date).select((value) => value.dutyList));

    dutyList.value?.forEach((element) {
      if (shakaiHokenItems.contains(element.duty)) {
        ret += element.price;
      }
    });

    // final dutyState = _ref.watch(dutyProvider(date));
    //
    // dutyState.forEach((element) {
    //   if (shakaiHokenItems.contains(element.duty)) {
    //     ret += element.price;
    //   }
    // });

    return ret;
  }

  ///
  int makeKazeiShotokuKingaku({int? kazeiShotoku}) {
    if (kazeiShotoku! >= 1000 && kazeiShotoku <= 1949000) {
      final x = kazeiShotoku * 0.05;
      return x.round().toString().split('.')[0].toInt();
    } else if (kazeiShotoku >= 1950000 && kazeiShotoku <= 3299999) {
      final x = kazeiShotoku * 0.1;
      return x.round().toString().split('.')[0].toInt() - 97500;
    } else if (kazeiShotoku >= 3300000 && kazeiShotoku <= 6949000) {
      final x = kazeiShotoku * 0.2;
      return x.round().toString().split('.')[0].toInt() - 427500;
    } else if (kazeiShotoku > 6950000 && kazeiShotoku <= 8999000) {
      final x = kazeiShotoku * 0.23;
      return x.round().toString().split('.')[0].toInt() - 436000;
    }

    return 0;
  }

  ///
  void makeNoufuKanpu({int? shinkoku, int? yotei}) {
    taxPaymentDisplayValue['第3期分の税額（納付金額）'] = 0;
    taxPaymentDisplayValue['第3期分の税額（還付金額）'] = 0;

    if (shinkoku! > yotei!) {
      taxPaymentDisplayValue['第3期分の税額（納付金額）'] = shinkoku - yotei;
    } else {
      taxPaymentDisplayValue['第3期分の税額（還付金額）'] = yotei - shinkoku;
    }
  }
}
