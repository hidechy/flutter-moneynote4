// ignore_for_file: inference_failure_on_untyped_parameter, avoid_dynamic_calls

/*
http://toyohide.work/BrainLog/api/timeplacezerousedate

{
    "data": [
        "2020-08-11",
        "2020-08-22",
        "2020-08-29",

*/

import '../extensions/extensions.dart';

class ZeroUseDate {
  ZeroUseDate({
    required this.data,
  });

  factory ZeroUseDate.fromJson(Map<String, dynamic> json) => ZeroUseDate(
        data: List<DateTime>.from(
            json['data'].map((x) => x.toString().toDateTime()) as Iterable),
      );

  List<DateTime> data;

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) =>
            "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
      };
}
