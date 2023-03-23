// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/amazon_notifier.dart';

class AmazonAlert extends HookConsumerWidget {
  AmazonAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Uuid uuid = const Uuid();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final yearWidgetList = makeYearWidgetList();

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
                displayAmazonPurchase(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  List<Widget> makeYearWidgetList() {
    final AmazonAlertSelectYear = _ref.watch(
      appParamProvider.select((value) => value.AmazonAlertSelectYear),
    );

    final yearList = <Widget>[];
    for (var i = date.yyyy.toInt(); i >= 2020; i--) {
      yearList.add(
        GestureDetector(
          onTap: () {
            _ref
                .watch(appParamProvider.notifier)
                .setAmazonAlertSelectYear(year: i);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: (i == AmazonAlertSelectYear)
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
  Widget displayAmazonPurchase() {
    final AmazonAlertSelectYear = _ref.watch(
      appParamProvider.select((value) => value.AmazonAlertSelectYear),
    );

    final amazonPurchaseState = _ref.watch(
      amazonPurchaseProvider(DateTime(AmazonAlertSelectYear)),
    );

    final list = <Widget>[];

    amazonPurchaseState.forEach((element) {
      final month = DateTime.parse(element.date).mm;

      list.add(
        Container(
          width: _context.screenSize.width,
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
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.8)),
                  color: _utility.getLeadingBgColor(month: month),
                ),
                child: Text(month),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(element.item),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Row(
                          children: [
                            Text(element.price.toCurrency()),
                            const SizedBox(width: 10),
                            const Text('/'),
                            const SizedBox(width: 10),
                            Text(element.date),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });

    return SingleChildScrollView(
      key: PageStorageKey(uuid.v1()),
      child: Column(
        children: list,
      ),
    );
  }
}
