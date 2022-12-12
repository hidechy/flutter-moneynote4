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

class CreditUdemyAlert extends ConsumerWidget {
  CreditUdemyAlert({super.key, required this.date, required this.price});

  final DateTime date;
  final int price;

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
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
    final udemyState = _ref.watch(udemyProvider(date));

    final creditUdemyState = _ref.watch(creditUdemyProvider(date));

    final udemyList = getUdemyList(
      creditUdemyState: creditUdemyState,
      udemyState: udemyState,
    );

    final list = <Widget>[];
    for (var i = 0; i < udemyList.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          width: _context.screenSize.width,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(udemyList[i].date),
                  Text(udemyList[i].category),
                ],
              ),
              Text(udemyList[i].title),
              Container(
                alignment: Alignment.topRight,
                child: Text(udemyList[i].price.toCurrency()),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  udemyList[i].pay,
                  style: const TextStyle(color: Colors.grey),
                ),
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
