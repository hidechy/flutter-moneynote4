// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import 'pages/monthly_spend_page.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class MonthlySpendAlert extends HookConsumerWidget {
  MonthlySpendAlert({super.key, required this.date, required this.index});

  final DateTime date;
  final int index;

  List<TabInfo> tabs = [];

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    makeTab();

    // 最初に開くタブを指定する
    final tabController = useTabController(initialLength: tabs.length);
    if (index > 0) {
      tabController.index = index;
    }
    // 最初に開くタブを指定する

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
            //-------------------------//これを消すと「←」が出てくる（消さない）
            leading: const Icon(Icons.check_box_outline_blank, color: Colors.transparent),
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

    final list = <String>[];

    final firstDate = DateTime(2020);

    final diff = DateTime.now().difference(firstDate).inDays;

    for (var i = 0; i <= diff; i++) {
      final genDate = firstDate.add(Duration(days: i));

      if (genDate.day == 1) {
        list.add(genDate.yyyymm);
      }
    }

    list
      ..sort((a, b) => -1 * a.compareTo(b))
      ..forEach((element) {
        tabs.add(
          TabInfo(
            element,
            MonthlySpendPage(
              date: DateTime(element.split('-')[0].toInt(), element.split('-')[1].toInt()),
            ),
          ),
        );
      });
  }
}
