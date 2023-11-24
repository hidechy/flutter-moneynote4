// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/udemy/udemy_notifier.dart';
import '../../../utility/utility.dart';
import '../_parts/udemy_box.dart';

class UdemyPage extends ConsumerWidget {
  UdemyPage({super.key, required this.date, required this.category});

  final DateTime date;
  final String category;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(width: context.screenSize.width),

            //----------//
            if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
            //----------//

            Expanded(
              child: displayUdemy(),
            ),
          ],
        ),
      ),
    );
  }

  ///
  Widget displayUdemy() {
    final udemyList = _ref.watch(udemyProvider.select((value) => value.udemyList));

    return udemyList.when(
      data: (value) {
        final list = <Widget>[];

        value
          ..sort((a, b) => a.date.compareTo(b.date))
          ..forEach((element) {
            if (date.year == '${element.date} 00:00:00'.toDateTime().year) {
              if (element.category == category) {
                list.add(UdemyBox(udemy: element));
              }
            }
          });

        return SingleChildScrollView(
          child: DefaultTextStyle(style: const TextStyle(fontSize: 10), child: Column(children: list)),
        );
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*




    final list = <Widget>[];

    _ref.watch(udemyProvider)
      ..sort((a, b) => a.date.compareTo(b.date))
      ..forEach((element) {
        if (date.year == '${element.date} 00:00:00'.toDateTime().year) {
          if (element.category == category) {
            list.add(UdemyBox(udemy: element));
          }
        }
      });

    return SingleChildScrollView(
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10),
        child: Column(children: list),
      ),
    );




    */
  }
}
