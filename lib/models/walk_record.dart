import 'dart:convert';

// ignore: avoid_dynamic_calls
List<WalkRecord> walkRecordFromJson(String str) => List<WalkRecord>.from(json.decode(str).map(WalkRecord.fromJson));

String walkRecordToJson(List<WalkRecord> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WalkRecord {
  WalkRecord({
    required this.date,
    required this.step,
    required this.distance,
    required this.timeplace,
    required this.temple,
    required this.mercari,
    required this.train,
    required this.spend,
  });

  factory WalkRecord.fromJson(Map<String, dynamic> json) => WalkRecord(
        date: DateTime.parse(json['date']),
        step: json['step'],
        distance: json['distance'],
        timeplace: json['timeplace'],
        temple: json['temple'],
        mercari: json['mercari'],
        train: json['train'],
        spend: json['spend'],
      );
  final DateTime date;
  final int step;
  final int distance;
  final String timeplace;
  final String temple;
  final String mercari;
  final String train;
  final String spend;

  WalkRecord copyWith({
    DateTime? date,
    int? step,
    int? distance,
    String? timeplace,
    String? temple,
    String? mercari,
    String? train,
    String? spend,
  }) =>
      WalkRecord(
        date: date ?? this.date,
        step: step ?? this.step,
        distance: distance ?? this.distance,
        timeplace: timeplace ?? this.timeplace,
        temple: temple ?? this.temple,
        mercari: mercari ?? this.mercari,
        train: train ?? this.train,
        spend: spend ?? this.spend,
      );

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'step': step,
        'distance': distance,
        'timeplace': timeplace,
        'temple': temple,
        'mercari': mercari,
        'train': train,
        'spend': spend,
      };
}
