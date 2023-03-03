// ignore_for_file: cast_nullable_to_non_nullable, strict_raw_type

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';

class KeihiSettingAlert extends ConsumerWidget {
  KeihiSettingAlert({super.key, required this.id, required this.str});

  final int id;
  final String str;

  final Utility _utility = Utility();

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

              Container(
                width: context.screenSize.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.yellowAccent.withOpacity(0.6)),
                  color: Colors.yellowAccent.withOpacity(0.1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(str.split('|')[0]),
                    Text(str.split('|')[1]),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(str.split('|')[2]),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  IconButton(
                    onPressed: () {
                      print(id);
                    },
                    icon: Icon(
                      Icons.input,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Expanded(
                child: FutureBuilder(
                  future: getCsvData(path: 'assets/csv/money_classify.csv'),
                  builder: (context, snapshot) {
                    final list = snapshot.data as List<CsvData>;

                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

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
  Future<List<CsvData>> getCsvData({required String path}) async {
    final list = <CsvData>[];

    final csv = await rootBundle.loadString(path);

    for (final line in csv.split('\n')) {
      final List rows = line.split(',');

      final rowData = CsvData(
          category1: rows[0].toString(),
          category2: rows[1].toString(),
          explanation: rows[2].toString());

      list.add(rowData);
    }

    return list;
  }

  ///
  Widget displayCategoryList({required List<CsvData> data}) {
    final list = <Widget>[];

    data.forEach((element) {
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
            children: [
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(element.category1)),
                        Expanded(child: Text(element.category2)),
                      ],
                    ),
                    Text(element.explanation),
                  ],
                ),
              ),
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

class CsvData {
  CsvData({
    required this.category1,
    required this.category2,
    required this.explanation,
  });

  String category1;
  String category2;
  String explanation;
}
