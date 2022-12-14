// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/benefit_notifier.dart';

class BenefitAlert extends ConsumerWidget {
  BenefitAlert({super.key, required this.date});

  final DateTime date;

  Uuid uuid = const Uuid();

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

                // Row(children: yearWidgetList),
                // const SizedBox(height: 20),
                displayBenefit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayBenefit() {
    final list = <Widget>[];

    final benefitState = _ref.watch(benefitProvider);

    //////////////////////////////////////////////
    final yearBenefit = <String, int>{};

    var yb = 0;
    var keepYear = '';
    benefitState.forEach((val) {
      if (keepYear != '${val.ym}-01 00:00:00'.toDateTime().yyyy) {
        yb = 0;
      }

      yb += val.salary.toInt();

      yearBenefit['${val.ym}-01 00:00:00'.toDateTime().yyyy] = yb;

      keepYear = '${val.ym}-01 00:00:00'.toDateTime().yyyy;
    });

    //////////////////////////////////////////////

    keepYear = '';
    for (var i = 0; i < benefitState.length; i++) {
      if (keepYear != '${benefitState[i].ym}-01 00:00:00'.toDateTime().yyyy) {
        list.add(
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              color: Colors.yellowAccent.withOpacity(0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${benefitState[i].ym}-01 00:00:00'.toDateTime().yyyy,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      yearBenefit['${benefitState[i].ym}-01 00:00:00'
                              .toDateTime()
                              .yyyy]
                          .toString(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(benefitState[i].ym)),
              Expanded(
                flex: 2,
                child: Text(benefitState[i].company),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(benefitState[i].salary.toCurrency()),
                ),
              ),
            ],
          ),
        ),
      );

      keepYear = '${benefitState[i].ym}-01 00:00:00'.toDateTime().yyyy;
    }

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }
}
