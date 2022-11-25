/*
http://toyohide.work/BrainLog/api/creditCompanySearch
{"company":"rakuten"}

{
    "data": [
        {
            "ym": "2020-01",
            "date": "2019-12-03",
            "item": "(不明)",
            "price": " 4980"
        },

*/

import '../extensions/extensions.dart';

class CreditSpendCompany {
  CreditSpendCompany({
    required this.ym,
    required this.date,
    required this.item,
    required this.price,
  });

  factory CreditSpendCompany.fromJson(Map<String, dynamic> json) =>
      CreditSpendCompany(
        ym: json['ym'].toString(),
        date: json['date'].toString().toDateTime(),
        item: json['item'].toString(),
        price: json['price'].toString(),
      );

  String ym;
  DateTime date;
  String item;
  String price;

  Map<String, dynamic> toJson() => {
        'ym': ym,
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'item': item,
        'price': price,
      };
}
