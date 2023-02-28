/*
http://toyohide.work/BrainLog/api/yearsummary
{"date":"2022-01-01"}

{
    "data": [
        {
            "item": "食費",
            "sum": 134969,
            "percent": 2
        },

*/

import '../extensions/extensions.dart';

class SpendYearSummary {
  SpendYearSummary({
    required this.item,
    required this.sum,
    required this.percent,
  });

  factory SpendYearSummary.fromJson(Map<String, dynamic> json) =>
      SpendYearSummary(
        item: json['item'].toString(),
        sum: json['sum'].toString().toInt(),
        percent: json['percent'].toString(),
      );

  String item;
  int sum;
  String percent;

  Map<String, dynamic> toJson() => {
        'item': item,
        'sum': sum,
        'percent': percent,
      };
}
