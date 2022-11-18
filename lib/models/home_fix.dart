/*
http://toyohide.work/BrainLog/api/homeFix

{
    "data": [
        {
            "ym": "2020-01",
            "yachin": "67,000 (06)",
            "wifi": "16,812 (06) / 16,900 (31)",
            "mobile": "176 (10)",
            "gas": "2,328 (06)",
            "denki": "4,470 (09)",
            "suidou": "1,200 (16)"
        },

*/

class HomeFix {
  HomeFix({
    required this.ym,
    required this.yachin,
    required this.wifi,
    required this.mobile,
    required this.gas,
    required this.denki,
    required this.suidou,
  });

  factory HomeFix.fromJson(Map<String, dynamic> json) => HomeFix(
        ym: json['ym'].toString(),
        yachin: json['yachin'].toString(),
        wifi: json['wifi'].toString(),
        mobile: json['mobile'].toString(),
        gas: json['gas'].toString(),
        denki: json['denki'].toString(),
        suidou: json['suidou'].toString(),
      );

  String ym;
  String yachin;
  String wifi;
  String mobile;
  String gas;
  String denki;
  String suidou;

  Map<String, dynamic> toJson() => {
        'ym': ym,
        'yachin': yachin,
        'wifi': wifi,
        'mobile': mobile,
        'gas': gas,
        'denki': denki,
        'suidou': suidou,
      };
}
