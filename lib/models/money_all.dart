// ignore_for_file: inference_failure_on_untyped_parameter, avoid_dynamic_calls

/*
http://toyohide.work/BrainLog/api/getAllMoney

{
    "data": [
        "2020-01-01|2020-01|22|1|0|1|1|0|0|1|1|2|97653|470939|291835|232856|0|549|1749|0|0|0",
        "2020-01-02|2020-01|22|1|0|0|1|3|1|1|1|1|97653|470939|291835|232856|0|549|1749|0|0|0",
        "2020-01-03|2020-01|22|0|0|4|1|4|0|4|1|1|97653|470939|291835|232856|0|549|1749|0|0|0",
        "2020-01-04|2020-01|20|2|0|7|1|10|5|17|3|8|97653|470939|291835|232856|0|1123|1777|0|0|0",
        "2020-01-05|2020-01|20|2|0|3|3|16|9|29|5|13|97653|470939|291835|232856|0|1|1777|0|0|0",

*/

import 'dart:convert';

MoneyAll getAllMoneyFromJson(String str) =>
    MoneyAll.fromJson(json.decode(str) as Map<String, dynamic>);

String getAllMoneyToJson(MoneyAll data) => json.encode(data.toJson());

class MoneyAll {
  MoneyAll({
    required this.data,
  });

  factory MoneyAll.fromJson(Map<String, dynamic> json) => MoneyAll(
        data:
            List<String>.from(json['data'].map((x) => x) as Iterable<dynamic>),
      );

  List<String> data;

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x)),
      };
}
