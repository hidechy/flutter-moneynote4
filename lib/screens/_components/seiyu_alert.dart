// ignore_for_file: must_be_immutable, sized_box_shrink_expand, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/seiyu_notifier.dart';
import '_money_dialog.dart';

import 'seiyu_item_alert.dart';

class SeiyuAlert extends ConsumerWidget {
  SeiyuAlert({super.key, required this.date});

  final DateTime date;

  Uuid uuid = const Uuid();

  final Utility _utility = Utility();

  Map<String, int> seiyuDateSumMap = {};

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final yearWidgetList = makeYearWidgetList();

    final yearDateList = makeYearDateList();

    final SeiyuAlertSelectYear = ref.watch(
      appParamProvider.select((value) => value.SeiyuAlertSelectYear),
    );

    final SeiyuAlertSelectDate = ref.watch(
      appParamProvider.select((value) => value.SeiyuAlertSelectDate),
    );

    print(seiyuDateSumMap);

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
        child: SingleChildScrollView(
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
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: yearDateList.map((val) {
                        final exVal = val.split('-');
                        return GestureDetector(
                          onTap: () {
                            ref
                                .watch(appParamProvider.notifier)
                                .setSeiyuAlertSelectDate(date: val);

                            ref
                                .watch(seiyuPurchaseDateProvider.notifier)
                                .getSeiyuPurchaseList(
                                  date: '$SeiyuAlertSelectYear-$val',
                                );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 5,
                            ),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                              ),
                              color: (SeiyuAlertSelectDate == val)
                                  ? Colors.yellowAccent.withOpacity(0.3)
                                  : null,
                            ),
                            child: Column(
                              children: [
                                Text(exVal[0]),
                                Text(exVal[1]),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                displaySeiyuPurchase(),
              ],
            ),
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
        list.add(DateTime.parse(seiyuAllState[i].date).mmdd);

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

    return list;
  }

  ///
  Widget displaySeiyuPurchase() {
    final seiyuPurchaseDateState = _ref.watch(seiyuPurchaseDateProvider);

    final list = <Widget>[];

    var total = 0;

    for (var i = 0; i < seiyuPurchaseDateState.length; i++) {
      total += seiyuPurchaseDateState[i].price.toInt();
    }

    list.add(
      Container(
        width: double.infinity,
        alignment: Alignment.topRight,
        child: Column(
          children: [
            Text(
              total.toString().toCurrency(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );

    for (var i = 0; i < seiyuPurchaseDateState.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(seiyuPurchaseDateState[i].date),
                    ),
                    Text(
                      seiyuPurchaseDateState[i].item,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Text(seiyuPurchaseDateState[i].tanka.toCurrency()),
                        const SizedBox(width: 20),
                        const Text('×'),
                        const SizedBox(width: 20),
                        Text(seiyuPurchaseDateState[i].kosuu),
                        const SizedBox(width: 20),
                        const Text('='),
                        const SizedBox(width: 20),
                        Text(seiyuPurchaseDateState[i].price.toCurrency()),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  MoneyDialog(
                    context: _context,
                    widget: SeiyuItemAlert(
                      date: date,
                      item: seiyuPurchaseDateState[i].item,
                    ),
                  );
                },
                icon: Icon(
                  Icons.ac_unit,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      key: PageStorageKey(uuid.v1()),
      child: Column(
        children: list,
      ),
    );
  }
}
