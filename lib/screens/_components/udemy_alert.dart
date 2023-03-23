// ignore_for_file: must_be_immutable, inference_failure_on_collection_literal, non_constant_identifier_names, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/udemy_notifier.dart';
import '_parts/udemy_box.dart';

class UdemyAlert extends ConsumerWidget {
  UdemyAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Uuid uuid = const Uuid();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final yearWidgetList = makeYearWidgetList();

    final categoryWidgetList = makeCategoryWidgetList();

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

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categoryWidgetList,
                  ),
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
  List<Widget> makeYearWidgetList() {
    final UdemyAlertSelectYear = _ref.watch(
      appParamProvider.select((value) => value.UdemyAlertSelectYear),
    );

    final yearList = <Widget>[];
    for (var i = date.yyyy.toInt(); i >= 2019; i--) {
      yearList.add(
        GestureDetector(
          onTap: () {
            _ref
                .watch(appParamProvider.notifier)
                .setUdemyAlertSelectYear(year: i);

            _ref.watch(udemyProvider.notifier).getYearUdemy(year: i);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: (i == UdemyAlertSelectYear)
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

  List<Widget> makeCategoryWidgetList() {
    final UdemyAlertSelectYear = _ref.watch(
      appParamProvider.select((value) => value.UdemyAlertSelectYear),
    );

    final udemyState = _ref.watch(udemyProvider);

    final categoryList = <Widget>[];

    final keepCategory = [];

    udemyState.forEach((element) {
      if (!keepCategory.contains(element.category)) {
        categoryList.add(
          GestureDetector(
            onTap: () {
              _ref.watch(appParamProvider.notifier).setUdemyAlertSelectCategory(
                    category: element.category,
                  );

              _ref.watch(udemyProvider.notifier).getYearCategoryUdemy(
                    year: UdemyAlertSelectYear,
                    category: element.category,
                  );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.5)),
              ),
              child: Text(element.category),
            ),
          ),
        );
      }

      keepCategory.add(element.category);
    });

    return categoryList;
  }

  ///
  Widget displayUdemy() {
    final list = <Widget>[];

    final udemyState = _ref.watch(udemyProvider);

    udemyState.forEach((element) {
      list.add(UdemyBox(udemy: element));
    });

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }
}
