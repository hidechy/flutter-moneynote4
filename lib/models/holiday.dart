/*
http://toyohide.work/BrainLog/api/getholiday

{
    "data": [
        "2014-05-03",
        "2014-05-04",
        "2014-05-05",

*/

// ignore_for_file: inference_failure_on_untyped_parameter, avoid_dynamic_calls

class Holiday {
  Holiday({
    required this.data,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
        data: List<DateTime>.from(
            json['data'].map((x) => DateTime.parse(x.toString())) as Iterable),
      );

  List<DateTime> data;

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) =>
            "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
      };
}
