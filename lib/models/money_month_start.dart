/*
http://toyohide.work/BrainLog/api/getmonthstartmoney

{
    "data": [
        {
            "year": 2014,
            "price": "-|-|-|-|-|1370938|1138706|1254685|1247015|1371728|1045093|1021413",
            "manen": "-|-|-|-|-|137万円|114万円|125万円|125万円|137万円|105万円|102万円",
            "updown": "-|-|-|-|-|1|0|1|0|1|0|0",
            "sagaku": "0|0万円|0万円|0万円|0万円|137万円|23万円|12万円|1万円|12万円|33万円|2万円"
        },

*/

import '../extensions/extensions.dart';

class MoneyMonthStart {
  MoneyMonthStart({
    required this.year,
    required this.price,
    required this.manen,
    required this.updown,
    required this.sagaku,
  });

  factory MoneyMonthStart.fromJson(Map<String, dynamic> json) =>
      MoneyMonthStart(
        year: json['year'].toString().toInt(),
        price: json['price'].toString(),
        manen: json['manen'].toString(),
        updown: json['updown'].toString(),
        sagaku: json['sagaku'].toString(),
      );

  int year;
  String price;
  String manen;
  String updown;
  String sagaku;

  Map<String, dynamic> toJson() => {
        'year': year,
        'price': price,
        'manen': manen,
        'updown': updown,
        'sagaku': sagaku,
      };
}
