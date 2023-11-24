// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/wells/wells_reserve_notifier.dart';
import '../../../utility/utility.dart';

class WellsReservePage extends ConsumerWidget {
  WellsReservePage({super.key, required this.date});

  final DateTime date;

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

              Expanded(
                child: displayWellsReserve(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayWellsReserve() {
    final wellsList = _ref.watch(wellsReserveProvider.select((value) => value.wellsList));

    return wellsList.when(
      data: (value) {
        final list = <Widget>[];

        for (var i = 0; i < value.length; i++) {
          list.add(
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
              child: Row(
                children: [
                  Expanded(child: Text(value[i].num)),
                  Expanded(child: Text(value[i].date.yyyymmdd)),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(value[i].price.toCurrency()),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(value[i].total.toCurrency()),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*


    final wellsReserveState = _ref.watch(wellsReserveProvider);

    final list = <Widget>[];

    for (var i = 0; i < wellsReserveState.length; i++) {
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
          child: Row(
            children: [
              Expanded(
                child: Text(wellsReserveState[i].num),
              ),
              Expanded(
                child: Text(wellsReserveState[i].date.yyyymmdd),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(wellsReserveState[i].price.toCurrency()),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(wellsReserveState[i].total.toCurrency()),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(children: list),
    );



    */
  }
}
