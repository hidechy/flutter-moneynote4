/*
http://toyohide.work/BrainLog/api/mercaridata

{
    "data": [
        {
            "date": "2021-06-12",
            "record": "sell|サガフロンティア 2 アルティマニア|990|99|175|716|2021-06-10 20|2021-06-12 14|/sell|作りながら覚える3日で作曲入門|1000|100|175|725|2021-06-10 20|2021-06-12 14|/sell|Bootstrap 4フロントエンド開発の教科書|2080|208|175|1697|2021-06-10 16|2021-06-12 20|/sell|はじめてのFlutter|1640|164|175|1301|2021-06-10 16|2021-06-12 21|",
            "day_total": 4439,
            "total": 4439
        },

*/

class MercariRecord {
  MercariRecord({
    required this.date,
    required this.buySell,
    required this.title,
    required this.cellPrice,
    required this.tesuuryou,
    required this.shippingFee,
    required this.price,
    this.departure,
    required this.settlement,
    this.receive,
  });

  DateTime date;
  String buySell;
  String title;
  int cellPrice;
  int tesuuryou;
  int shippingFee;
  int price;
  DateTime? departure;
  DateTime settlement;
  DateTime? receive;

/*


$ary[date("Y-m-d", strtotime($v->settlement_at))][] =
"
$v->buy_sell|
$title|
$v->sell_price|
$v->tesuuryou|
$v->shipping_fee|
$v->price|
$dep|
$sett|
$rec
";


sell|サガフロンティア 2 アルティマニア|990|99|175|716|2021-06-10 20|2021-06-12 14|/
sell|作りながら覚える3日で作曲入門|1000|100|175|725|2021-06-10 20|2021-06-12 14|/


buy|50代からのちょっとエゴな生き方|0|0|0|550||2021-06-13 21|2021-06-16 20





  */

}
