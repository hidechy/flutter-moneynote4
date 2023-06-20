// ignore_for_file: must_be_immutable, sized_box_shrink_expand, non_constant_identifier_names, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/credit_notifier.dart';
import '../../viewmodel/seiyu_notifier.dart';
import '_money_dialog.dart';
import 'pages/seiyu_tab_page.dart';

class SeiyuAlert extends ConsumerWidget {
  SeiyuAlert({super.key, required this.date});

  final DateTime date;

  Uuid uuid = const Uuid();

  final Utility _utility = Utility();

  List<String> seiyuDateList = [];
  Map<String, int> seiyuDateSumMap = {};

  Map<String, int> seiyuCreditDataMap = {};

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final yearWidgetList = makeYearWidgetList();

    getSeiyuCreditMap();

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
              if (deviceInfoState.model == 'iPhone')
                _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              Row(children: yearWidgetList),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  IconButton(
                    onPressed: () {
                      MoneyDialog(
                        context: context,
                        widget: SeiyuTabPage(list: seiyuDateList),
                      );
                    },
                    icon: Icon(
                      Icons.copy_sharp,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),

              Expanded(child: displaySeiyuDateList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  List<Widget> makeYearWidgetList() {
    final SeiyuAlertSelectYear = _ref.watch(
      appParamProvider.select((value) => value.SeiyuAlertSelectYear),
    );

    final yearList = <Widget>[];
    for (var i = date.yyyy.toInt(); i >= 2020; i--) {
      yearList.add(
        GestureDetector(
          onTap: () {
            _ref
                .watch(appParamProvider.notifier)
                .setSeiyuAlertSelectYear(year: i);

            _ref
                .watch(seiyuAllProvider(date).notifier)
                .getSeiyuDateList(date: DateTime(i));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: (i == SeiyuAlertSelectYear)
                  ? Colors.yellowAccent.withOpacity(0.2)
                  : null,
            ),
            child: Text(i.toString()),
          ),
        ),
      );
    }

    return yearList;
  }

  ///
  List<String> makeYearDateList() {
    final SeiyuAlertSelectYear = _ref.watch(
      appParamProvider.select((value) => value.SeiyuAlertSelectYear),
    );

    final seiyuAllState = _ref.watch(seiyuAllProvider(date));

    final list = <String>[];
    var keepDate = '';

    final map = <String, List<int>>{};

    for (var i = 0; i < seiyuAllState.length; i++) {
      if (keepDate != seiyuAllState[i].date) {
        list.add(DateTime.parse(seiyuAllState[i].date).yyyymmdd);

        map[seiyuAllState[i].date] = [];
      }

      if (SeiyuAlertSelectYear == seiyuAllState[i].date.split('-')[0].toInt()) {
        map[seiyuAllState[i].date]?.add(seiyuAllState[i].price.toInt());
      }

      keepDate = seiyuAllState[i].date;
    }

    seiyuDateSumMap = {};

    map.entries.forEach((element) {
      var sum = 0;
      element.value.forEach((element2) {
        sum += element2;
      });

      seiyuDateSumMap[element.key] = sum;
    });

    seiyuDateList = list;

    return list;
  }

  ///
  Widget displaySeiyuDateList() {
    final yearDateList = makeYearDateList();

    final list = <Widget>[];

    list.add(
      Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            const Expanded(flex: 2, child: Text('')),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: Text(
                  'price',
                  style: TextStyle(color: Colors.yellowAccent.withOpacity(0.6)),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: Text(
                  'pay',
                  style: TextStyle(color: Colors.yellowAccent.withOpacity(0.6)),
                ),
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.topRight,
              child: Text(
                'point',
                style: TextStyle(color: Colors.yellowAccent.withOpacity(0.6)),
              ),
            )),
          ],
        ),
      ),
    );

    yearDateList.forEach((element) {
      list.add(
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(flex: 2, child: Text(element)),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    seiyuDateSumMap[element].toString().toCurrency(),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    (seiyuCreditDataMap[element] != null)
                        ? seiyuCreditDataMap[element].toString().toCurrency()
                        : '',
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.topRight,
                child: Text(
                  (seiyuCreditDataMap[element] != null)
                      ? (seiyuDateSumMap[element].toString().toInt() -
                              seiyuCreditDataMap[element].toString().toInt())
                          .toString()
                          .toCurrency()
                      : '',
                ),
              )),
            ],
          ),
        ),
      );
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }

  ///
  void getSeiyuCreditMap() {
    seiyuCreditDataMap = {};

    final SeiyuAlertSelectYear = _ref.watch(
      appParamProvider.select((value) => value.SeiyuAlertSelectYear),
    );

    final reg = RegExp('西友ネットスーパー');

    for (var i = 1; i <= 12; i++) {
      final creditSpendMonthlyState = _ref.watch(
        creditSpendMonthlyProvider(DateTime(SeiyuAlertSelectYear, i)),
      );

      creditSpendMonthlyState.forEach((element) {
        if (reg.firstMatch(element.item) != null) {
          if (element.date.year == SeiyuAlertSelectYear) {
            seiyuCreditDataMap[element.date.yyyymmdd] = element.price.toInt();
          }
        }
      });
    }

    //-----------// 1月
    final creditSpendMonthlyState = _ref.watch(
      creditSpendMonthlyProvider(DateTime(SeiyuAlertSelectYear + 1)),
    );

    creditSpendMonthlyState.forEach((element) {
      if (reg.firstMatch(element.item) != null) {
        seiyuCreditDataMap[element.date.yyyymmdd] = element.price.toInt();
      }
    });
    //-----------// 1月

    //==============// 仕方ないので
    seiyuCreditDataMap['2020-12-29'] = 2518;
    seiyuCreditDataMap['2021-01-19'] = 4610;
    seiyuCreditDataMap['2021-02-10'] = 5420;
    seiyuCreditDataMap['2021-07-19'] = 5647;
    seiyuCreditDataMap['2021-08-21'] = 7415;
    seiyuCreditDataMap['2021-11-03'] = 5576;
    seiyuCreditDataMap['2021-11-06'] = 5571;
    seiyuCreditDataMap['2021-11-15'] = 5653;
    seiyuCreditDataMap['2021-11-19'] = 5734;
    //==============// 仕方ないので
  }
}
