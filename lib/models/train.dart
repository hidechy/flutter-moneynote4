/*
http://toyohide.work/BrainLog/api/gettrainrecord

{
    "data": [
        {
            "date": "2020-01-01",
            "station": "新宿-荻窪",
            "price": "388",
            "oufuku": "0"
        },

*/

import '../extensions/extensions.dart';

class Train {
  Train({
    required this.date,
    required this.station,
    required this.price,
    required this.oufuku,
  });

  factory Train.fromJson(Map<String, dynamic> json) => Train(
        date: json['date'].toString().toDateTime(),
        station: json['station'].toString(),
        price: json['price'].toString(),
        oufuku: json['oufuku'].toString(),
      );

  DateTime date;
  String station;
  String price;
  String oufuku;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'station': station,
        'price': price,
        'oufuku': oufuku,
      };
}
