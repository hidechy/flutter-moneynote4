/*
http://toyohide.work/BrainLog/api/monthsummary
{"date":"2022-01-01"}

{
    "data": [
        {
            "item": "食費",
            "sum": 11155,
            "percent": 1
        },

*/

class SpendMonthSummary {
  SpendMonthSummary({
    required this.item,
    required this.sum,
    required this.percent,
  });

  factory SpendMonthSummary.fromJson(Map<String, dynamic> json) =>
      SpendMonthSummary(
        item: json['item'].toString(),
        sum: int.parse(json['sum'].toString()),
        percent: int.parse(json['percent'].toString()),
      );

  String item;
  int sum;
  int percent;

  Map<String, dynamic> toJson() => {
        'item': item,
        'sum': sum,
        'percent': percent,
      };
}
