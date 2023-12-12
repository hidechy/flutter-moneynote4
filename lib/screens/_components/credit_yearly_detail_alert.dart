// ignore_for_file: must_be_immutable, depend_on_referenced_packages, cascade_invocations

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '_money_dialog.dart';
import 'credit_yearly_list_alert.dart';
import 'pages/credit_yearly_detail_page.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class CreditYearlyDetailAlert extends HookConsumerWidget {
  CreditYearlyDetailAlert({super.key, required this.date});

  final DateTime date;

  List<TabInfo> tabs = [];

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    makeTab();

    // 最初に開くタブを指定する
    final tabController = useTabController(initialLength: tabs.length);
    tabController.index = (date.year == DateTime.now().year && date.month != 12) ? 1 : 0;
    // 最初に開くタブを指定する

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            backgroundColor: Colors.transparent,

            centerTitle: true,

            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date.year.toString(),
                  style: const TextStyle(fontSize: 12),
                ),
                GestureDetector(
                  onTap: () {
                    MoneyDialog(
                      context: context,
                      widget: CreditYearlyListAlert(date: date),
                    );
                  },
                  child: const Icon(Icons.list),
                ),
              ],
            ),

            //-------------------------//これを消すと「←」が出てくる（消さない）
            leading: const Icon(
              Icons.check_box_outline_blank,
              color: Colors.transparent,
            ),
            //-------------------------//これを消すと「←」が出てくる（消さない）

            bottom: TabBar(
              //================================//
              controller: tabController,
              //================================//

              isScrollable: true,
              indicatorColor: Colors.blueAccent,
              tabs: tabs.map((TabInfo tab) => Tab(text: tab.label)).toList(),
            ),
          ),
        ),
        body: TabBarView(
          //================================//
          controller: tabController,
          //================================//

          children: tabs.map((tab) => tab.widget).toList(),
        ),
      ),
    );
  }

  ///
  void makeTab() {
    tabs = [];

    final list = <int>[];

    final now = DateTime.now();

    if (date.year == now.year) {
      final max = (now.month + 1 > 12) ? 12 : now.month + 1;

      for (var i = 1; i <= max; i++) {
        list.add(i);
      }
    } else {
      for (var i = 1; i <= 12; i++) {
        list.add(i);
      }
    }

    list
      ..sort((a, b) => -1 * a.compareTo(b))
      ..forEach((element) {
        tabs.add(
          TabInfo(
            element.toString().padLeft(2, '0'),
            CreditYearlyDetailPage(
              date: DateTime(date.year, element),
            ),
          ),
        );
      });
  }
}
