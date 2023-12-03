// ignore_for_file: must_be_immutable, noop_primitive_operations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/credit/credit_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '_money_dialog.dart';
import 'seiyu_alert.dart';

class CreditAlert extends ConsumerWidget {
  CreditAlert({super.key, required this.date});

  final DateTime date;

  Uuid uuid = const Uuid();

  final Utility _utility = Utility();

  late WidgetRef _ref;
  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;
    _context = context;

    final selectCreditState = ref.watch(selectCreditProvider);

    //
    // final creditSpendMonthlyState = ref.watch(creditSpendMonthlyProvider(date));
    //

    final total = makeTotalPrice();
    final cardList = makeCardList();

    //
    //
    // final total = makeTotalPrice(data: creditSpendMonthlyState);
    //
    //
    //
    //
    //
    //
    // final cardList = makeCardList(data: creditSpendMonthlyState);
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
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
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

                Container(
                  decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  child: Text(date.yyyymm, style: const TextStyle(fontSize: 16)),
                ),
                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.all(10),
                  child: Text(total.toString().toCurrency(), style: const TextStyle(fontSize: 16)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: cardList.map((kind) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                            onTap: () {
                              ref.read(selectCreditProvider.notifier).setSelectCredit(selectCredit: kind);

                              ref
                                  .read(creditSpendMonthlyProvider(date).notifier)
                                  .getCreditSpendMonthly(date: date, kind: kind);
                            },
                            child: getCreditMark(kind: kind),
                          ),
                        );
                      }).toList(),
                    ),
                    Text(selectCreditState),
                  ],
                ),
                const SizedBox(height: 20),
                dispCredit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget dispCredit() {
    final reg = RegExp('西友ネットスーパー');

    final list = <Widget>[];

    final creditSpendMonthlyList =
        _ref.watch(creditSpendMonthlyProvider(date).select((value) => value.creditSpendMonthlyList));

    return creditSpendMonthlyList.when(
      data: (value) {
        for (var i = 0; i < value.length; i++) {
          final bgColor = (value[i].price.toInt() >= 5000) ? Colors.yellowAccent.withOpacity(0.1) : Colors.transparent;

          list.add(
            Container(
              width: _context.screenSize.width,
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
                color: bgColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(value[i].date.yyyymmdd),
                        Text(value[i].item),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (reg.firstMatch(value[i].item) != null)
                                ? GestureDetector(
                                    onTap: () async {
                                      await _ref.read(appParamProvider.notifier).setSeiyuAlertSelectDate(
                                            date: value[i].date.mmdd,
                                          );
                                      //
                                      // await _ref.read(seiyuPurchaseDateProvider.notifier).getSeiyuPurchaseList(
                                      //       date: creditSpendMonthlyState[i].date.yyyymmdd,
                                      //     );
                                      //
                                      //
                                      //
                                      //

                                      await MoneyDialog(
                                        context: _context,
                                        widget: SeiyuAlert(date: value[i].date),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(color: Colors.indigoAccent.withOpacity(0.2)),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      child: const Text(
                                        'data display',
                                        style: TextStyle(color: Colors.lightBlueAccent),
                                      ),
                                    ),
                                  )
                                : Container(),
                            Text(value[i].price.toCurrency()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  getCreditMark(kind: value[i].kind),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(key: PageStorageKey(uuid.v1()), child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*




    for (var i = 0; i < creditSpendMonthlyState.length; i++) {
      final bgColor = (creditSpendMonthlyState[i].price.toInt() >= 5000)
          ? Colors.yellowAccent.withOpacity(0.1)
          : Colors.transparent;

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
            color: bgColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(creditSpendMonthlyState[i].date.yyyymmdd),
                    Text(creditSpendMonthlyState[i].item),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (reg.firstMatch(creditSpendMonthlyState[i].item) != null)
                            ? GestureDetector(
                                onTap: () async {
                                  await _ref.read(appParamProvider.notifier).setSeiyuAlertSelectDate(
                                        date: creditSpendMonthlyState[i].date.mmdd,
                                      );
                                  //
                                  // await _ref.read(seiyuPurchaseDateProvider.notifier).getSeiyuPurchaseList(
                                  //       date: creditSpendMonthlyState[i].date.yyyymmdd,
                                  //     );
                                  //
                                  //
                                  //
                                  //

                                  await MoneyDialog(
                                    context: _context,
                                    widget: SeiyuAlert(
                                      date: creditSpendMonthlyState[i].date,
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.indigoAccent.withOpacity(0.2),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  child: const Text(
                                    'data display',
                                    style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        Text(
                          creditSpendMonthlyState[i].price.toCurrency(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              getCreditMark(kind: creditSpendMonthlyState[i].kind),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      key: PageStorageKey(uuid.v1()),
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

  ///
  int makeTotalPrice() {
    var ret = 0;

//    {required List<CreditSpendMonthly> data}

    final creditSpendMonthlyList =
        _ref.watch(creditSpendMonthlyProvider(date).select((value) => value.creditSpendMonthlyList));

    //
    //
    // for (var i = 0; i < data.length; i++) {
    //   ret += data[i].price.toString().toInt();
    // }
    //
    //

    creditSpendMonthlyList.value?.forEach((element) {
      ret += element.price.toString().toInt();
    });

    return ret;
  }

  ///
  List<String> makeCardList() {
//    {required List<CreditSpendMonthly> data}

    final list = <String>[''];

    final creditSpendMonthlyList =
        _ref.watch(creditSpendMonthlyProvider(date).select((value) => value.creditSpendMonthlyList));

    creditSpendMonthlyList.value?.forEach((element) {
      if (!list.contains(element.kind)) {
        list.add(element.kind);
      }
    });

    //
    //
    // for (var i = 0; i < data.length; i++) {
    //   if (!list.contains(data[i].kind)) {
    //     list.add(data[i].kind);
    //   }
    // }
    //
    //

    return list;
  }
}
