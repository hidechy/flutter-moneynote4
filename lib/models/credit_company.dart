// ignore_for_file: avoid_dynamic_calls, inference_failure_on_untyped_parameter

/*
http://toyohide.work/BrainLog/api/getcompanycredit
{"date":"2022-11-01"}

{
    "data": [
        {
            "ym": "2022-01",
            "list": [
                {
                    "company": "uc",
                    "sum": 21974
                },
                {
                    "company": "rakuten",
                    "sum": 83056
                },
                {
                    "company": "sumitomo",
                    "sum": 0
                },
                {
                    "company": "amex",
                    "sum": 0
                }
            ]
        },

*/

import 'credit_company_record.dart';

class CreditCompany {
  CreditCompany({
    required this.ym,
    required this.list,
  });

  factory CreditCompany.fromJson(Map<String, dynamic> json) => CreditCompany(
        ym: json['ym'].toString(),
        list: List<CreditCompanyRecord>.from(json['list'].map(
                (x) => CreditCompanyRecord.fromJson(x as Map<String, dynamic>))
            as Iterable),
      );

  String ym;
  List<CreditCompanyRecord> list;

  Map<String, dynamic> toJson() => {
        'ym': ym,
        'list': List<dynamic>.from(list.map((x) => x.toJson())),
      };
}
