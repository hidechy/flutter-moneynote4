/*
http://toyohide.work/BrainLog/api/getYearCreditCommonItem

{
    "data": [
        "ADOBE　IL　CREATIVE　CLD",
        "ADOBE　PHOTOGPHY　PLAN",
        "AMAZON",

*/

// ignore_for_file: inference_failure_on_untyped_parameter, avoid_dynamic_calls

class CreditCommonItem {
  CreditCommonItem({
    required this.data,
  });

  factory CreditCommonItem.fromJson(Map<String, dynamic> json) =>
      CreditCommonItem(
        data: List<String>.from(json['data'].map((x) => x) as Iterable),
      );

  List<String> data;

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x)),
      };
}
