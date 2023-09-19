// ignore_for_file: inference_failure_on_untyped_parameter, avoid_dynamic_calls

/*
http://toyohide.work/BrainLog/api/getTempleDatePhoto

{
    'data': [
        {
            'date': '2014-08-08',
            'temple': '愛宕神社',
            'templephotos': [
                'http://160.16.145.135/BrainLog/public/UPPHOTO/2014/2014-08-08/2014-08-08_001_l.jpg'
            ]
        },

*/

class TemplePhoto {
  TemplePhoto({required this.date, required this.temple, required this.templephotos});

  factory TemplePhoto.fromJson(Map<String, dynamic> json) => TemplePhoto(
        date: DateTime.parse(json['date']),
        temple: json['temple'],
        templephotos: List<String>.from(json['templephotos'].map((x) => x)),
      );
  DateTime date;
  String temple;
  List<String> templephotos;

  Map<String, dynamic> toJson() => {
        'date':
            '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
        'temple': temple,
        'templephotos': List<dynamic>.from(templephotos.map((x) => x)),
      };
}
