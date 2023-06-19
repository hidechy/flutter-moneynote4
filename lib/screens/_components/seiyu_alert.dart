// ignore_for_file: must_be_immutable, sized_box_shrink_expand, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/seiyu_notifier.dart';

class SeiyuAlert extends ConsumerWidget {
  SeiyuAlert({super.key, required this.date});

  final DateTime date;

  Uuid uuid = const Uuid();

  final Utility _utility = Utility();

  Map<String, int> seiyuDateSumMap = {};

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final yearWidgetList = makeYearWidgetList();

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
              const SizedBox(height: 20),

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

    return list;
  }

  ///
  Widget displaySeiyuDateList() {
    final yearDateList = makeYearDateList();

    final list = <Widget>[];

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(element),
              Text(seiyuDateSumMap[element].toString().toCurrency()),
            ],
          ),
        ),
      );
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }
}
