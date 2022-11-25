/*
http://toyohide.work/BrainLog/api/getmonthlyweeknum
{"date":"2022-12-01"}

{
    "data": {
        "weeknum": 49
    }
}

*/

import '../extensions/extensions.dart';

class Weeknum {
  Weeknum({
    required this.weeknum,
  });

  factory Weeknum.fromJson(Map<String, dynamic> json) => Weeknum(
        weeknum: json['weeknum'].toString().toInt(),
      );

  int weeknum;

  Map<String, dynamic> toJson() => {
        'weeknum': weeknum,
      };
}
