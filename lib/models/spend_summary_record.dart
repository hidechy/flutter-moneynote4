/*
http://toyohide.work/BrainLog/api/getYearSpendSummaySummary
{"year":2022}

{
    "data": [
        {
            "item": "食費",
            "list": [
                {
                    "month": "01",
                    "price": 11155
                },
                {
                    "month": "02",
                    "price": 8971
                },

*/

import '../extensions/extensions.dart';

class SpendSummaryRecord {
  SpendSummaryRecord({
    required this.month,
    required this.price,
  });

  factory SpendSummaryRecord.fromJson(Map<String, dynamic> json) =>
      SpendSummaryRecord(
        month: json['month'].toString(),
        price: json['price'].toString().toInt(),
      );

  String month;
  int price;

  Map<String, dynamic> toJson() => {
        'month': month,
        'price': price,
      };
}
