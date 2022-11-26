/*
http://toyohide.work/BrainLog/api/amazonPurchaseList
{"date":"2022-01-01"}

{
    "data": [
        {
            "date": "2022-01-06",
            "price": "3379",
            "order_number": "249-0107727-1347859",
            "item": "ZTTYヘッドギア【RIZIN現役 第5代DEEPフライ級王者「神龍誠」推薦】ボクシング スパーリング用 格闘技 練習 用 (红",
            "img": ""
        },

*/

class AmazonPurchase {
  AmazonPurchase({
    required this.date,
    required this.price,
    required this.orderNumber,
    required this.item,
    required this.img,
  });

  factory AmazonPurchase.fromJson(Map<String, dynamic> json) => AmazonPurchase(
        date: json['date'].toString(),
        price: json['price'].toString(),
        orderNumber: json['order_number'].toString(),
        item: json['item'].toString(),
        img: json['img'].toString(),
      );

  String date;
  String price;
  String orderNumber;
  String item;
  String img;

  Map<String, dynamic> toJson() => {
        'date': date,
        'price': price,
        'order_number': orderNumber,
        'item': item,
        'img': img,
      };
}
