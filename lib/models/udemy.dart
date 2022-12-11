class Udemy {
  Udemy({
    required this.date,
    required this.category,
    required this.title,
    required this.price,
    required this.pay,
  });

  factory Udemy.fromJson(Map<String, dynamic> json) => Udemy(
        date: json['date'].toString(),
        category: json['category'].toString(),
        title: json['title'].toString(),
        price: json['price'].toString(),
        pay: json['pay'].toString(),
      );

  String date;
  String category;
  String title;
  String price;
  String pay;

  Map<String, dynamic> toJson() => {
        'date': date,
        'category': category,
        'title': title,
        'price': price,
        'pay': pay,
      };
}
