/*
http://toyohide.work/BrainLog/api/getYearCreditSummarySummary

{
    "data": [
        {
            "item": "TELASA",
            "list": [
                {
                    "month": "01",
                    "price": 618
                },
                {
                    "month": "02",
                    "price": 618
                },

*/

import '../extensions/extensions.dart';

class CreditSummaryRecord {
  CreditSummaryRecord({
    required this.month,
    required this.price,
  });

  factory CreditSummaryRecord.fromJson(Map<String, dynamic> json) =>
      CreditSummaryRecord(
        month: json['month'].toString(),
        price: json['price'].toString().toInt(),
      );

  String month;
  int price;

  Map<String, dynamic> toJson() => {
        'month': month,
        'price': price,
      };
}
