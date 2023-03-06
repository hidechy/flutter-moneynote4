// ignore_for_file: must_be_immutable, non_constant_identifier_names, cast_nullable_to_non_nullable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';

class TaxPaymentDisplayAlert extends ConsumerWidget {
  TaxPaymentDisplayAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Map<String, int> taxPaymentDisplayValue = {};

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    makeTaxPaymentDisplayValue();

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

              Expanded(
                child: FutureBuilder(
                  future: getCsvData(path: 'assets/csv/tax_payment.csv'),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final list = snapshot.data as List<CsvData>;
                    return displayCategoryList(data: list);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  List<Widget> makeYearWidgetList() {
    final TaxPaymentAlertSelectYear = _ref.watch(
      appParamProvider.select((value) => value.TaxPaymentAlertSelectYear),
    );

    final yearList = <Widget>[];
    for (var i = date.yyyy.toInt(); i >= 2020; i--) {
      yearList.add(
        GestureDetector(
          onTap: () {
            _ref
                .watch(appParamProvider.notifier)
                .setTaxPaymentAlertSelectYear(year: i);

            final date = '$i-01-01 00:00:00'.toDateTime();

            // _ref.watch(trainProvider.notifier).getYearTrain(date: date);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: (i == TaxPaymentAlertSelectYear)
                  ? Colors.yellowAccent.withOpacity(0.2)
                  : null,
            ),
            child: Column(
              children: [
                Text(i.toString()),
                Text('R${i - 2018}.'),
              ],
            ),
          ),
        ),
      );
    }

    return yearList;
  }

  ///
  Future<List<CsvData>> getCsvData({required String path}) async {
    final list = <CsvData>[];

    final csv = await rootBundle.loadString(path);

    for (final line in csv.split('\n')) {
      final List rows = line.split(',');

      final rowData = CsvData(
        category1: rows[0].toString().trim(),
        category2: rows[1].toString().trim(),
      );

      list.add(rowData);
    }

    return list;
  }

  ///
  Widget displayCategoryList({required List<CsvData> data}) {
    final list = <Widget>[];

    var keepCategory1 = '';
    var i = 1;
    data.forEach((element) {
      if (element.category1 != keepCategory1) {
        list.add(
          Container(
            width: _context.screenSize.width,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
            decoration: BoxDecoration(
              color: _utility.getLeadingBgColor(month: i.toString()),
            ),
            child: Text(element.category1),
          ),
        );

        i++;
      }

      list.add(
        Container(
          width: _context.screenSize.width,
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
                    flex: 4,
                    child: Text(element.category2),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        (taxPaymentDisplayValue[element.category2] != null)
                            ? taxPaymentDisplayValue[element.category2]
                                .toString()
                                .toCurrency()
                            : 0.toString()),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      keepCategory1 = element.category1;
    });

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }

  ///
  void makeTaxPaymentDisplayValue() {
    taxPaymentDisplayValue['生命保険料控除'] = 40000;
    taxPaymentDisplayValue['基礎控除'] = 480000;
    taxPaymentDisplayValue['青色申告特別控除額'] = 650000;
  }
}

class CsvData {
  CsvData({
    required this.category1,
    required this.category2,
  });

  String category1;
  String category2;
}
