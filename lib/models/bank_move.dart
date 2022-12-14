/*
http://toyohide.work/BrainLog/api/getBankMove

{
    "data": [
        {
            "date": "2021-06-23",
            "bank": "bank_d",
            "price": 100000
        },
        {
            "date": "2021-06-23",
            "bank": "bank_e",
            "price": 100000
        },

*/

import '../extensions/extensions.dart';

class BankMove {
  BankMove({
    required this.date,
    required this.bank,
    required this.price,
    required this.flag,
  });

  factory BankMove.fromJson(Map<String, dynamic> json) => BankMove(
        date: DateTime.parse(json['date'].toString()),
        bank: json['bank'].toString(),
        price: json['price'].toString().toInt(),
        flag: json['flag'].toString().toInt(),
      );

  DateTime date;
  String bank;
  int price;
  int flag;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'bank': bank,
        'price': price,
        'flag': flag,
      };
}
