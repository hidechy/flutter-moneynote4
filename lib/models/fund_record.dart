/*
http://toyohide.work/BrainLog/api/getFund

{
    "data": [
        {
            "name": "eMAXIS　Slim　米国株式（S&P500）(三菱ＵＦＪ国際投信)",
            "record": [
                {
                    "date": "2022-01-04",
                    "base_price": "19291",
                    "compare_front": "+87円(+0.45％)",
                    "yearly_return": "44.52％",
                    "flag": "1"
                },

*/

import '../extensions/extensions.dart';

class FundRecord {
  FundRecord({
    required this.date,
    required this.basePrice,
    required this.compareFront,
    required this.yearlyReturn,
    required this.flag,
  });

  factory FundRecord.fromJson(Map<String, dynamic> json) => FundRecord(
        date: json['date'].toString().toDateTime(),
        basePrice: json['base_price'].toString(),
        compareFront: json['compare_front'].toString(),
        yearlyReturn: json['yearly_return'].toString(),
        flag: json['flag'].toString(),
      );

  DateTime date;
  String basePrice;
  String compareFront;
  String yearlyReturn;
  String flag;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'base_price': basePrice,
        'compare_front': compareFront,
        'yearly_return': yearlyReturn,
        'flag': flag,
      };
}
