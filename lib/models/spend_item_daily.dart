// ignore_for_file: inference_failure_on_untyped_parameter, avoid_dynamic_calls
/*
http://toyohide.work/BrainLog/api/getmonthSpendItem
{"date":"2022-10-01"}

{
    "data": [
        {
            "date": "2022-10-01",
            "item": [
                "食費|(daily)|140",
                "交通費|(daily)|262",
                "お賽銭|(daily)|10"
            ]
        },

*/

import '../extensions/extensions.dart';

class SpendItemDaily {
  SpendItemDaily({
    required this.date,
    required this.item,
  });

  factory SpendItemDaily.fromJson(Map<String, dynamic> json) => SpendItemDaily(
        date: json['date'].toString().toDateTime(),
        item: List<String>.from(json['item'].map((x) => x) as Iterable),
      );

  DateTime date;
  List<String> item;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'item': List<dynamic>.from(item.map((x) => x)),
      };
}
