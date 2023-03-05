/*
http://toyohide.work/BrainLog/api/selectSpendCheckItem

{
    "data": [
        {
            "date": "2023-01-01",
            "item": "GOOGLE CLOUD利用国JPN",
            "price": 81
        },

*/

import '../extensions/extensions.dart';

class Keihi {
  Keihi({
    required this.date,
    required this.item,
    required this.price,
  });

  factory Keihi.fromJson(Map<String, dynamic> json) => Keihi(
        date: DateTime.parse(json['date'].toString()),
        item: json['item'].toString(),
        price: json['price'].toString().toInt(),
      );

  DateTime date;
  String item;
  int price;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'item': item,
        'price': price,
      };
}
