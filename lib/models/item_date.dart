/*
http://toyohide.work/BrainLog/api/itemDetailDisplay
{"date":"2022-01-01", "item":"食費"}

{
    "data": [
        {
            "date": "2022-01-01",
            "price": "200"
        },

*/

import '../extensions/extensions.dart';

class ItemDate {
  ItemDate({
    required this.date,
    required this.price,
  });

  factory ItemDate.fromJson(Map<String, dynamic> json) => ItemDate(
        date: json['date'].toString().toDateTime(),
        price: json['price'].toString(),
      );

  DateTime date;
  String price;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'price': price,
      };
}
