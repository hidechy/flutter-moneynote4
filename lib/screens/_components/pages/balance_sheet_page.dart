// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../models/balancesheet.dart';
import '../../../state/balance_sheet/balance_sheet_notifier.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../utility/utility.dart';

class BalanceSheetPage extends ConsumerWidget {
  BalanceSheetPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

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

              Expanded(child: displayBalanceSheet()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayBalanceSheet() {
    final balanceSheetList = _ref.watch(balanceSheetProvider(date).select((value) => value.balanceSheetList));

    return balanceSheetList.when(
      data: (value) {
        final list = <Widget>[];

        value.forEach((element) {
          list.add(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(margin: const EdgeInsets.symmetric(vertical: 10), child: Text(element.ym)),
                getAssetsWidget(data: element),
                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(element.assetsTotal.toString().toCurrency()),
                ),
                getCapitalWidget(data: element),
                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(element.capitalTotal.toString().toCurrency()),
                ),
              ],
            ),
          );
        });

        return SingleChildScrollView(child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  //
  Widget getAssetsWidget({required Balancesheet data}) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.3),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10),
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
                      child: Text(data.assets['assets_total_deposit_start'].toString().toCurrency()),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('+ ${data.assets['assets_total_deposit_debit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('- ${data.assets['assets_total_deposit_credit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('= ${data.assets['assets_total_deposit_end'].toString().toCurrency()}'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Text('【売掛債権合計】'),
            Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(data.assets['assets_total_receivable_start'].toString().toCurrency()),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('+ ${data.assets['assets_total_receivable_debit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('- ${data.assets['assets_total_receivable_credit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('= ${data.assets['assets_total_receivable_end'].toString().toCurrency()}'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Text('【有形固定資産合計】'),
            Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(data.assets['assets_total_fixed_start'].toString().toCurrency()),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('+ ${data.assets['assets_total_fixed_debit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('- ${data.assets['assets_total_fixed_credit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('= ${data.assets['assets_total_fixed_end'].toString().toCurrency()}'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Text('【事業主貸合計】'),
            Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(data.assets['assets_total_lending_start'].toString().toCurrency()),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('+ ${data.assets['assets_total_lending_debit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('- ${data.assets['assets_total_lending_credit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('= ${data.assets['assets_total_lending_end'].toString().toCurrency()}'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Text('【仮払消費税】'),
            Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(data.assets['assets_consumption_tax_start'].toString().toCurrency()),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('+ ${data.assets['assets_consumption_tax_debit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('- ${data.assets['assets_consumption_tax_credit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('= ${data.assets['assets_consumption_tax_end'].toString().toCurrency()}'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
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
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10),
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
                      child: Text(data.capital['capital_total_liabilities_start'].toString().toCurrency()),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('- ${data.capital['capital_total_liabilities_debit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('+ ${data.capital['capital_total_liabilities_credit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('= ${data.capital['capital_total_liabilities_end'].toString().toCurrency()}'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Text('【事業主借合計】'),
            Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(data.capital['capital_total_borrow_start'].toString().toCurrency()),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('- ${data.capital['capital_total_borrow_debit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('+ ${data.capital['capital_total_borrow_credit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('= ${data.capital['capital_total_borrow_end'].toString().toCurrency()}'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Text('【元入金】'),
            Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(data.capital['capital_total_principal_start'].toString().toCurrency()),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('- ${data.capital['capital_total_principal_debit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('+ ${data.capital['capital_total_principal_credit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('= ${data.capital['capital_total_principal_end'].toString().toCurrency()}'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Text('【控除前所得合計】'),
            Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(data.capital['capital_total_income_start'].toString().toCurrency()),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('- ${data.capital['capital_total_income_debit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('+ ${data.capital['capital_total_income_credit'].toString().toCurrency()}'),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text('= ${data.capital['capital_total_income_end'].toString().toCurrency()}'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
