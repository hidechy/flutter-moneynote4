import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/train/train_notifier.dart';

class SpendTrainPage extends ConsumerWidget {
  const SpendTrainPage({super.key, required this.date});

  final DateTime date;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainMap = ref.watch(trainProvider.select((value) => value.trainMap));

    return SizedBox(
      width: context.screenSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          (trainMap[date.yyyymmdd] != null)
              ? Text(trainMap[date.yyyymmdd]!.station, style: const TextStyle(fontSize: 10))
              : Container(),
        ],
      ),
    );
  }
}
