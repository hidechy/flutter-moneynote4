/*
http://toyohide.work/BrainLog/api/selectSpendCheckItem

{
    "data": [
        {
            "date": "2023-01-01",
            "item": "GOOGLE CLOUD利用国JPN",
            "price": 81,
            "category1": "設備関連の支払い",
            "category2": "通信費"

id 100
flag 'credit' / 'daily' / 'bank'

        },

*/

import '../extensions/extensions.dart';

class Keihi {
  Keihi({
    required this.date,
    required this.item,
    required this.price,
    required this.category1,
    required this.category2,
    required this.id,
    required this.flag,
  });

  factory Keihi.fromJson(Map<String, dynamic> json) => Keihi(
        date: DateTime.parse(json['date'].toString()),
        item: json['item'].toString(),
        price: json['price'].toString().toInt(),
        category1: json['category1'].toString(),
        category2: json['category2'].toString(),
        id: json['id'].toString().toInt(),
        flag: json['flag'].toString(),
      );

  DateTime date;
  String item;
  int price;
  String category1;
  String category2;
  int id;
  String flag;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'item': item,
        'price': price,
        'category1': category1,
        'category2': category2,
        'id': id,
        'flag': flag,
      };
}
