/*
http://toyohide.work/BrainLog/api/bankSearch
{"bank":"bank_a"}

{
    "data": [
        {
            "date": "2020-01-01",
            "price": "97653",
            "diff": 97653
        },

*/

class BankCompanyRecord {
  BankCompanyRecord({
    required this.date,
    required this.price,
    required this.diff,
  });

  factory BankCompanyRecord.fromJson(Map<String, dynamic> json) =>
      BankCompanyRecord(
        date: DateTime.parse(json['date'].toString()),
        price: json['price'].toString(),
        diff: int.parse(json['diff'].toString()),
      );

  DateTime date;
  String price;
  int diff;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'price': price,
        'diff': diff,
      };
}
