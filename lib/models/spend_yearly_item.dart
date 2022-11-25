/*
<sub>

http://toyohide.work/BrainLog/api/getYearSpend
{"date":"2022-01-01"}

{
    "data": [
        {
            "date": "2022-01-01",
            "spend": 22855,
            "item": [
                {
                    "item": "食費",
                    "price": 200,
                    "flag": 0
                },
                {
                    "item": "交通費",
                    "price": 528,
                    "flag": 0
                },
                {
                    "item": "お賽銭",
                    "price": 200,
                    "flag": 0
                },
                {
                    "item": "交際費",
                    "price": 5289,
                    "flag": 0
                },
                {
                    "item": "メルカリ",
                    "price": 16638,
                    "flag": 0
                }
            ]
        },

*/

import '../extensions/extensions.dart';

class SpendYearlyItem {
  SpendYearlyItem({
    required this.item,
    this.price,
    required this.flag,
  });

  factory SpendYearlyItem.fromJson(Map<String, dynamic> json) =>
      SpendYearlyItem(
        item: json['item'].toString(),
        price: json['price'],
        flag: json['flag'].toString().toInt(),
      );

  String item;
  dynamic price;
  int flag;

  Map<String, dynamic> toJson() => {
        'item': item,
        'price': price,
        'flag': flag,
      };
}
