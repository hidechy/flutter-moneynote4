/*
http://toyohide.work/BrainLog/api/getAllStation

{
    "data": [
        {
            "id": 2,
            "station_name": "函館",
            "address": "北海道函館市若松町１２-１３",
            "lat": "41.773709",
            "lng": "140.726413",
            "line_number": "11101",
            "line_name": "JR函館本線(函館～長万部)"
        },

*/

class Station {
  Station({
    required this.id,
    required this.stationName,
    required this.address,
    required this.lat,
    required this.lng,
    required this.lineNumber,
    required this.lineName,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        id: json['id'],
        stationName: json['station_name'],
        address: json['address'],
        lat: json['lat'],
        lng: json['lng'],
        lineNumber: json['line_number'],
        lineName: json['line_name'],
      );
  int id;
  String stationName;
  String address;
  String lat;
  String lng;
  String lineNumber;
  String lineName;

  Map<String, dynamic> toJson() => {
        'id': id,
        'station_name': stationName,
        'address': address,
        'lat': lat,
        'lng': lng,
        'line_number': lineNumber,
        'line_name': lineName,
      };
}
