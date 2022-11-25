/*
http://toyohide.work/BrainLog/api/timeplaceweekly
{"date":"2022-01-01"}

{
    "data": [
        {
            "date": "2021-12-26",
            "time": "08:18",
            "place": "西船橋",
            "price": 123
        },

*/

import '../extensions/extensions.dart';

class SpendTimeplaceWeekly {
  SpendTimeplaceWeekly({
    required this.date,
    required this.time,
    required this.place,
    required this.price,
  });

  factory SpendTimeplaceWeekly.fromJson(Map<String, dynamic> json) =>
      SpendTimeplaceWeekly(
        date: json['date'].toString().toDateTime(),
        time: json['time'].toString(),
        place: json['place'].toString(),
        price: json['price'].toString().toInt(),
      );

  DateTime date;
  String time;
  String place;
  int price;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'time': time,
        'place': place,
        'price': price,
      };
}
