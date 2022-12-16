// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/credit_spend_monthly.dart';
import '../../models/udemy.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/credit_notifier.dart';
import '../../viewmodel/udemy_notifier.dart';
import '_parts/udemy_box.dart';

class CreditUdemyAlert extends ConsumerWidget {
  CreditUdemyAlert({super.key, required this.date, required this.price});

  final DateTime date;
  final int price;

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date.yyyymm,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      price.toString().toCurrency(),
                      style: const TextStyle(color: Colors.yellowAccent),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                displayUdemy(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  List<Udemy> getUdemyList(
      {required List<CreditSpendMonthly> creditUdemyState,
      required List<Udemy> udemyState}) {
    final list = <Udemy>[];

    final title = <String>[];

    for (var i = 0; i < creditUdemyState.length; i++) {
      for (var j = 0; j < udemyState.length; j++) {
        if (creditUdemyState[i].date.yyyymmdd == udemyState[j].date) {
          if (!title.contains(udemyState[j].title)) {
            list.add(udemyState[j]);
          }

          title.add(udemyState[j].title);
        }
      }
    }

    return list;
  }

  ///
  Widget displayUdemy() {
    final udemyState = _ref.watch(udemyProvider);

    final creditUdemyState = _ref.watch(creditUdemyProvider(date));

    final udemyList = getUdemyList(
      creditUdemyState: creditUdemyState,
      udemyState: udemyState,
    );

    final list = <Widget>[];
    for (var i = 0; i < udemyList.length; i++) {
      list.add(UdemyBox(udemy: udemyList[i]));
    }

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }
}
