// ignore_for_file: inference_failure_on_untyped_parameter, avoid_dynamic_calls

class Temple {
  Temple({
    required this.date,
    required this.temple,
    required this.address,
    required this.station,
    required this.memo,
    required this.gohonzon,
    required this.thumbnail,
    required this.lat,
    required this.lng,
    required this.photo,
    required this.startPoint,
    required this.endPoint,
  });

  factory Temple.fromJson(Map<String, dynamic> json) => Temple(
        date: DateTime.parse(json['date'].toString()),
        temple: json['temple'].toString(),
        address: json['address'].toString(),
        station: json['station'].toString(),
        memo: json['memo'].toString(),
        gohonzon: json['gohonzon'].toString(),
        thumbnail: json['thumbnail'].toString(),
        lat: json['lat'].toString(),
        lng: json['lng'].toString(),
        startPoint: json['start_point'].toString(),
        endPoint: json['end_point'].toString(),
        photo: List<String>.from(json['photo'].map((x) => x) as Iterable),
      );

  DateTime date;
  String temple;
  String address;
  String station;
  String memo;
  String gohonzon;
  String thumbnail;
  String lat;
  String lng;
  List<String> photo;
  String startPoint;
  String endPoint;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'temple': temple,
        'address': address,
        'station': station,
        'memo': memo,
        'gohonzon': gohonzon,
        'thumbnail': thumbnail,
        'lat': lat,
        'lng': lng,
        'start_point': startPoint,
        'end_point': endPoint,
        'photo': List<dynamic>.from(photo.map((x) => x)),
      };
}
