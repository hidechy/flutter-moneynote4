/*
http://toyohide.work/BrainLog/api/getFund

{
    "data": [
        {
            "name": "eMAXIS　Slim　米国株式（S&P500）(三菱ＵＦＪ国際投信)",
            "record": [
                {
                    "date": "2022-01-04",
                    "base_price": "19291",
                    "compare_front": "+87円(+0.45％)",
                    "yearly_return": "44.52％",
                    "flag": "1"
                },

*/

// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter

import 'fund_record.dart';

class Fund {
  Fund({
    required this.name,
    required this.record,
  });

  factory Fund.fromJson(Map<String, dynamic> json) => Fund(
        name: json['name'].toString(),
        record: List<FundRecord>.from(json['record']
                .map((x) => FundRecord.fromJson(x as Map<String, dynamic>))
            as Iterable),
      );

  String name;
  List<FundRecord> record;

  Map<String, dynamic> toJson() => {
        'name': name,
        'record': List<dynamic>.from(record.map((x) => x.toJson())),
      };
}
