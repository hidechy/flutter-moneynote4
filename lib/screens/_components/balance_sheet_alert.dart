// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/models/balancesheet.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/balance_sheet_notifier.dart';

class BalanceSheetAlert extends ConsumerWidget {
  BalanceSheetAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final yearWidgetList = makeYearWidgetList();

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
                if (deviceInfoState.model == 'iPhone')
                  _utility.getFileNameDebug(name: runtimeType.toString()),
                //----------//

                Row(children: yearWidgetList),
                const SizedBox(height: 20),

                displayBalanceSheet(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  List<Widget> makeYearWidgetList() {
    final BalanceSheetAlertSelectYear = _ref.watch(
      appParamProvider.select((value) => value.BalanceSheetAlertSelectYear),
    );

    final yearList = <Widget>[];
    for (var i = date.yyyy.toInt(); i >= 2020; i--) {
      yearList.add(
        GestureDetector(
          onTap: () {
            _ref
                .watch(appParamProvider.notifier)
                .setBalanceSheetAlertSelectYear(year: i);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: (i == BalanceSheetAlertSelectYear)
                  ? Colors.yellowAccent.withOpacity(0.2)
                  : null,
            ),
            child: Text(i.toString()),
          ),
        ),
      );
    }

    return yearList;
  }

  ///
  Widget displayBalanceSheet() {
    final list = <Widget>[];

    final BalanceSheetAlertSelectYear = _ref.watch(
      appParamProvider.select((value) => value.BalanceSheetAlertSelectYear),
    );

    final balanceSheetState = _ref.watch(
      balanceSheetProvider(
        '$BalanceSheetAlertSelectYear-01-01 00:00:00'.toDateTime(),
      ),
    );

    for (var i = 0; i < balanceSheetState.length; i++) {
      final data = balanceSheetState[i];

      list.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(data.ym),
            ),
            getAssetsWidget(data: data),
            Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(right: 10),
              child: Text(data.assetsTotal.toString().toCurrency()),
            ),
            getCapitalWidget(data: data),
            Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(right: 10),
              child: Text(data.capitalTotal.toString().toCurrency()),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }

  //
  Widget getAssetsWidget({required Balancesheet data}) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.3),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('【現金及び預金合計】'),
          Table(
            children: [
              TableRow(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(data.assets['assets_total_deposit_start']
                        .toString()
                        .toCurrency()),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '+ ${data.assets['assets_total_deposit_debit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '- ${data.assets['assets_total_deposit_credit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '= ${data.assets['assets_total_deposit_end'].toString().toCurrency()}'),
                  ),
                ],
              ),
            ],
          ),
          const Text('【売掛債権合計】'),
          Table(
            children: [
              TableRow(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(data.assets['assets_total_receivable_start']
                        .toString()
                        .toCurrency()),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '+ ${data.assets['assets_total_receivable_debit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '- ${data.assets['assets_total_receivable_credit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '= ${data.assets['assets_total_receivable_end'].toString().toCurrency()}'),
                  ),
                ],
              ),
            ],
          ),
          const Text('【有形固定資産合計】'),
          Table(
            children: [
              TableRow(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(data.assets['assets_total_fixed_start']
                        .toString()
                        .toCurrency()),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '+ ${data.assets['assets_total_fixed_debit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '- ${data.assets['assets_total_fixed_credit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '= ${data.assets['assets_total_fixed_end'].toString().toCurrency()}'),
                  ),
                ],
              ),
            ],
          ),
          const Text('【事業主貸合計】'),
          Table(
            children: [
              TableRow(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(data.assets['assets_total_lending_start']
                        .toString()
                        .toCurrency()),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '+ ${data.assets['assets_total_lending_debit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '- ${data.assets['assets_total_lending_credit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '= ${data.assets['assets_total_lending_end'].toString().toCurrency()}'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  Widget getCapitalWidget({required Balancesheet data}) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(0.3),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('【流動負債合計】'),
          Table(
            children: [
              TableRow(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(data.capital['capital_total_liabilities_start']
                        .toString()
                        .toCurrency()),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '- ${data.capital['capital_total_liabilities_debit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '+ ${data.capital['capital_total_liabilities_credit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '= ${data.capital['capital_total_liabilities_end'].toString().toCurrency()}'),
                  ),
                ],
              ),
            ],
          ),
          const Text('【事業主借合計】'),
          Table(
            children: [
              TableRow(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(data.capital['capital_total_borrow_start']
                        .toString()
                        .toCurrency()),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '- ${data.capital['capital_total_borrow_debit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '+ ${data.capital['capital_total_borrow_credit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '= ${data.capital['capital_total_borrow_end'].toString().toCurrency()}'),
                  ),
                ],
              ),
            ],
          ),
          const Text('【元入金】'),
          Table(
            children: [
              TableRow(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(data.capital['capital_total_principal_start']
                        .toString()
                        .toCurrency()),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '- ${data.capital['capital_total_principal_debit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '+ ${data.capital['capital_total_principal_credit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '= ${data.capital['capital_total_principal_end'].toString().toCurrency()}'),
                  ),
                ],
              ),
            ],
          ),
          const Text('【控除前所得合計】'),
          Table(
            children: [
              TableRow(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(data.capital['capital_total_income_start']
                        .toString()
                        .toCurrency()),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '- ${data.capital['capital_total_income_debit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '+ ${data.capital['capital_total_income_credit'].toString().toCurrency()}'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                        '= ${data.capital['capital_total_income_end'].toString().toCurrency()}'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
