/*
http://toyohide.work/BrainLog/api/mercaridata

{
    "data": [
        {
            "date": "2021-06-12",
            "record": "sell|サガフロンティア 2 アルティマニア|990|99|175|716|2021-06-10 20|2021-06-12 14|/sell|作りながら覚える3日で作曲入門|1000|100|175|725|2021-06-10 20|2021-06-12 14|/sell|Bootstrap 4フロントエンド開発の教科書|2080|208|175|1697|2021-06-10 16|2021-06-12 20|/sell|はじめてのFlutter|1640|164|175|1301|2021-06-10 16|2021-06-12 21|",
            "day_total": 4439,
            "total": 4439
        },

*/

import '../extensions/extensions.dart';

class Mercari {
  Mercari({
    required this.date,
    required this.record,
    required this.dayTotal,
    required this.total,
  });

  factory Mercari.fromJson(Map<String, dynamic> json) => Mercari(
        date: json['date'].toString().toDateTime(),
        record: json['record'].toString(),
        dayTotal: json['day_total'].toString().toInt(),
        total: json['total'].toString().toInt(),
      );

  DateTime date;
  String record;
  int dayTotal;
  int total;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'record': record,
        'day_total': dayTotal,
        'total': total,
      };
}
