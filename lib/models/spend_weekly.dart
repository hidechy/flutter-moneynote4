/*
http://toyohide.work/BrainLog/api/spenditemweekly
{"date":"2022-01-01"}

{
    "data": [
        {
            "date": "2021-12-26",
            "koumoku": "食費",
            "price": 1152
        },

*/

import '../extensions/extensions.dart';

class SpendWeekly {
  SpendWeekly({
    required this.date,
    required this.koumoku,
    this.price,
  });

  factory SpendWeekly.fromJson(Map<String, dynamic> json) => SpendWeekly(
        date: json['date'].toString().toDateTime(),
        koumoku: json['koumoku'].toString(),
        price: json['price'],
      );

  DateTime date;
  String koumoku;
  dynamic price;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'koumoku': koumoku,
        'price': price,
      };
}
