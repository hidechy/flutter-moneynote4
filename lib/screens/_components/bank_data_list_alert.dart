// ignore_for_file: must_be_immutable, use_named_constants, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tab_container/tab_container.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import 'pages/bank_data_list_page.dart';

class BankTabData {
  BankTabData(this.name, this.color);

  String name;
  Color color;
}

class BankDataListAlert extends ConsumerWidget {
  BankDataListAlert({super.key});

  final Utility _utility = Utility();

  List<BankTabData> bankDataList = [];

  Map<String, String> bankNames = {
    'bA': 'bank_a',
    'bB': 'bank_b',
    'bC': 'bank_c',
    'bD': 'bank_d',
    'bE': 'bank_e',
    'pA': 'pay_a',
    'pB': 'pay_b',
    'pC': 'pay_c',
    'pD': 'pay_d',
    'pE': 'pay_e',
  };

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    makeBankTabData();

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

                const Text('Bank & Pay Records.'),

                AspectRatio(
                  aspectRatio: 10 / 23,
                  child: TabContainer(
                    radius: 20,
                    tabCurve: Curves.easeIn,
                    transitionBuilder: (child, animation) {
                      animation = CurvedAnimation(curve: Curves.easeIn, parent: animation);
                      return SlideTransition(
                        position: Tween(begin: const Offset(0.2, 0), end: const Offset(0, 0)).animate(animation),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    selectedTextStyle: const TextStyle(fontSize: 12),
                    unselectedTextStyle: const TextStyle(fontSize: 12),
                    tabs: bankDataList.map((e) => e.name).toList(),
                    children: bankDataList.map((e) => BankDataListPage(name: bankNames[e.name]!)).toList(),
                    colors: bankDataList.map((e) => e.color).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  void makeBankTabData() {
    bankDataList = [];

    ['bA', 'bB', 'bC', 'bD', 'bE', 'pA', 'pB', 'pC', 'pD', 'pE'].forEach((element) {
      bankDataList.add(
        BankTabData(element, Colors.black.withOpacity(0.1)),
      );
    });
  }
}
