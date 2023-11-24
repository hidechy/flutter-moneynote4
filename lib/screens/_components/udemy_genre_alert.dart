// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/udemy/udemy_notifier.dart';
import 'pages/udemy_page.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class UdemyGenreAlert extends ConsumerWidget {
  UdemyGenreAlert({super.key, required this.date});

  final DateTime date;

  List<TabInfo> tabs = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeTab();

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
              isScrollable: true,
              indicatorColor: Colors.blueAccent,
              tabs: tabs.map((TabInfo tab) => Tab(text: tab.label)).toList(),
            ),
          ),
        ),
        body: TabBarView(
          children: tabs.map((tab) => tab.widget).toList(),
        ),
      ),
    );
  }

  ///
  void makeTab() {
    tabs = [];

    final list = <String>[];

    final udemyList = _ref.watch(udemyProvider.select((value) => value.udemyList));

    udemyList.value?.forEach((element) {
      if (date.year == DateTime.parse('${element.date} 00:00:00').year) {
        if (!list.contains(element.category)) {
          list.add(element.category);
        }
      }
    });

    //
    // udemyState.forEach((element) {
    //   if (date.year == '${element.date} 00:00:00'.toDateTime().year) {
    //     if (!list.contains(element.category)) {
    //       list.add(element.category);
    //     }
    //   }
    // });
    //
    //
    //

    list
      ..sort((a, b) => a.compareTo(b))
      ..forEach((element) {
        tabs.add(
          TabInfo(
            element,
            UdemyPage(
              date: date,
              category: element,
            ),
          ),
        );
      });
  }
}
