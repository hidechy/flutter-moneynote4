// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/seiyu_purchase/seiyu_purchase_notifier.dart';
import '../../../utility/utility.dart';
import '../_money_dialog.dart';
import '../seiyu_item_alert.dart';

class SeiyuPage extends ConsumerWidget {
  SeiyuPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  int total = 0;

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    total = 0;

    final seiyuPurchaseList = _ref.watch(seiyuAllProvider(date).select((value) => value.seiyuPurchaseList));

    seiyuPurchaseList.value?.forEach((element) {
      if (date.yyyymmdd == element.date) {
        total += element.price.toInt();
      }
    });

    //
    // final seiyuAllState = _ref.watch(seiyuAllProvider(date));
    //
    // seiyuAllState.forEach((element) {
    //   if (date.yyyymmdd == element.date) {
    //     total += element.price.toInt();
    //   }
    // });
    //
    //
    //

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

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(total.toString().toCurrency()),
                ],
              ),

              Divider(
                color: Colors.yellowAccent.withOpacity(0.2),
                thickness: 5,
              ),

              const SizedBox(height: 10),

              Expanded(child: displaySeiyuPurchase()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displaySeiyuPurchase() {
    final seiyuPurchaseList = _ref.watch(seiyuAllProvider(date).select((value) => value.seiyuPurchaseList));

    return seiyuPurchaseList.when(
      data: (value) {
        final list = <Widget>[];

        value.forEach((element) {
          if (date.yyyymmdd == element.date) {
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            child: Text(element.date),
                          ),
                          Text(
                            element.item,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Text(element.tanka.toCurrency()),
                              const SizedBox(width: 20),
                              const Text('×'),
                              const SizedBox(width: 20),
                              Text(element.kosuu),
                              const SizedBox(width: 20),
                              const Text('='),
                              const SizedBox(width: 20),
                              Text(element.price.toCurrency()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        MoneyDialog(
                          context: _context,
                          widget: SeiyuItemAlert(date: date, item: element.item),
                        );
                      },
                      icon: Icon(Icons.ac_unit, color: Colors.white.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
            );
          }
        });

        return SingleChildScrollView(
          child: DefaultTextStyle(style: const TextStyle(fontSize: 12), child: Column(children: list)),
        );
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*



    final seiyuAllState = _ref.watch(seiyuAllProvider(date));

    final list = <Widget>[];

    seiyuAllState.forEach((element) {
      if (date.yyyymmdd == element.date) {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(element.date),
                      ),
                      Text(
                        element.item,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Text(element.tanka.toCurrency()),
                          const SizedBox(width: 20),
                          const Text('×'),
                          const SizedBox(width: 20),
                          Text(element.kosuu),
                          const SizedBox(width: 20),
                          const Text('='),
                          const SizedBox(width: 20),
                          Text(element.price.toCurrency()),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    MoneyDialog(
                      context: _context,
                      widget: SeiyuItemAlert(
                        date: date,
                        item: element.item,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.ac_unit,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });

    return SingleChildScrollView(
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 12),
        child: Column(
          children: list,
        ),
      ),
    );





    */
  }
}
