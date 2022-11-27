// ignore_for_file: must_be_immutable, sized_box_shrink_expand

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../viewmodel/seiyu_notifier.dart';

class SeiyuAlert extends ConsumerWidget {
  SeiyuAlert({super.key, required this.date});

  final DateTime date;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final yearWidgetList = makeYearWidgetList();

    final yearDateList = makeYearDateList();

    final selectYearState = ref.watch(selectYearProvider);

    final selectDateState = ref.watch(selectDateProvider);

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
                                .watch(selectDateProvider.notifier)
                                .setSelectDate(selectDate: val);

                            ref
                                .watch(seiyuPurchaseProvider.notifier)
                                .getSeiyuPurchaseList(
                                  date: '$selectYearState-$val',
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
                              color: (selectDateState == val)
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
    final exYmd = date.yyyymmdd.split('-');

    final selectYearState = _ref.watch(selectYearProvider);

    final yearList = <Widget>[];
    for (var i = exYmd[0].toInt(); i >= 2020; i--) {
      yearList.add(
        GestureDetector(
          onTap: () {
            _ref
                .watch(selectYearProvider.notifier)
                .setSelectYear(selectYear: i.toString());

            _ref
                .watch(seiyuDateProvider(date).notifier)
                .getSeiyuDateList(date: '$i-01-01 00:00:00'.toDateTime());
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: (i.toString() == selectYearState)
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
    final seiyuPurchaseState = _ref.watch(seiyuDateProvider(date));

    final list = <String>[];
    var keepDate = '';

    for (var i = 0; i < seiyuPurchaseState.length; i++) {
      if (keepDate != seiyuPurchaseState[i].date) {
        list.add('${seiyuPurchaseState[i].date} 00:00:00'.toDateTime().mmdd);
      }

      keepDate = seiyuPurchaseState[i].date;
    }

    return list;
  }

  ///
  Widget displaySeiyuPurchase() {
    final seiyuPurchaseState = _ref.watch(seiyuPurchaseProvider);

    final list = <Widget>[];

    var total = 0;

    for (var i = 0; i < seiyuPurchaseState.length; i++) {
      total += seiyuPurchaseState[i].price.toInt();
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

    for (var i = 0; i < seiyuPurchaseState.length; i++) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topRight,
                child: Text(seiyuPurchaseState[i].date),
              ),
              Text(
                seiyuPurchaseState[i].item,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Text(seiyuPurchaseState[i].tanka.toCurrency()),
                  const SizedBox(width: 20),
                  const Text('×'),
                  const SizedBox(width: 20),
                  Text(seiyuPurchaseState[i].kosuu),
                  const SizedBox(width: 20),
                  const Text('='),
                  const SizedBox(width: 20),
                  Text(seiyuPurchaseState[i].price.toCurrency()),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }
}

////////////////////////////////////////////////

final selectYearProvider =
    StateNotifierProvider.autoDispose<SelectYearStateNotifier, String>((ref) {
  return SelectYearStateNotifier();
});

class SelectYearStateNotifier extends StateNotifier<String> {
  SelectYearStateNotifier() : super(DateTime.now().toString().split('-')[0]);

  ///
  Future<void> setSelectYear({required String selectYear}) async {
    state = selectYear;
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final selectDateProvider =
    StateNotifierProvider.autoDispose<SelectDateStateNotifier, String>((ref) {
  return SelectDateStateNotifier();
});

class SelectDateStateNotifier extends StateNotifier<String> {
  SelectDateStateNotifier() : super(DateTime.now().toString().split('-')[0]);

  ///
  Future<void> setSelectDate({required String selectDate}) async {
    state = selectDate;
  }
}

////////////////////////////////////////////////
