/*
http://toyohide.work/BrainLog/api/monthsummary
{"date":"2022-01-01"}

{
    "data": [
        {
            "item": "食費",
            "sum": 11155,
            "percent": 1
        },

*/

import '../extensions/extensions.dart';

class SpendMonthSummary {
  SpendMonthSummary({
    required this.item,
    required this.sum,
    required this.percent,
  });

  factory SpendMonthSummary.fromJson(Map<String, dynamic> json) =>
      SpendMonthSummary(
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
