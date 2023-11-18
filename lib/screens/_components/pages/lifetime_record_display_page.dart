import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../_money_dialog.dart';
import '../lifetime_record_input_alert.dart';

class LifetimeRecordDisplayPage extends ConsumerWidget {
  const LifetimeRecordDisplayPage({super.key, required this.date});

  final DateTime date;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date.yyyymmdd),
                  GestureDetector(
                    onTap: () {
                      MoneyDialog(
                        context: context,
                        widget: LifetimeRecordInputAlert(date: date),
                      );
                    },
                    child: Icon(
                      Icons.input,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
