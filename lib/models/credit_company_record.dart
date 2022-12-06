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

import '../extensions/extensions.dart';

class CreditCompanyRecord {
  CreditCompanyRecord({
    required this.company,
    required this.sum,
  });

  factory CreditCompanyRecord.fromJson(Map<String, dynamic> json) =>
      CreditCompanyRecord(
        company: json['company'].toString(),
        sum: json['sum'].toString().toInt(),
      );

  String company;
  int sum;

  Map<String, dynamic> toJson() => {
        'company': company,
        'sum': sum,
      };
}
