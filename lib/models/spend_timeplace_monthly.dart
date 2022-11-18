/*
http://toyohide.work/BrainLog/api/getmonthlytimeplace
{"date":"2022-01-01"}

{
    "data": [
        {
            "date": "2022-01-01",
            "time": "10:10",
            "place": "大洗",
            "price": 200
        },

*/

class SpendTimeplaceMonthly {
  SpendTimeplaceMonthly({
    required this.date,
    required this.time,
    required this.place,
    required this.price,
  });

  factory SpendTimeplaceMonthly.fromJson(Map<String, dynamic> json) =>
      SpendTimeplaceMonthly(
        date: DateTime.parse(json['date'].toString()),
        time: json['time'].toString(),
        place: json['place'].toString(),
        price: int.parse(json['price'].toString()),
      );

  DateTime date;
  String time;
  String place;
  int price;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'time': time,
        'place': place,
        'price': price,
      };
}
