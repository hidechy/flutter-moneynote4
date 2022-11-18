/*
http://toyohide.work/BrainLog/api/getMonthlyBankRecord
{"date":"2022-01-01"}

{
    "data": [
        {
            "day": "03",
            "item": "手数料",
            "price": "220",
            "bank": "D"
        },

*/

class BankMonthlySpend {
  BankMonthlySpend({
    required this.day,
    required this.item,
    required this.price,
    required this.bank,
  });

  factory BankMonthlySpend.fromJson(Map<String, dynamic> json) =>
      BankMonthlySpend(
        day: json['day'].toString(),
        item: json['item'].toString(),
        price: json['price'].toString(),
        bank: json['bank'].toString(),
      );

  String day;
  String item;
  String price;
  String bank;

  Map<String, dynamic> toJson() => {
        'day': day,
        'item': item,
        'price': price,
        'bank': bank,
      };
}
