/*
http://toyohide.work/BrainLog/api/bankSearch
{"bank":"bank_a"}

{
    "data": [
        {
            "date": "2020-01-01",
            "price": "97653",
            "diff": 97653
        },

*/

import '../extensions/extensions.dart';

class BankCompanyChange {
  BankCompanyChange({
    required this.date,
    required this.price,
    required this.diff,
  });

  factory BankCompanyChange.fromJson(Map<String, dynamic> json) =>
      BankCompanyChange(
        date: json['date'].toString().toDateTime(),
        price: json['price'].toString(),
        diff: json['diff'].toString().toInt(),
      );

  DateTime date;
  String price;
  int diff;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'price': price,
        'diff': diff,
      };
}
