/*
http://toyohide.work/BrainLog/api/everydaySpendSearch
{"date":"2022-01-01"}

{
    "data": [
        {
            "date": "2022-01-01",
            "spend": 22855,
            "record": "10:10|大洗|200|x/11:00|大洗|100|x/11:05|大洗|100|x/17:20|移動中|308|x/18:26|荻窪|5289|x/18:40|移動中|220|x/-|mercari|16638|x/-|ヤマハ年会費 [uc card]|1320|x/-|カード年会費 [uc card]|1375|x/-|VULTR [rakuten]| 1288|x/-|PATREON [rakuten]| 1054|x/-|schooWEB-campus [rakuten]| 980|x/-|楽天ブロードバンド [rakuten]| 4180|x",
            "diff": 0,
            "step": "7954",
            "distance": "5300"
        },

*/

import '../extensions/extensions.dart';

class MoneyMonthlySpend {
  MoneyMonthlySpend({
    required this.date,
    required this.spend,
    required this.record,
    required this.diff,
    required this.step,
    required this.distance,
  });

  factory MoneyMonthlySpend.fromJson(Map<String, dynamic> json) =>
      MoneyMonthlySpend(
        date: json['date'].toString().toDateTime(),
        spend: json['spend'].toString().toInt(),
        record: json['record'].toString(),
        diff: json['diff'].toString().toInt(),
        step: json['step'].toString(),
        distance: json['distance'].toString(),
      );

  DateTime date;
  int spend;
  String record;
  int diff;
  String step;
  String distance;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'spend': spend,
        'record': record,
        'diff': diff,
        'step': step,
        'distance': distance,
      };
}
