// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/mercari_record/mercari_record_notifier.dart';
import '../../utility/utility.dart';

class MercariRecordAlert extends ConsumerWidget {
  MercariRecordAlert({super.key, required this.date});

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

                displayMercari(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayMercari() {
    final mercariRecordList = _ref.watch(mercariRecordProvider.select((value) => value.mercariRecordList));

    return mercariRecordList.when(
      data: (value) {
        final list = <Widget>[];

        for (var i = 0; i < value.length; i++) {
          final exSettlement = value[i].settlement.toString().split(':');

          if (value[i].buySell == 'sell') {
            final exDeparture = value[i].departure.toString().split(':');

            list.add(
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 40, child: getMercariMark(mark: value[i].buySell)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(value[i].date.yyyymmdd),
                          Text(value[i].title),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  Text(value[i].price.toString().toCurrency()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [Container(), Text(exDeparture[0])],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [Container(), Text(exSettlement[0])],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  Row(
                                    children: [
                                      Text(value[i].cellPrice.toString()),
                                      const SizedBox(width: 10),
                                      const Text('-'),
                                      const SizedBox(width: 10),
                                      Text(value[i].tesuuryou.toString()),
                                      const SizedBox(width: 10),
                                      const Text('-'),
                                      const SizedBox(width: 10),
                                      Text(value[i].shippingFee.toString()),
                                    ],
                                  ),
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
          } else {
            final exReceive = value[i].receive.toString().split(':');

            list.add(
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40,
                      child: getMercariMark(mark: value[i].buySell),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(value[i].date.yyyymmdd),
                          Text(value[i].title),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  Text(value[i].price.toString().toCurrency()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [Container(), Text(exSettlement[0])],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [Container(), Text(exReceive[0])],
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
          }
        }

        return SingleChildScrollView(child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*
    final mercariState = _ref.watch(mercariRecordProvider);

    for (var i = 0; i < mercariState.length; i++) {
      final exSettlement = mercariState[i].settlement.toString().split(':');

      if (mercariState[i].buySell == 'sell') {
        final exDeparture = mercariState[i].departure.toString().split(':');

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40,
                  child: getMercariMark(mark: mercariState[i].buySell),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(mercariState[i].date.yyyymmdd),
                      Text(mercariState[i].title),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Text(mercariState[i].price.toString().toCurrency()),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Text(exDeparture[0]),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Text(exSettlement[0]),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Row(
                                children: [
                                  Text(mercariState[i].cellPrice.toString()),
                                  const SizedBox(width: 10),
                                  const Text('-'),
                                  const SizedBox(width: 10),
                                  Text(mercariState[i].tesuuryou.toString()),
                                  const SizedBox(width: 10),
                                  const Text('-'),
                                  const SizedBox(width: 10),
                                  Text(mercariState[i].shippingFee.toString()),
                                ],
                              ),
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
      } else {
        final exReceive = mercariState[i].receive.toString().split(':');

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40,
                  child: getMercariMark(mark: mercariState[i].buySell),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(mercariState[i].date.yyyymmdd),
                      Text(mercariState[i].title),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Text(mercariState[i].price.toString().toCurrency()),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Text(exSettlement[0]),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Text(exReceive[0]),
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
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );




    */
  }

  ///
  Widget getMercariMark({required String mark}) {
    switch (mark) {
      case 'sell':
        return const Icon(
          Icons.arrow_upward,
          color: Colors.greenAccent,
        );
      case 'buy':
      default:
        return const Icon(
          Icons.arrow_downward,
          color: Colors.redAccent,
        );
    }
  }
}
