// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/credit_notifier.dart';

class CreditCompanyAlert extends ConsumerWidget {
  CreditCompanyAlert({super.key, required this.date});

  final DateTime date;

  List<String> creditCompany = ['uc', 'rakuten', 'sumitomo', 'amex'];
  Map<String, List<Map<String, dynamic>>> creditCompanyMap = {};

  final Utility _utility = Utility();

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
                const SizedBox(height: 20),
                displayCreditCompany(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  List<Widget> makeYearWidgetList() {
    final appParamState = _ref.watch(appParamProvider);

    final yearList = <Widget>[];
    for (var i = date.yyyy.toInt(); i >= 2020; i--) {
      yearList.add(
        GestureDetector(
          onTap: () {
            _ref
                .watch(appParamProvider.notifier)
                .setCreditCompanyAlertSelectYear(year: i);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: (i == appParamState.CreditCompanyAlertSelectYear)
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
  Widget displayCreditCompany() {
    final appParamState = _ref.watch(appParamProvider);

    final creditCompanyState = _ref.watch(creditCompanyProvider(
        '${appParamState.CreditCompanyAlertSelectYear}-01-01 00:00:00'
            .toDateTime()));

    final list = <Widget>[];

    for (var i = 0; i < creditCompanyState.length; i++) {
      final list2 = <Widget>[];

      var total = 0;
      for (var j = 0; j < creditCompanyState[i].list.length; j++) {
        list2.add(
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(creditCompanyState[i].list[j].company),
                Row(
                  children: [
                    Text(creditCompanyState[i]
                        .list[j]
                        .sum
                        .toString()
                        .toCurrency()),
                    const SizedBox(width: 20),
                    getCreditMark(kind: creditCompanyState[i].list[j].company),
                  ],
                ),
              ],
            ),
          ),
        );

        total += creditCompanyState[i].list[j].sum;
      }

      list2
        ..add(
          Divider(
            color: Colors.white.withOpacity(0.3),
            thickness: 1,
          ),
        )
        ..add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text(
                total.toString().toCurrency(),
                style: const TextStyle(color: Colors.yellowAccent),
              ),
            ],
          ),
        )
        ..add(const SizedBox(height: 30));

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
              Text(creditCompanyState[i].ym),
              Row(
                children: [
                  Container(width: 20),
                  Expanded(
                    child: Column(
                      children: list2,
                    ),
                  ),
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

  ///
  Widget getCreditMark({required String kind}) {
    switch (kind) {
      case 'uc':
        return const Icon(Icons.credit_card, color: Colors.redAccent);
      case 'rakuten':
        return const Icon(Icons.credit_card, color: Colors.orangeAccent);
      case 'amex':
        return const Icon(Icons.credit_card, color: Colors.purpleAccent);
      case 'sumitomo':
        return const Icon(Icons.credit_card, color: Colors.greenAccent);
    }

    return const Icon(Icons.credit_card, color: Colors.white);
  }
}
