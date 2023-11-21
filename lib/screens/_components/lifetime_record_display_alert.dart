import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import 'pages/lifetime_record_display_page.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

// ignore: must_be_immutable
class LifetimeRecordDisplayAlert extends HookConsumerWidget {
  LifetimeRecordDisplayAlert({super.key, required this.date, this.beforeNextPageIndex});

  final DateTime date;

  final int? beforeNextPageIndex;

  List<TabInfo> tabs = [];

  int dayDiff = 3;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    makeTab();

    // 最初に開くタブを指定する
    final exDate = date.yyyymmdd.split('-');

    var index = (tabs.length >= ((dayDiff * 2) + 1)) ? (tabs.length / 2).floor() : exDate[2].toInt() - 1;

    if (beforeNextPageIndex == 6 || beforeNextPageIndex == 0) {
      index = beforeNextPageIndex!;
    }

    final tabController = useTabController(initialLength: tabs.length);
    if (index != 0) {
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

    final dayDiffStart = dayDiff * -1;

    for (var i = dayDiffStart; i <= dayDiff; i++) {
      final genDate = date.add(Duration(days: i));

      if (genDate.year >= 2023) {
        list.add(genDate.yyyymmdd);
      }
    }

    list.forEach((element) {
      tabs.add(
        TabInfo(
          element,
          LifetimeRecordDisplayPage(date: '$element 00:00:00'.toDateTime()),
        ),
      );
    });
  }
}
