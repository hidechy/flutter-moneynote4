/*
http://toyohide.work/BrainLog/api/getDutyData

{
    "data": [
        {
            "duty": "所得税",
            "date": "2020-10-07",
            "price": 137700
        },

*/

import '../extensions/extensions.dart';

class Duty {
  Duty({
    required this.duty,
    required this.date,
    this.price,
  });

  factory Duty.fromJson(Map<String, dynamic> json) => Duty(
        duty: json['duty'].toString(),
        date: json['date'].toString().toDateTime(),
        price: json['price'],
      );

  String duty;
  DateTime date;
  dynamic price;

  Map<String, dynamic> toJson() => {
        'duty': duty,
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'price': price,
      };
}
