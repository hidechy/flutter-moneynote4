/*
http://toyohide.work/BrainLog/api/benefit

{
    "data": [
        {
            "date": "2014-06-30",
            "ym": "2014-06",
            "salary": "46201",
            "company": "WJB"
        },

*/

import '../extensions/extensions.dart';

class Benefit {
  Benefit({
    required this.date,
    required this.ym,
    required this.salary,
    required this.company,
  });

  factory Benefit.fromJson(Map<String, dynamic> json) => Benefit(
        date: json['date'].toString().toDateTime(),
        ym: json['ym'].toString(),
        salary: json['salary'].toString(),
        company: json['company'].toString(),
      );

  DateTime date;
  String ym;
  String salary;
  String company;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'ym': ym,
        'salary': salary,
        'company': company,
      };
}
