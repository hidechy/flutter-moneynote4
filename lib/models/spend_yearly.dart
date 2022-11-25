/*
http://toyohide.work/BrainLog/api/getYearSpend
{"date":"2022-01-01"}

{
    "data": [
        {
            "date": "2022-01-01",
            "spend": 22855,
            "item": [
                {
                    "item": "食費",
                    "price": 200,
                    "flag": 0
                },
                {
                    "item": "交通費",
                    "price": 528,
                    "flag": 0
                },
                {
                    "item": "お賽銭",
                    "price": 200,
                    "flag": 0
                },
                {
                    "item": "交際費",
                    "price": 5289,
                    "flag": 0
                },
                {
                    "item": "メルカリ",
                    "price": 16638,
                    "flag": 0
                }
            ]
        },

*/

// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter

import '../extensions/extensions.dart';

import 'spend_yearly_item.dart';

class SpendYearly {
  SpendYearly({
    required this.date,
    required this.spend,
    required this.item,
  });

  factory SpendYearly.fromJson(Map<String, dynamic> json) => SpendYearly(
        date: json['date'].toString().toDateTime(),
        spend: json['spend'].toString().toInt(),
        item: List<SpendYearlyItem>.from(json['item']
                .map((x) => SpendYearlyItem.fromJson(x as Map<String, dynamic>))
            as Iterable),
      );

  DateTime date;
  int spend;
  List<SpendYearlyItem> item;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'spend': spend,
        'item': List<dynamic>.from(item.map((x) => x.toJson())),
      };
}
