// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../viewmodel/benefit_notifier.dart';

class BenefitAlert extends ConsumerWidget {
  BenefitAlert({super.key, required this.date});

  final DateTime date;

  Uuid uuid = const Uuid();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

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

    for (var i = 0; i < benefitState.length; i++) {
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
    }

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }
}
