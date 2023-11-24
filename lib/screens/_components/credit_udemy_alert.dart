// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/credit/credit_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/udemy/udemy_notifier.dart';
import '../../utility/utility.dart';
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
                if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
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

  /*



  ///
  List<Udemy> getUdemyList({required List<CreditSpendMonthly> creditUdemyState, required List<Udemy> udemyState}) {
    final list = <Udemy>[];

    final title = <String>[];

    creditUdemyState.forEach((element) {
      udemyState.forEach((element2) {
        if (element.date.yyyymmdd == element2.date) {
          if (!title.contains(element2.title)) {
            list.add(element2);
          }

          title.add(element2.title);
        }
      });
    });

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

    udemyList.forEach((element) {
      list.add(UdemyBox(udemy: element));
    });

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }






  */

  ///
  Widget displayUdemy() {
    // final creditUdemyState = _ref.watch(creditUdemyProvider(date));
    //
    //
    //

    final creditSpendMonthlyList =
        _ref.watch(creditUdemyProvider(date).select((value) => value.creditSpendMonthlyList));

    final udemyList = _ref.watch(udemyProvider.select((value) => value.udemyList));

    return udemyList.when(
      data: (value) {
        final list = <Widget>[];

        value.forEach((element) {
          creditSpendMonthlyList.value?.forEach((element2) {
            if (element.date == element2.date.yyyymmdd) {
              list.add(UdemyBox(udemy: element));
            }
          });
        });

        // value.forEach((element) {
        //   creditUdemyState.forEach((element2) {
        //     if (element.date == element2.date.yyyymmdd) {
        //       list.add(UdemyBox(udemy: element));
        //     }
        //   });
        // });
        //
        //
        //

        return SingleChildScrollView(child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
