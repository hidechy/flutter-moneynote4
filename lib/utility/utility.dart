// ignore_for_file: depend_on_referenced_packages, type_annotate_public_apis, cascade_invocations, strict_raw_type, noop_primitive_operations

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../extensions/katakana_convert.dart';

class Utility {
  /// 背景取得
  Widget getBackGround({context}) {
    return Image.asset(
      'assets/images/bg.png',
      fit: BoxFit.cover,
      color: Colors.black.withOpacity(0.7),
      colorBlendMode: BlendMode.darken,
    );
  }

  /// 銀行名取得
  Map getBankName() {
    final bankNames = <String, String>{};

    bankNames['bank_a'] = 'みずほ';
    bankNames['bank_b'] = '住友547';
    bankNames['bank_c'] = '住友259';
    bankNames['bank_d'] = 'UFJ';
    bankNames['bank_e'] = '楽天';

    bankNames['pay_a'] = 'Suica1';
    bankNames['pay_b'] = 'PayPay';
    bankNames['pay_c'] = 'PASUMO';
    bankNames['pay_d'] = 'Suica2';
    bankNames['pay_e'] = 'メルカリ';

    return bankNames;
  }

  ///
  Color getLeadingBgColor({required String month}) {
    switch (month.toInt() % 6) {
      case 0:
        return Colors.orangeAccent.withOpacity(0.2);
      case 1:
        return Colors.blueAccent.withOpacity(0.2);
      case 2:
        return Colors.redAccent.withOpacity(0.2);
      case 3:
        return Colors.purpleAccent.withOpacity(0.2);
      case 4:
        return Colors.greenAccent.withOpacity(0.2);
      case 5:
        return Colors.yellowAccent.withOpacity(0.2);
      default:
        return Colors.black;
    }
  }

  ///
  List<Color> getTwelveColor() {
    return [
      const Color(0xffdb2f20),
      const Color(0xffefa43a),
      const Color(0xfffdf551),
      const Color(0xffa6c63d),
      const Color(0xff439638),
      const Color(0xff469c9e),
      const Color(0xff48a0e1),
      const Color(0xff3070b1),
      const Color(0xff020c75),
      const Color(0xff931c7a),
      const Color(0xffdc2f81),
      const Color(0xffdb2f5c),
    ];
  }

  ///
  Color getYoubiColor({required DateTime date, required String youbiStr, required List<DateTime> holiday}) {
    var color = Colors.black.withOpacity(0.2);

    switch (youbiStr) {
      case 'Sunday':
        color = Colors.redAccent.withOpacity(0.2);
        break;

      case 'Saturday':
        color = Colors.blueAccent.withOpacity(0.2);
        break;

      default:
        color = Colors.black.withOpacity(0.2);
        break;
    }

    if (holiday.contains(date)) {
      color = Colors.greenAccent.withOpacity(0.2);
    }

    return color;
  }

  ///
  String getYoubi({required String youbiStr}) {
    switch (youbiStr) {
      case 'Sunday':
        return '日';
      case 'Monday':
        return '月';
      case 'Tuesday':
        return '火';
      case 'Wednesday':
        return '水';
      case 'Thursday':
        return '木';
      case 'Friday':
        return '金';
      case 'Saturday':
        return '土';
    }

    return '';
  }

  ///
  Widget getFileNameDebug({required String name}) {
    return Container(
      alignment: Alignment.topRight,
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        name,
        style: const TextStyle(color: Color(0xFFFBB6CE)),
      ),
    );
  }

  ///
  void showError(String msg) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  ///
  DateTime? makeSpecialDate({
    required DateTime date,
    required String usage,
    required String plusminus,
    required int num,
  }) {
    final exDate = date.yyyymmdd.split('-');

    switch ('$usage|$plusminus') {
      case 'year|plus':
        return DateTime(exDate[0].toInt() + num);
      case 'year|minus':
        return DateTime(exDate[0].toInt() - num);
      case 'month|plus':
        return DateTime(exDate[0].toInt(), exDate[1].toInt() + num);
      case 'month|minus':
        return DateTime(exDate[0].toInt(), exDate[1].toInt() - num);
      case 'day|plus':
        return DateTime(
          exDate[0].toInt(),
          exDate[1].toInt(),
          exDate[2].toInt() + 1,
        );
      case 'day|minus':
        return DateTime(
          exDate[0].toInt(),
          exDate[1].toInt(),
          exDate[2].toInt() - 1,
        );
    }

    return null;
  }

  ///
  List<LineTooltipItem> getGraphToolTip(List<LineBarSpot> touchedSpots) {
    final list = <LineTooltipItem>[];

    touchedSpots.forEach((element) {
      final textStyle = TextStyle(
        color: element.bar.gradient?.colors.first ?? element.bar.color ?? Colors.blueGrey,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      );

      final price = element.y.round().toString().split('.')[0].toCurrency();

      list.add(
        LineTooltipItem(
          price,
          textStyle,
          textAlign: TextAlign.end,
        ),
      );
    });

    return list;
  }

  ///
  FlGridData getFlGridData() {
    final flline = FlLine(color: Colors.white30, strokeWidth: 1);

    return FlGridData(
      show: true,
      drawVerticalLine: true,

      //横線
      getDrawingHorizontalLine: (value) => flline,

      //縦線
      getDrawingVerticalLine: (value) => flline,
    );
  }

  ///
  String getCreditListItem({required String item}) {
    var ret = item.replaceAll('ＪＣＢ国内利用　', '').replaceAll('ＪＣＢ海外利用　', '').replaceAll('JCB ', '');

    //-------------------------//
    var reg = RegExp('西友ネットスーパー');

    if (reg.firstMatch(item) != null) {
      final exItem = item.split('　 ');
      ret = exItem[0];
    }
    //-------------------------//

    //-------------------------//
    reg = RegExp('さくらインターネット');

    if (reg.firstMatch(item) != null) {
      final exItem = item.split('　');
      ret = exItem[0];
    }
    //-------------------------//

    //-------------------------//
    reg = RegExp('ドコモご利用料金');

    if (reg.firstMatch(item) != null) {
      final exItem = item.split('　');
      ret = exItem[0];
    }
    //-------------------------//

    //-------------------------//
    reg = RegExp('NINTENDO');

    if (reg.firstMatch(item) != null) {
      ret = 'NINTENDO';
    }
    //-------------------------//

    ret = halfKatakanaToFullLength(val: ret);

    ret = ret.alphanumericToHalfLength();

    return ret.toUpperCase();
  }

  ///
  Map<String, int> getFixPaymentValue() {
    // 1 同金額で毎月必要なもの
    // 2 金額は変わるが毎月必要なもの
    // 3 税金類
    return {
      '食費': 2,
      '牛乳代': 2,
      '弁当代': 2,
      '住居費': 1,
      '交通費': 2,
      '支払い': 0,
      'credit': 2,
      '遊興費': 0,
      'ジム会費': 1,
      'お賽銭': 2,
      '交際費': 0,
      '雑費': 0,
      '教育費': 0,
      '機材費': 0,
      '被服費': 0,
      '医療費': 0,
      '美容費': 0,
      '通信費': 0,
      '保険料': 1,
      '水道光熱費': 2,
      '共済代': 1,
      'GOLD': 1,
      '投資信託': 1,
      '株式買付': 1,
      'アイアールシー': 1,
      '手数料': 0,
      '不明': 0,
      'メルカリ': 0,
      '利息': 0,
      'プラス': 0,
      '所得税': 3,
      '住民税': 3,
      '年金': 3,
      '国民年金基金': 1,
      '国民健康保険': 3
    };
  }
}

class NavigationService {
  const NavigationService._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
