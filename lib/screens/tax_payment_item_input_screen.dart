// ignore_for_file: must_be_immutable, cast_nullable_to_non_nullable, non_constant_identifier_names, cascade_invocations

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../state/app_param/app_param_notifier.dart';
import '../state/tax_payment_item/tax_payment_item_notifier.dart';
import '../utility/utility.dart';

class TaxPaymentItemInputScreen extends ConsumerWidget {
  TaxPaymentItemInputScreen({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  List<CsvData> csvDataList = [];

  List<TextEditingController> tecs = [];

  late BuildContext _context;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final yearWidgetList = makeYearWidgetList();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Row(children: yearWidgetList),
                const SizedBox(height: 20),

                //
                Expanded(
                  child: FutureBuilder(
                    future: getCsvData(path: 'assets/csv/tax_payment.csv'),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      csvDataList = snapshot.data as List<CsvData>;

                      makeTecs();

                      return displayCategoryList();
                    },
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    GestureDetector(
                      onTap: () {
                        final list = ['経費'];

                        for (var i = 0; i < csvDataList.length; i++) {
                          list.add(csvDataList[i].category2);
                        }

                        final list2 = [
                          '1254692',
                          '408',
                          '408',
                          '908020',
                          '0',
                          '40000',
                          '0',
                          '41',
                          '57'
                        ];

                        for (var i = 0; i < list.length; i++) {
                          tecs[i].text = list2[i];

                          _ref
                              .watch(taxPaymentItemProvider.notifier)
                              .setTaxPaymentItem(
                                number: i,
                                item: list[i],
                                price: list2[i],
                              );
                        }
                      },
                      child: const Icon(Icons.ac_unit),
                    ),
                    GestureDetector(
                      onTap: () {
                        _ref
                            .watch(taxPaymentItemProvider.notifier)
                            .inputTaxPaymentItem();
                      },
                      child: const Icon(Icons.input),
                    ),
                  ],
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  List<Widget> makeYearWidgetList() {
    final TaxPaymentItemAlertSelectYear = _ref.watch(
      appParamProvider.select((value) => value.TaxPaymentItemAlertSelectYear),
    );

    final yearList = <Widget>[];
    for (var i = date.yyyy.toInt(); i >= 2021; i--) {
      yearList.add(
        GestureDetector(
          onTap: () async {
            await _ref
                .watch(appParamProvider.notifier)
                .setTaxPaymentItemAlertSelectYear(year: i);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: (i == TaxPaymentItemAlertSelectYear)
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
      final rows = line.split(',');

      if (rows[2].trim().toInt() == 1) {
        final rowData = CsvData(
          category1: rows[0].trim(),
          category2: rows[1].trim(),
          taxItem: rows[2].trim().toInt(),
        );

        list.add(rowData);
      }
    }

    return list;
  }

  ///
  void makeTecs() {
    for (var i = 0; i <= csvDataList.length; i++) {
      tecs.add(TextEditingController(text: ''));
    }
  }

  ///
  Widget displayCategoryList() {
    final list = <Widget>[];

    //------------------------------------// 経費
    list.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('経費'),
            SizedBox(
              width: _context.screenSize.width * 0.3,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: tecs[0],
                decoration: const InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 4,
                  ),
                ),
                style: const TextStyle(fontSize: 12),
                onChanged: (value) {
                  _ref.watch(taxPaymentItemProvider.notifier).setTaxPaymentItem(
                        number: 0,
                        item: '経費',
                        price: value,
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
    //------------------------------------// 経費

    for (var i = 0; i < csvDataList.length; i++) {
      list.add(
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(csvDataList[i].category2),
              SizedBox(
                width: _context.screenSize.width * 0.3,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: tecs[i + 1],
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 4,
                    ),
                  ),
                  style: const TextStyle(fontSize: 12),
                  onChanged: (value) {
                    _ref
                        .watch(taxPaymentItemProvider.notifier)
                        .setTaxPaymentItem(
                          number: i + 1,
                          item: csvDataList[i].category2,
                          price: value,
                        );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }
}

///
class CsvData {
  CsvData({
    required this.category1,
    required this.category2,
    required this.taxItem,
  });

  String category1;
  String category2;
  int taxItem;
}
