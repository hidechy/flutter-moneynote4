// ignore_for_file: must_be_immutable, depend_on_referenced_packages, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/app_param/app_param_notifier.dart';
import '../../state/wells/wells_reserve_notifier.dart';
import 'pages/wells_reserve_page.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class WellsReserveAlert extends HookConsumerWidget {
  WellsReserveAlert({super.key, required this.date});

  final DateTime date;

  List<TabInfo> tabs = [];
  List<int> years = [];

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    makeTab();

    //================================//
    final tabController = useTabController(initialLength: years.length);
    tabController.addListener(() async {
      await ref.read(appParamProvider.notifier).setWellsReserveAlertYear(year: years[tabController.index]);
      await ref.read(wellsReserveProvider.notifier).getWellsReserveNotifier(date: DateTime(years[tabController.index]));
    });
    //================================//

    //================================//
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final WellsReserveAlertYear = ref.read(appParamProvider.select((value) => value.WellsReserveAlertYear));
      if (WellsReserveAlertYear == DateTime.now().year) {
        await ref.read(wellsReserveProvider.notifier).getWellsReserveNotifier(date: DateTime.now());
      }
    });
    //================================//

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
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

    for (var i = 2014; i <= DateTime.now().year; i++) {
      list.add(i);
    }

    list
      ..sort((a, b) => -1 * a.compareTo(b))
      ..forEach((element) {
        tabs.add(
          TabInfo(
            element.toString(),
            WellsReservePage(
              date: DateTime(element),
            ),
          ),
        );

        years.add(element);
      });
  }
}
