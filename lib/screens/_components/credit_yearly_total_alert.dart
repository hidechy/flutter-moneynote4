// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/credit_notifier.dart';

class CreditYearlyTotalAlert extends ConsumerWidget {
  CreditYearlyTotalAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Uuid uuid = const Uuid();

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
    final creditYearlyTotalState = _ref.watch(creditYearlyTotalProvider(date));

    final list = <Widget>[];

    for (var i = 0; i < creditYearlyTotalState.length; i++) {
      list.add(
        Row(
          children: [
            SizedBox(
              width: 60,
              child: Column(
                children: [
                  Text('${creditYearlyTotalState[i].payMonth}-01 00:00:00'
                      .toDateTime()
                      .yyyy),
                  Text('${creditYearlyTotalState[i].payMonth}-01 00:00:00'
                      .toDateTime()
                      .mm),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    creditYearlyTotalState[i].item,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(creditYearlyTotalState[i].date.yyyymmdd),
                      Text(creditYearlyTotalState[i].price),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(creditYearlyTotalState[i].kind),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
