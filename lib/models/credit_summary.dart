/*
http://toyohide.work/BrainLog/api/getYearCreditSummarySummary

{
    "data": [
        {
            "item": "TELASA",
            "list": [
                {
                    "month": "01",
                    "price": 618
                },
                {
                    "month": "02",
                    "price": 618
                },

*/

// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter

import 'credit_summary_record.dart';

class CreditSummary {
  CreditSummary({
    required this.item,
    required this.list,
  });

  factory CreditSummary.fromJson(Map<String, dynamic> json) => CreditSummary(
        item: json['item'].toString(),
        list: List<CreditSummaryRecord>.from(json['list'].map(
                (x) => CreditSummaryRecord.fromJson(x as Map<String, dynamic>))
            as Iterable),
      );

  String item;
  List<CreditSummaryRecord> list;

  Map<String, dynamic> toJson() => {
        'item': item,
        'list': List<dynamic>.from(list.map((x) => x.toJson())),
      };
}
