// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../route/routes.dart';
import '../../state/credit/credit_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '_parts/credit_detail_dialog.dart';

class CreditYearlyTotalAlert extends ConsumerWidget {
  CreditYearlyTotalAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Uuid uuid = const Uuid();

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
                if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
                //----------//

                const SizedBox(height: 20),

                displayCreditYearlyTotal(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayCreditYearlyTotal() {
    final list = <Widget>[];

    final creditSpendAllList = _ref.watch(creditYearlyTotalProvider(date).select((value) => value.creditSpendAllList));

    return creditSpendAllList.when(
      data: (value) {
        value.forEach((element) {
          if (element.price != '') {
            final color = (element.price.toInt() >= 3000) ? Colors.yellowAccent : Colors.white;

            list.add(
              GestureDetector(
                onTap: () async {
                  Timer(
                    const Duration(seconds: 3),
                    () => _context.goNamed(RouteNames.home),
                  );

                  await showDialog(
                    context: _context,
                    builder: (_) => CreditDetailDialog(date: date, creditDetail: element),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
                  child: DefaultTextStyle(
                    style: TextStyle(color: color, fontSize: 12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: _context.screenSize.width * 0.55,
                              child: Text(element.item, maxLines: 1, overflow: TextOverflow.ellipsis),
                            ),
                            Container(width: 60, alignment: Alignment.topRight, child: Text(element.date.yyyymm)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Text(element.price.toCurrency()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });

        return SingleChildScrollView(
          child: Column(
            children: list,
          ),
        );
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*



    final creditYearlyTotalState = _ref.watch(creditYearlyTotalProvider(date));

    creditYearlyTotalState.forEach((element) {
      if (element.price != '') {
        final color = (element.price.toInt() >= 3000) ? Colors.yellowAccent : Colors.white;

        list.add(
          GestureDetector(
            onTap: () async {
              Timer(
                const Duration(seconds: 3),
                () => _context.goNamed(RouteNames.home),
              );

              await showDialog(
                context: _context,
                builder: (_) => CreditDetailDialog(date: date, creditDetail: element),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: _context.screenSize.width * 0.55,
                          child: Text(
                            element.item,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 60,
                          alignment: Alignment.topRight,
                          child: Text(element.date.yyyymm),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Text(element.price.toCurrency()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );




    */
  }
}
