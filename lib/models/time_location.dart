/*
http://toyohide.work/BrainLog/api/getTimeLocation
{"date":"2023-01-01"}

{
    "data": [
        {
            "date": "2023-01-01",
            "time": "00:32",
            "latitude": "35.7082097",
            "longitude": "140.8648387"
        },
        {
            "date": "2023-01-01",
            "time": "02:23",
            "latitude": "35.7184745",
            "longitude": "139.5868933"
        },

*/

class TimeLocation {
  TimeLocation({
    required this.date,
    required this.time,
    required this.latitude,
    required this.longitude,
  });

  factory TimeLocation.fromJson(Map<String, dynamic> json) => TimeLocation(
        date: DateTime.parse(json['date'].toString()),
        time: json['time'].toString(),
        latitude: json['latitude'].toString(),
        longitude: json['longitude'].toString(),
      );

  DateTime date;
  String time;
  String latitude;
  String longitude;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'time': time,
        'latitude': latitude,
        'longitude': longitude,
      };
}
