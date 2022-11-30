/*
http://toyohide.work/BrainLog/api/getEverydayMoney

{
    "data": [
        {
            "date": "2014-06-01",
            "youbiNum": "0",
            "sum": "1370938",
            "spend": "0"
        },
        {
            "date": "2014-06-02",
            "youbiNum": "1",
            "sum": "1357585",
            "spend": "13353"
        },

*/

import '../extensions/extensions.dart';

class MoneyEveryday {
  MoneyEveryday({
    required this.date,
    required this.youbiNum,
    required this.sum,
    required this.spend,
  });

  factory MoneyEveryday.fromJson(Map<String, dynamic> json) => MoneyEveryday(
        date: json['date'].toString().toDateTime(),
        youbiNum: json['youbiNum'].toString(),
        sum: json['sum'].toString(),
        spend: json['spend'].toString(),
      );

  DateTime date;
  String youbiNum;
  String sum;
  String spend;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'youbiNum': youbiNum,
        'sum': sum,
        'spend': spend,
      };
}
