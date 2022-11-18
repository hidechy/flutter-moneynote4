/*
http://toyohide.work/BrainLog/api/getgolddata

{
    "data": [
        {
            "year": "2021",
            "month": "01",
            "day": "01",
            "gold_tanka": "-",
            "up_down": "-",
            "diff": "-",
            "gram_num": "-",
            "total_gram": "-",
            "gold_value": "-",
            "gold_price": "-",
            "pay_price": "-"
        },

*/

class Gold {
  Gold({
    required this.year,
    required this.month,
    required this.day,
    required this.goldTanka,
    this.upDown,
    this.diff,
    this.gramNum,
    this.totalGram,
    this.goldValue,
    required this.goldPrice,
    this.payPrice,
  });

  factory Gold.fromJson(Map<String, dynamic> json) => Gold(
        year: json['year'].toString(),
        month: json['month'].toString(),
        day: json['day'].toString(),
        goldTanka: json['gold_tanka'].toString(),
        upDown: json['up_down'],
        diff: json['diff'],
        gramNum: json['gram_num'],
        totalGram: json['total_gram'],
        goldValue: json['gold_value'],
        goldPrice: json['gold_price'].toString(),
        payPrice: json['pay_price'],
      );

  String year;
  String month;
  String day;
  String goldTanka;
  dynamic upDown;
  dynamic diff;
  dynamic gramNum;
  dynamic totalGram;
  dynamic goldValue;
  String goldPrice;
  dynamic payPrice;

  Map<String, dynamic> toJson() => {
        'year': year,
        'month': month,
        'day': day,
        'gold_tanka': goldTanka,
        'up_down': upDown,
        'diff': diff,
        'gram_num': gramNum,
        'total_gram': totalGram,
        'gold_value': goldValue,
        'gold_price': goldPrice,
        'pay_price': payPrice,
      };
}
