// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../utility/utility.dart';
import 'pages/bank_data_list_page.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class BankDataListAlert extends StatelessWidget {
  BankDataListAlert({super.key, required this.flag});

  final String flag;

  final Utility _utility = Utility();

  List<TabInfo> tabs = [];

  ///
  @override
  Widget build(BuildContext context) {
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
        body: TabBarView(children: tabs.map((tab) => tab.widget).toList()),
      ),
    );
  }

  ///
  void makeTab() {
    tabs = [];

    final bankNames = _utility.getBankName();

    final reg = RegExp(flag);

    bankNames.forEach((key, value) {
      if (reg.firstMatch(key) != null) {
        tabs.add(TabInfo(value, BankDataListPage(name: key)));
      }
    });
  }
}
