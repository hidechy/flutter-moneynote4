/*
http://toyohide.work/BrainLog/api/getLifetimeRecordItem

*/

class LifetimeItem {
  LifetimeItem({required this.item});

  factory LifetimeItem.fromJson(Map<String, dynamic> json) => LifetimeItem(item: json['item']);
  final String item;

  LifetimeItem copyWith({String? item}) => LifetimeItem(item: item ?? this.item);

  Map<String, dynamic> toJson() => {'item': item};
}
