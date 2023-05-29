/*
http://toyohide.work/BrainLog/api/getSameYearMonthDay
{'date':'2023-05-29'}

{
    'data': [
        {
            'year': 2020,
            'spend': -1464925,
            'salary': 3244700
        },

*/

import '../extensions/extensions.dart';

class SpendSamedayYearly {
  SpendSamedayYearly({
    required this.year,
    required this.spend,
    required this.salary,
  });

  factory SpendSamedayYearly.fromJson(Map<String, dynamic> json) =>
      SpendSamedayYearly(
        year: json['year'].toString().toInt(),
        spend: json['spend'].toString().toInt(),
        salary: json['salary'].toString().toInt(),
      );
  int year;
  int spend;
  int salary;

  Map<String, dynamic> toJson() => {
        'year': year,
        'spend': spend,
        'salary': salary,
      };
}
