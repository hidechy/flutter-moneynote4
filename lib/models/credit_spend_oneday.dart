/*
http://toyohide.work/BrainLog/api/getCreditDateData
{"date":"2022-11-07","price":1000}

{
    "data": [
        {
            "card": "uc",
            "date": "2022-09-20",
            "item": "ＡＤＯＢＥ　ＰＨＯＴＯＧＰＨＹ　ＰＬＡＮ",
            "price": "1078"
        },

*/

import '../extensions/extensions.dart';

class CreditSpendOneday {
  CreditSpendOneday({
    required this.card,
    required this.date,
    required this.item,
    required this.price,
  });

  factory CreditSpendOneday.fromJson(Map<String, dynamic> json) =>
      CreditSpendOneday(
        card: json['card'].toString(),
        date: json['date'].toString().toDateTime(),
        item: json['item'].toString(),
        price: json['price'].toString(),
      );

  String card;
  DateTime date;
  String item;
  String price;

  Map<String, dynamic> toJson() => {
        'card': card,
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'item': item,
        'price': price,
      };
}
