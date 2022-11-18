/*
http://toyohide.work/BrainLog/api/carditemlist

{
    "data": [
        {
            "pay_month": "2020-01",
            "item": "（不明）",
            "price": " 4980",
            "date": "2019-12-03",
            "kind": "rakuten",
            "month_diff": 0,
            "flag": 1
        },

*/

class CreditSpendAll {
  CreditSpendAll({
    required this.payMonth,
    required this.item,
    required this.price,
    required this.date,
    required this.kind,
    required this.monthDiff,
    required this.flag,
  });

  factory CreditSpendAll.fromJson(Map<String, dynamic> json) => CreditSpendAll(
        payMonth: json['pay_month'].toString(),
        item: json['item'].toString(),
        price: json['price'].toString(),
        date: DateTime.parse(json['date'].toString()),
        kind: json['kind'].toString(),
        monthDiff: int.parse(json['month_diff'].toString()),
        flag: int.parse(json['flag'].toString()),
      );

  String payMonth;
  String item;
  String price;
  DateTime date;
  String kind;
  int monthDiff;
  int flag;

  Map<String, dynamic> toJson() => {
        'pay_month': payMonth,
        'item': item,
        'price': price,
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'kind': kind,
        'month_diff': monthDiff,
        'flag': flag,
      };
}
