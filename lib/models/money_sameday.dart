/*
http://toyohide.work/BrainLog/api/getSamedaySpend
{"date":"2022-01-05"}

{
    "data": [
        {
            "ym": "2020-01",
            "sum": 21987
        },

*/

import '../extensions/extensions.dart';

class MoneySameday {
  MoneySameday({
    required this.ym,
    required this.sum,
  });

  factory MoneySameday.fromJson(Map<String, dynamic> json) => MoneySameday(
        ym: json['ym'].toString(),
        sum: json['sum'].toString().toInt(),
      );

  String ym;
  int sum;

  Map<String, dynamic> toJson() => {
        'ym': ym,
        'sum': sum,
      };
}
