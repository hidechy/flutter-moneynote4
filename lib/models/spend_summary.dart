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

// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter

import 'spend_summary_record.dart';

class SpendSummary {
  SpendSummary({
    required this.item,
    required this.list,
  });

  factory SpendSummary.fromJson(Map<String, dynamic> json) => SpendSummary(
        item: json['item'].toString(),
        list: List<SpendSummaryRecord>.from(json['list'].map(
                (x) => SpendSummaryRecord.fromJson(x as Map<String, dynamic>))
            as Iterable),
      );

  String item;
  List<SpendSummaryRecord> list;

  Map<String, dynamic> toJson() => {
        'item': item,
        'list': List<dynamic>.from(list.map((x) => x.toJson())),
      };
}
