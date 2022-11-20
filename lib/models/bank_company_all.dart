/*
http://toyohide.work/BrainLog/api/getAllBank

{
    "data": [
        {
            "date": "2020-01-01",
            "bank_a": "97653",
            "bank_b": "470939",
            "bank_c": "291835",
            "bank_d": "232856",
            "bank_e": "0",
            "pay_a": "549",
            "pay_b": "1749",
            "pay_c": "0",
            "pay_d": "0",
            "pay_e": "0"
        },

*/

class BankCompanyAll {
  BankCompanyAll({
    required this.date,
    required this.price,
    required this.mark,
  });

  DateTime date;
  String price;
  String mark;
}
