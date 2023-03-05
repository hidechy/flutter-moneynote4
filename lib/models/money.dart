/*
http://toyohide.work/BrainLog/api/moneydl
{"date":"2022-01-01"}

{
    "data": {
        "yen_10000": "35",
        "yen_5000": "1",
        "yen_2000": "0",
        "yen_1000": "3",
        "yen_500": "0",
        "yen_100": "2",
        "yen_50": "0",
        "yen_10": "3",
        "yen_5": "1",
        "yen_1": "0",
        "bank_a": "61814",
        "bank_b": "288167",
        "bank_c": "133696",
        "bank_d": "4088388",
        "bank_e": "29833",
        "pay_a": "40",
        "pay_b": "7858",
        "pay_c": "39",
        "pay_d": "6294",
        "pay_e": "11961"

        "sum": "5317801"
    }
}

*/

import '../extensions/extensions.dart';

class Money {
  Money({
    required this.date,
    required this.ym,
    required this.yen10000,
    required this.yen5000,
    required this.yen2000,
    required this.yen1000,
    required this.yen500,
    required this.yen100,
    required this.yen50,
    required this.yen10,
    required this.yen5,
    required this.yen1,
    required this.bankA,
    required this.bankB,
    required this.bankC,
    required this.bankD,
    required this.bankE,
    required this.payA,
    required this.payB,
    required this.payC,
    required this.payD,
    required this.payE,
    required this.sum,
    required this.currency,
  });

  factory Money.fromJson(Map<String, dynamic> json) => Money(
        date: json['date'].toString().toDateTime(),
        ym: json['ym'].toString(),
        yen10000: json['yen_10000'].toString(),
        yen5000: json['yen_5000'].toString(),
        yen2000: json['yen_2000'].toString(),
        yen1000: json['yen_1000'].toString(),
        yen500: json['yen_500'].toString(),
        yen100: json['yen_100'].toString(),
        yen50: json['yen_50'].toString(),
        yen10: json['yen_10'].toString(),
        yen5: json['yen_5'].toString(),
        yen1: json['yen_1'].toString(),
        bankA: json['bank_a'].toString(),
        bankB: json['bank_b'].toString(),
        bankC: json['bank_c'].toString(),
        bankD: json['bank_d'].toString(),
        bankE: json['bank_e'].toString(),
        payA: json['pay_a'].toString(),
        payB: json['pay_b'].toString(),
        payC: json['pay_c'].toString(),
        payD: json['pay_d'].toString(),
        payE: json['pay_e'].toString(),
        sum: json['sum'].toString(),
        currency: 0,
      );

  DateTime date;
  String ym;
  String yen10000;
  String yen5000;
  String yen2000;
  String yen1000;
  String yen500;
  String yen100;
  String yen50;
  String yen10;
  String yen5;
  String yen1;
  String bankA;
  String bankB;
  String bankC;
  String bankD;
  String bankE;
  String payA;
  String payB;
  String payC;
  String payD;
  String payE;
  String sum;
  int currency;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'ym': ym,
        'yen_10000': yen10000,
        'yen_5000': yen5000,
        'yen_2000': yen2000,
        'yen_1000': yen1000,
        'yen_500': yen500,
        'yen_100': yen100,
        'yen_50': yen50,
        'yen_10': yen10,
        'yen_5': yen5,
        'yen_1': yen1,
        'bank_a': bankA,
        'bank_b': bankB,
        'bank_c': bankC,
        'bank_d': bankD,
        'bank_e': bankE,
        'pay_a': payA,
        'pay_b': payB,
        'pay_c': payC,
        'pay_d': payD,
        'pay_e': payE,
        'sum': sum,
        'currency': currency,
      };
}
