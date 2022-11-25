/*
http://toyohide.work/BrainLog/api/uccardspend
{"date":"2022-01-01"}

{
    "data": [
        {
            "item": "ＴＥＬＡＳＡ",
            "price": "618",
            "date": "2021-10-01",
            "kind": "uc"
        },

*/

import '../extensions/extensions.dart';

class CreditSpendMonthly {
  CreditSpendMonthly({
    required this.item,
    required this.price,
    required this.date,
    required this.kind,
  });

  factory CreditSpendMonthly.fromJson(Map<String, dynamic> json) =>
      CreditSpendMonthly(
        item: json['item'].toString(),
        price: json['price'].toString(),
        date: json['date'].toString().toDateTime(),
        kind: json['kind'].toString(),
      );

  String item;
  String price;
  DateTime date;
  String kind;

  Map<String, dynamic> toJson() => {
        'item': item,
        'price': price,
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'kind': kind,
      };
}
