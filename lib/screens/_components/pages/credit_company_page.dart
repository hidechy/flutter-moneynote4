// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/credit/credit_notifier.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../utility/utility.dart';

class CreditCompanyPage extends ConsumerWidget {
  CreditCompanyPage({super.key, required this.date});

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

              Expanded(child: displayCreditCompany()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayCreditCompany() {
    final creditCompanyList = _ref.watch(creditCompanyProvider(date).select((value) => value.creditCompanyList));

    return creditCompanyList.when(
      data: (value) {
        final list = <Widget>[];

        value.forEach((element) {
          final list2 = <Widget>[];

          var addList = false;

          element.list.forEach((element2) {
            if (element2.sum.toString().toInt() > 0) {
              addList = true;
            }
          });

          var total = 0;

          if (addList) {
            element.list.forEach((element2) {
              list2.add(
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(element2.company),
                      Row(
                        children: [
                          Text(element2.sum.toString().toCurrency()),
                          const SizedBox(width: 20),
                          getCreditMark(kind: element2.company),
                        ],
                      ),
                    ],
                  ),
                ),
              );

              total += element2.sum;
            });

            list2
              ..add(
                Divider(color: Colors.white.withOpacity(0.3), thickness: 1),
              )
              ..add(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(
                      total.toString().toCurrency(),
                      style: const TextStyle(color: Colors.yellowAccent),
                    ),
                  ],
                ),
              )
              ..add(const SizedBox(height: 30));

            list.add(
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(element.ym),
                    Row(
                      children: [
                        Container(width: 20),
                        Expanded(child: Column(children: list2)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        });

        return SingleChildScrollView(child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*




    final creditCompanyState = _ref.watch(creditCompanyProvider(date));

    final list = <Widget>[];

    creditCompanyState.forEach((element) {
      final list2 = <Widget>[];

      var addList = false;

      element.list.forEach((element2) {
        if (element2.sum.toString().toInt() > 0) {
          addList = true;
        }
      });

      var total = 0;

      if (addList) {
        element.list.forEach((element2) {
          list2.add(
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(element2.company),
                  Row(
                    children: [
                      Text(element2.sum.toString().toCurrency()),
                      const SizedBox(width: 20),
                      getCreditMark(kind: element2.company),
                    ],
                  ),
                ],
              ),
            ),
          );

          total += element2.sum;
        });

        list2
          ..add(
            Divider(
              color: Colors.white.withOpacity(0.3),
              thickness: 1,
            ),
          )
          ..add(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text(
                  total.toString().toCurrency(),
                  style: const TextStyle(color: Colors.yellowAccent),
                ),
              ],
            ),
          )
          ..add(const SizedBox(height: 30));

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(element.ym),
                Row(
                  children: [
                    Container(width: 20),
                    Expanded(
                      child: Column(
                        children: list2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    });

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );




    */
  }

  ///
  Widget getCreditMark({required String kind}) {
    switch (kind) {
      case 'paypay':
        return const Icon(Icons.credit_card, color: Colors.indigo);

      case 'uc':
        return const Icon(Icons.credit_card, color: Colors.redAccent);
      case 'rakuten':
        return const Icon(Icons.credit_card, color: Colors.orangeAccent);
      case 'amex':
        return const Icon(Icons.credit_card, color: Colors.purpleAccent);
      case 'sumitomo':
        return const Icon(Icons.credit_card, color: Colors.greenAccent);
    }

    return const Icon(Icons.credit_card, color: Colors.white);
  }
}
