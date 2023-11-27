import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../route/routes.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/keihi_list/keihi_list_notifier.dart';
import '../../state/monthly_spend_check/monthly_spend_check_notifier.dart';
import '../../utility/utility.dart';

// ignore: must_be_immutable
class KeihiSettingAlert extends ConsumerWidget {
  KeihiSettingAlert({super.key, required this.id, required this.str, required this.date});

  final DateTime date;
  final int id;
  final String str;

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final deviceInfoState = ref.read(deviceInfoProvider);

    final selectedCategory = ref.watch(monthlySpendCheckProvider(date).select((value) => value.selectedCategory));

    final errorMsg = ref.watch(monthlySpendCheckProvider(date).select((value) => value.errorMsg));

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
              if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              Container(
                width: context.screenSize.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellowAccent.withOpacity(0.6)),
                  color: Colors.yellowAccent.withOpacity(0.1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(id.toString()),
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
                  Text(
                    errorMsg.toString(),
                    style: const TextStyle(color: Colors.yellowAccent),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (selectedCategory == '') {
                        await ref.read(monthlySpendCheckProvider(date).notifier).setErrorMsg(error: 'no category set');

                        return;
                      }

                      await ref.read(monthlySpendCheckProvider(date).notifier).updateKeihiCategory(id: id);

                      await ref.read(monthlySpendCheckProvider(date).notifier).getSpendCheckItem(date: date);

                      await ref.read(keihiListProvider(date).notifier).getKeihiList(date: date);

                      if (context.mounted) {
                        context.goNamed(RouteNames.home);
                      }
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
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final list = snapshot.data!;
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
      final rows = line.split(',');

      final rowData = CsvData(category1: rows[0], category2: rows[1], explanation: rows[2]);

      list.add(rowData);
    }

    return list;
  }

  ///
  Widget displayCategoryList({required List<CsvData> data}) {
    final list = <Widget>[];

    final selectedCategory = _ref.watch(monthlySpendCheckProvider(date).select((value) => value.selectedCategory));

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
            color: (selectedCategory == '${element.category1}|${element.category2}')
                ? Colors.yellowAccent.withOpacity(0.2)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => _ref
                    .read(monthlySpendCheckProvider(date).notifier)
                    .setSelectCategory(category: '${element.category1}|${element.category2}'),
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
                    Text(element.category1),
                    Text(
                      element.category2,
                      style: const TextStyle(fontSize: 16),
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
