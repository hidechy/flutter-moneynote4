/*
http://toyohide.work/BrainLog/api/getTempleLatLng

{
    'list': [
        {
            'temple': '愛宕神社',
            'address': '東京都港区愛宕1-5-3',
            'lat': '35.6650691',
            'lng': '139.7485152'
        },

*/

class TempleLatLng {
  TempleLatLng({required this.temple, required this.address, required this.lat, required this.lng});

  factory TempleLatLng.fromJson(Map<String, dynamic> json) =>
      TempleLatLng(temple: json['temple'], address: json['address'], lat: json['lat'], lng: json['lng']);

  String temple;
  String address;
  String lat;
  String lng;

  Map<String, dynamic> toJson() => {'temple': temple, 'address': address, 'lat': lat, 'lng': lng};
}
