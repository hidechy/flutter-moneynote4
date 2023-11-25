// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/benefit/benefit_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';

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
                if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
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

    //////////////////////////////////////////////
    final yearBenefit = <String, int>{};

    var yb = 0;
    var keepYear = '';

    final benefitList = _ref.watch(benefitProvider.select((value) => value.benefitList));

    benefitList.value?.forEach((element) {
      if (keepYear != DateTime(element.ym.split('-')[0].toInt(), element.ym.split('-')[1].toInt()).yyyy) {
        yb = 0;
      }

      yb += element.salary.toInt();

      yearBenefit[DateTime(element.ym.split('-')[0].toInt(), element.ym.split('-')[1].toInt()).yyyy] = yb;

      keepYear = DateTime(element.ym.split('-')[0].toInt(), element.ym.split('-')[1].toInt()).yyyy;
    });

    //
    //
    //
    // final benefitState = _ref.watch(benefitProvider);
    //
    // benefitState.benefitList.forEach((val) {
    //   if (keepYear !=
    //       DateTime(
    //         val.ym.split('-')[0].toInt(),
    //         val.ym.split('-')[1].toInt(),
    //       ).yyyy) {
    //     yb = 0;
    //   }
    //
    //   yb += val.salary.toInt();
    //
    //   yearBenefit[DateTime(
    //     val.ym.split('-')[0].toInt(),
    //     val.ym.split('-')[1].toInt(),
    //   ).yyyy] = yb;
    //
    //   keepYear = DateTime(
    //     val.ym.split('-')[0].toInt(),
    //     val.ym.split('-')[1].toInt(),
    //   ).yyyy;
    // });
    //
    //
    //
    //

    //////////////////////////////////////////////

    keepYear = '';

    return benefitList.when(
      data: (value) {
        value.forEach((element) {
          if (keepYear != DateTime(element.ym.split('-')[0].toInt(), element.ym.split('-')[1].toInt()).yyyy) {
            list.add(
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
                  color: Colors.yellowAccent.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(DateTime(element.ym.split('-')[0].toInt(), element.ym.split('-')[1].toInt()).yyyy),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          yearBenefit[DateTime(element.ym.split('-')[0].toInt(), element.ym.split('-')[1].toInt()).yyyy]
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
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(element.ym)),
                  Expanded(flex: 2, child: Text(element.company)),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(element.salary.toCurrency()),
                    ),
                  ),
                ],
              ),
            ),
          );

          keepYear = DateTime(element.ym.split('-')[0].toInt(), element.ym.split('-')[1].toInt()).yyyy;
        });

        return SingleChildScrollView(child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*

    benefitState.benefitList.forEach((element) {
      if (keepYear !=
          DateTime(
            element.ym.split('-')[0].toInt(),
            element.ym.split('-')[1].toInt(),
          ).yyyy) {
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
                  child: Text(DateTime(
                    element.ym.split('-')[0].toInt(),
                    element.ym.split('-')[1].toInt(),
                  ).yyyy),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      yearBenefit[DateTime(
                        element.ym.split('-')[0].toInt(),
                        element.ym.split('-')[1].toInt(),
                      ).yyyy]
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
              Expanded(child: Text(element.ym)),
              Expanded(
                flex: 2,
                child: Text(element.company),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(element.salary.toCurrency()),
                ),
              ),
            ],
          ),
        ),
      );

      keepYear = DateTime(
        element.ym.split('-')[0].toInt(),
        element.ym.split('-')[1].toInt(),
      ).yyyy;
    });

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );




    */
  }
}
