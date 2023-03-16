/*
http://toyohide.work/BrainLog/api/getTaxPaymentItem

{
    "data": [
        {
            "item": "経費",
            "price": 1269709
        },

*/

import '../extensions/extensions.dart';

class TaxPaymentItem {
  TaxPaymentItem({required this.item, required this.price});

  factory TaxPaymentItem.fromJson(Map<String, dynamic> json) => TaxPaymentItem(
        item: json['item'].toString(),
        price: json['price'].toString().toInt(),
      );

  String item;
  int price;

  Map<String, dynamic> toJson() => {'item': item, 'price': price};
}
