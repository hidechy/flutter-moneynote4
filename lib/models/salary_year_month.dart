/*
http://toyohide.work/BrainLog/api/getsalary

{
    "data": [
        {
            "year": 2014,
            "salary": "-|-|-|-|-|5万円|34万円|32万円|30万円|-|17万円|32万円"
        },

*/

import '../extensions/extensions.dart';

class SalaryYearMonth {
  SalaryYearMonth({
    required this.year,
    required this.salary,
  });

  factory SalaryYearMonth.fromJson(Map<String, dynamic> json) =>
      SalaryYearMonth(
        year: json['year'].toString().toInt(),
        salary: json['salary'].toString(),
      );

  int year;
  String salary;

  Map<String, dynamic> toJson() => {
        'year': year,
        'salary': salary,
      };
}
