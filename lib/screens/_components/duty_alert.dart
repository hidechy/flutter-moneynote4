import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../utility/utility.dart';
import '../../viewmodel/duty_notifier.dart';

class DutyAlert extends ConsumerWidget {
  DutyAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final yearWidgetList = makeYearWidgetList();

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
                const SizedBox(height: 20),
                displayDuty(),
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
                .watch(dutyProvider(date.yyyymmdd).notifier)
                .getDuty(date: '$i-01-01');
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
  Widget displayDuty() {
    final dutyState = _ref.watch(dutyProvider(date.yyyymmdd));

    List<Widget> list = [];

    for (var i = 0; i < dutyState.length; i++) {
      list.add(
        Container(
          width: _context.screenSize.width,
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          child: Table(
            children: [
              TableRow(children: [
                Text(dutyState[i].date),
                Text(dutyState[i].duty),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(dutyState[i].price.toString().toCurrency()),
                ),
              ]),
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
