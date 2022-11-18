/*
http://toyohide.work/BrainLog/api/seiyuuPurchaseList
{"date":"2022-01-01"}

{
    "data": [
        {
            "date": "2022-01-04",
            "pos": 0,
            "item": "カウブランド 青箱 バスサイズ3P　（非食品）",
            "tanka": "233",
            "kosuu": "1",
            "price": "233",
            "img": "https://sm.r10s.jp/item/47/4901525008747.jpg"
        },

*/

class SeiyuPurchase {
  SeiyuPurchase({
    required this.date,
    required this.pos,
    required this.item,
    required this.tanka,
    required this.kosuu,
    required this.price,
    required this.img,
  });

  factory SeiyuPurchase.fromJson(Map<String, dynamic> json) => SeiyuPurchase(
        date: DateTime.parse(json['date'].toString()),
        pos: int.parse(json['pos'].toString()),
        item: json['item'].toString(),
        tanka: json['tanka'].toString(),
        kosuu: json['kosuu'].toString(),
        price: json['price'].toString(),
        img: json['img'].toString(),
      );

  DateTime date;
  int pos;
  String item;
  String tanka;
  String kosuu;
  String price;
  String img;

  Map<String, dynamic> toJson() => {
        'date':
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        'pos': pos,
        'item': item,
        'tanka': tanka,
        'kosuu': kosuu,
        'price': price,
        'img': img,
      };
}
