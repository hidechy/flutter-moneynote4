// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/seiyu_purchase/seiyu_purchase_notifier.dart';
import '../../state/seiyu_purchase/seiyu_purchase_request_state.dart';
import '../../utility/utility.dart';

class SeiyuItemAlert extends ConsumerWidget {
  SeiyuItemAlert({super.key, required this.date, required this.item});

  final DateTime date;
  final String item;

  final Utility _utility = Utility();

  Map<String, String> seiyuItemPhotoMap = {};

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    getSeiyuItemPhotoMap();

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

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (seiyuItemPhotoMap[item] != null)
                      SizedBox(
                        width: 60,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/no_image.png',
                          image: seiyuItemPhotoMap[item]!,
                          imageErrorBuilder: (c, o, s) => Image.asset('assets/images/no_image.png'),
                        ),
                      ),
                    if (seiyuItemPhotoMap[item] == null)
                      SizedBox(
                        width: 60,
                        child: Image.asset('assets/images/no_image.png'),
                      ),
                    const SizedBox(width: 20),
                    Expanded(child: Text(item))
                  ],
                ),

                const SizedBox(height: 20),
                displaySeiyuItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  void getSeiyuItemPhotoMap() {
    for (var i = 2020; i < DateTime.now().year; i++) {
      // _ref.watch(seiyuAllProvider(DateTime(i))).forEach((element) {
      //   seiyuItemPhotoMap[element.item] = element.img;
      // });
      //
      //
      //

      final seiyuPurchaseList = _ref.watch(seiyuAllProvider(DateTime(i)).select((value) => value.seiyuPurchaseList));

      seiyuPurchaseList.value?.forEach((element) => seiyuItemPhotoMap[element.item] = element.img);
    }
  }

  ///
  Widget displaySeiyuItem() {
    final list = <Widget>[];

    //forで仕方ない
    for (var i = 2020; i <= date.year; i++) {
      final param = SeiyuPurchaseRequestState(date: DateTime(i), item: item);

      final seiyuItemList = _ref.watch(seiyuPurchaseItemProvider(param).select((value) => value.seiyuItemList));

      seiyuItemList.value?.forEach((element) {
        element.list.forEach((element2) {
          final exValue = element2.split('|');

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
                  Expanded(child: Text(exValue[0])),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(exValue[1].toCurrency()),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(exValue[2]),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(exValue[3].toCurrency()),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });

      /*




      final seiyuPurchaseItemState = _ref.watch(seiyuPurchaseItemProvider(param));

      seiyuPurchaseItemState.forEach((element) {
        element.list.forEach((element2) {
          final exValue = element2.split('|');

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
                  Expanded(child: Text(exValue[0])),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(exValue[1].toCurrency()),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(exValue[2]),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(exValue[3].toCurrency()),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });



      */
    }

    return SingleChildScrollView(child: Column(children: list));
  }
}
