/*
http://toyohide.work/BrainLog/api/getDutyData

{
    "data": [
        {
            "date": "2020-10-07",
            "duty": "所得税",
            "price": 137700
        },

*/

import '../extensions/extensions.dart';

class Duty {
  Duty({
    required this.date,
    required this.duty,
    required this.price,
  });

  factory Duty.fromJson(Map<String, dynamic> json) => Duty(
        date: json['date'].toString(),
        duty: json['duty'].toString(),
        price: json['price'].toString().toInt(),
      );

  String date;
  String duty;
  int price;

  Map<String, dynamic> toJson() => {
        'date': date,
        'duby': duty,
        'price': price,
      };
}
