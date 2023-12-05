/*
http://toyohide.work/BrainLog/api/balanceSheetRecord

{
    "data": [
        {
            "ym": "2020-01",
            "assets_total": 1065122,
            "capital_total": 1065122,
            "assets": {
                "assets_total_deposit_start": 232856,
                "assets_total_deposit_debit": 1010000,
                "assets_total_deposit_credit": 436184,
                "assets_total_deposit_end": 806672,
                "assets_total_receivable_start": 710000,
                "assets_total_receivable_debit": 0,
                "assets_total_receivable_credit": 710000,
                "assets_total_receivable_end": 0,
                "assets_total_fixed_start": 156750,
                "assets_total_fixed_debit": 0,
                "assets_total_fixed_credit": 0,
                "assets_total_fixed_end": 156750,
                "assets_total_lending_start": 0,
                "assets_total_lending_debit": 101700,
                "assets_total_lending_credit": 0,
                "assets_total_lending_end": 101700
            },
            "capital": {
                "capital_total_liabilities_start": 0,
                "capital_total_liabilities_debit": 0,
                "capital_total_liabilities_credit": 0,
                "capital_total_liabilities_end": 0,
                "capital_total_borrow_start": 0,
                "capital_total_borrow_debit": 0,
                "capital_total_borrow_credit": 46342,
                "capital_total_borrow_end": 46342,
                "capital_total_principal_start": 1099606,
                "capital_total_principal_debit": 0,
                "capital_total_principal_credit": 0,
                "capital_total_principal_end": 1099606,
                "capital_total_income_start": 0,
                "capital_total_income_debit": 0,
                "capital_total_income_credit": -80826,
                "capital_total_income_end": -80826
            }
        },

*/

import '../extensions/extensions.dart';

class Balancesheet {
  Balancesheet({
    required this.ym,
    required this.assetsTotal,
    required this.capitalTotal,
    required this.assets,
    required this.capital,
  });

  factory Balancesheet.fromJson(Map<String, dynamic> json) => Balancesheet(
        ym: json['ym'].toString(),
        assetsTotal: json['assets_total'].toString().toInt(),
        capitalTotal: json['capital_total'].toString().toInt(),
        assets: Map.from(json['assets'] as Map<dynamic, dynamic>).map(
          (k, v) => MapEntry<String, int>(k.toString(), v.toString().toInt()),
        ),
        capital: Map.from(json['capital'] as Map<dynamic, dynamic>).map(
          (k, v) => MapEntry<String, int>(k.toString(), v.toString().toInt()),
        ),
      );

  String ym;
  int assetsTotal;
  int capitalTotal;
  Map<String, int> assets;
  Map<String, int> capital;

  Map<String, dynamic> toJson() => {
        'ym': ym,
        'assets_total': assetsTotal,
        'capital_total': capitalTotal,
        'assets': Map.from(assets).map((k, v) => MapEntry<String, dynamic>(k.toString(), v)),
        'capital': Map.from(capital).map((k, v) => MapEntry<String, dynamic>(k.toString(), v)),
      };
}
