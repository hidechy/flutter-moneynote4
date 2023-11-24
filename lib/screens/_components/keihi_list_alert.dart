// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/keihi_list/keihi_list_notifier.dart';
import '../../utility/utility.dart';
import '_money_dialog.dart';
import 'keihi_setting_alert.dart';

class KeihiListAlert extends ConsumerWidget {
  KeihiListAlert({super.key, required this.date});

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
                if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
                //----------//

                Row(children: yearWidgetList),
                const SizedBox(height: 20),
                displayKeihiList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  List<Widget> makeYearWidgetList() {
    final KeihiListAlertSelectYear = _ref.watch(
      appParamProvider.select((value) => value.KeihiListAlertSelectYear),
    );

    final yearList = <Widget>[];
    for (var i = date.yyyy.toInt(); i >= 2022; i--) {
      yearList.add(
        GestureDetector(
          onTap: () async {
            await _ref.read(appParamProvider.notifier).setKeihiListAlertSelectYear(year: i);

            await _ref.read(keihiListProvider(date).notifier).getKeihiList(date: DateTime(i));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: (i == KeihiListAlertSelectYear) ? Colors.yellowAccent.withOpacity(0.2) : null,
            ),
            child: Text(i.toString()),
          ),
        ),
      );
    }

    return yearList;
  }

  ///
  Widget displayKeihiList() {
    var sum = 0;

    final keihiList = _ref.watch(keihiListProvider(date).select((value) => value.keihiList));

    return keihiList.when(
      data: (value) {
        final list = <Widget>[];

        value.forEach((element) {
          final color =
              (element.category1 == 'null' || element.category2 == 'null') ? Colors.yellowAccent : Colors.white;

          list.add(Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(element.date.yyyymmdd),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  element.category1,
                                  style: TextStyle(color: color),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  element.category2,
                                  style: TextStyle(color: color),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final st = <String>[
                          element.date.yyyymmdd,
                          element.item,
                          element.price.toString(),
                          element.flag
                        ];

                        final str = st.join('|');

                        MoneyDialog(
                          context: _context,
                          widget: KeihiSettingAlert(
                            id: element.id,
                            str: str,
                            date: element.date,
                          ),
                        );
                      },
                      child: Icon(
                        Icons.settings,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                Text(element.item),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(element.price.toString().toCurrency()),
                  ],
                ),
              ],
            ),
          ));

          sum += element.price;
        });

        list.add(Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.yellowAccent.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('SUM'),
              Text(sum.toString().toCurrency()),
            ],
          ),
        ));

        return SingleChildScrollView(
          child: Column(children: list),
        );
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*




    final list = <Widget>[];

    final keihiListState = _ref.watch(keihiListProvider(date));
    var sum = 0;
    keihiListState.forEach((element) {
      final color = (element.category1 == 'null' || element.category2 == 'null') ? Colors.yellowAccent : Colors.white;

      list.add(Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
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
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(element.date.yyyymmdd),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              element.category1,
                              style: TextStyle(color: color),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              element.category2,
                              style: TextStyle(color: color),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final st = <String>[element.date.yyyymmdd, element.item, element.price.toString(), element.flag];

                    final str = st.join('|');

                    MoneyDialog(
                      context: _context,
                      widget: KeihiSettingAlert(
                        id: element.id,
                        str: str,
                        date: element.date,
                      ),
                    );
                  },
                  child: Icon(
                    Icons.settings,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            Text(element.item),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text(element.price.toString().toCurrency()),
              ],
            ),
          ],
        ),
      ));

      sum += element.price;
    });

    list.add(Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.yellowAccent.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('SUM'),
          Text(sum.toString().toCurrency()),
        ],
      ),
    ));

    return SingleChildScrollView(
      child: Column(children: list),
    );





    */
  }
}
