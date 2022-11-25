/*
http://toyohide.work/BrainLog/api/getWells

{
    "data": [
        {
            "num": "001",
            "date": "2014-08-27",
            "price": "55880",
            "total": "55880"
        },

*/

import '../extensions/extensions.dart';

class Wells {
  Wells({
    required this.num,
    required this.date,
    required this.price,
    required this.total,
  });

  factory Wells.fromJson(Map<String, dynamic> json) => Wells(
        num: json['num'].toString(),
        date: json['date'].toString().toDateTime(),
        price: json['price'].toString(),
        total: json['total'].toString(),
      );

  String num;
  DateTime date;
  String price;
  String total;

  Map<String, dynamic> toJson() => {
        'num': num,
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'price': price,
        'total': total,
      };
}
