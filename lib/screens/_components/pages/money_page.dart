// ignore_for_file: must_be_immutable, unnecessary_null_comparison, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../models/money.dart';
import '../../../state/app_param/app_param_notifier.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../utility/utility.dart';
import '../../../viewmodel/bank_notifier.dart';
import '../../../viewmodel/gold_notifier.dart';
import '../../../viewmodel/money_notifier.dart';
import '../../../viewmodel/shintaku_notifier.dart';
import '../../../viewmodel/spend_notifier.dart';
import '../../../viewmodel/stock_notifier.dart';
import '../../bank_input_screen.dart';
import '../../money_input_screen.dart';
import '../../spend_item_input_screen.dart';
import '../../timeplace_input_screen.dart';
import '../_money_dialog.dart';
import '../bank_alert.dart';
import '../gold_alert.dart';
import '../shintaku_alert.dart';
import '../spend_alert.dart';
import '../spend_year_day_alert.dart';
import '../stock_alert.dart';

class MoneyPage extends ConsumerWidget {
  MoneyPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  List<int> notMoneyAsset = [];

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final moneyState = ref.watch(moneyProvider(date));

    final yesterday = _utility.makeSpecialDate(
        date: date, usage: 'day', plusminus: 'minus', num: 1);

    final yesterdayMoney = ref.watch(moneyProvider(yesterday!));

    final total = (moneyState.sum == '') ? '0' : moneyState.sum;
    final diff = (moneyState.sum == '' || yesterdayMoney.sum == '')
        ? '0'
        : (yesterdayMoney.sum.toInt() - moneyState.sum.toInt()).toString();

    final deviceInfoState = ref.read(deviceInfoProvider);

    final appParamState = ref.watch(appParamProvider);

    notMoneyAsset = [];

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(width: context.screenSize.width),

                //----------//
                if (deviceInfoState.model == 'iPhone')
                  _utility.getFileNameDebug(name: runtimeType.toString()),
                //----------//

                ExpansionTile(
                  initiallyExpanded: appParamState.openMoneyArea,
                  iconColor: Colors.white,
                  onExpansionChanged: (value) {
                    ref
                        .watch(appParamProvider.notifier)
                        .setOpenMoneyArea(value: value);
                  },
                  title: Text(
                    appParamState.openMoneyArea == false ? 'OPEN' : 'CLOSE',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MoneyInputScreen(date: date);
                                      },
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.input),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SpendItemInputScreen(
                                          date: date,
                                          diff: diff,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.list),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return TimeplaceInputScreen(
                                          date: date,
                                          diff: diff,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.access_time),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    total.toCurrency(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    diff.toCurrency(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              (total == '0')
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () {
                                        MoneyDialog(
                                          context: context,
                                          widget: SpendAlert(
                                            date: date,
                                            diff: diff,
                                          ),
                                        );
                                      },
                                      child: const Icon(Icons.info_outline),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    displaySamedaySpendYearly(),
                    const SizedBox(height: 30),
                    displayMoney(data: moneyState),
                    const SizedBox(height: 30),
                    displayBank(data: moneyState),
                    const SizedBox(height: 30),
                    displayPay(data: moneyState),
                    const SizedBox(height: 30),
                  ],
                ),

                Divider(
                  color: Colors.deepPurple.withOpacity(0.3),
                  thickness: 5,
                ),
                const SizedBox(height: 10),

                displayGold(),
                const SizedBox(height: 30),
                displayStock(),
                const SizedBox(height: 30),
                displayShintaku(),
                const SizedBox(height: 30),
                displayNotMoneyAsset(),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displaySamedaySpendYearly() {
    final list = <Widget>[];

    final samedaySpendYearlyState =
        _ref.watch(samedaySpendYearlyProvider(date));

    samedaySpendYearlyState.forEach((element) {
      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${element.year}-01-01\n-> ${date.mmdd}',
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    element.spend.toString().toCurrency(),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    element.salary.toString().toCurrency(),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    (element.spend + element.salary).toString().toCurrency(),
                    style: const TextStyle(color: Color(0xFFFBB6CE)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  MoneyDialog(
                    context: _context,
                    widget: SpendYearDayAlert(
                      date: DateTime(
                        element.year,
                        date.mm.toInt(),
                        date.dd.toInt(),
                      ),
                      spend: element.spend + element.salary,
                    ),
                  );
                },
                child: const Icon(Icons.info_outline),
              ),
            ],
          ),
        ),
      );
    });

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 10),
      child: Column(children: list),
    );
  }

  ///
  Widget displayMoney({required Money data}) {
    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: const Text('CURRENCY'),
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.topRight,
                child: Text(
                  data.currency.toString().toCurrency(),
                  style: const TextStyle(color: Colors.yellowAccent),
                ),
              )),
            ],
          ),
          const SizedBox(height: 10),
          getMoneyDispRow(key: '10000', value: data.yen10000),
          getMoneyDispRow(key: '5000', value: data.yen5000),
          getMoneyDispRow(key: '2000', value: data.yen2000),
          getMoneyDispRow(key: '1000', value: data.yen1000),
          getMoneyDispRow(key: '500', value: data.yen500),
          getMoneyDispRow(key: '100', value: data.yen100),
          getMoneyDispRow(key: '50', value: data.yen50),
          getMoneyDispRow(key: '10', value: data.yen10),
          getMoneyDispRow(key: '5', value: data.yen5),
          getMoneyDispRow(key: '1', value: data.yen1),
        ],
      ),
    );
  }

  ///
  Widget getMoneyDispRow({required String key, required String value}) {
    if (key == '' || value == '') {
      return Container();
    }

    final bankName = _utility.getBankName();

    final dispKey = (bankName[key] != null) ? bankName[key] : key;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(dispKey.toString()),
          Text((value == 'null') ? '0' : value.toCurrency()),
        ],
      ),
    );
  }

  ///
  Widget displayBank({required Money data}) {
    final bankStateA = _ref.watch(bankLastProvider('bank_a'));
    final bankStateB = _ref.watch(bankLastProvider('bank_b'));
    final bankStateC = _ref.watch(bankLastProvider('bank_c'));
    final bankStateD = _ref.watch(bankLastProvider('bank_d'));
    final bankStateE = _ref.watch(bankLastProvider('bank_e'));

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: const Text('BANK'),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        _context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BankInputScreen(date: date);
                          },
                        ),
                      );
                    },
                    child: const Icon(Icons.business),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          DefaultTextStyle(
            style: const TextStyle(fontSize: 16),
            child: Column(
              children: [
                getBankDispRow(
                  name: 'bank_a',
                  price: data.bankA,
                  dt: bankStateA.date.toString(),
                ),
                getBankDispRow(
                  name: 'bank_b',
                  price: data.bankB,
                  dt: bankStateB.date.toString(),
                ),
                getBankDispRow(
                  name: 'bank_c',
                  price: data.bankC,
                  dt: bankStateC.date.toString(),
                ),
                getBankDispRow(
                  name: 'bank_d',
                  price: data.bankD,
                  dt: bankStateD.date.toString(),
                ),
                getBankDispRow(
                  name: 'bank_e',
                  price: data.bankE,
                  dt: bankStateE.date.toString(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget getBankDispRow(
      {required String name, required String price, required String dt}) {
    if (name == '' || price == '' || dt == '') {
      return Container();
    }

    final bankName = _utility.getBankName();

    final dayDiff = DateTime.now()
        .difference(DateTime.parse('${dt.split(' ')[0]} 00:00:00'))
        .inDays;

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: (dayDiff < 365) ? Colors.white : Colors.grey,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      MoneyDialog(
                        context: _context,
                        widget: BankAlert(name: name),
                      );
                    },
                    child: Icon(
                      Icons.info_outline,
                      color: (dayDiff < 365) ? Colors.white : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(bankName[name].toString()),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text((price == 'null') ? '0' : price.toCurrency()),
                  Text(dt.split(' ')[0]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayPay({required Money data}) {
    final payStateA = _ref.watch(bankLastProvider('pay_a'));
    final payStateB = _ref.watch(bankLastProvider('pay_b'));
    final payStateC = _ref.watch(bankLastProvider('pay_c'));
    final payStateD = _ref.watch(bankLastProvider('pay_d'));
    final payStateE = _ref.watch(bankLastProvider('pay_e'));

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: const Text('E-MONEY'),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          const SizedBox(height: 10),
          DefaultTextStyle(
            style: const TextStyle(fontSize: 16),
            child: Column(
              children: [
                getBankDispRow(
                  name: 'pay_a',
                  price: data.payA,
                  dt: payStateA.date.toString(),
                ),
                getBankDispRow(
                  name: 'pay_b',
                  price: data.payB,
                  dt: payStateB.date.toString(),
                ),
                getBankDispRow(
                  name: 'pay_c',
                  price: data.payC,
                  dt: payStateC.date.toString(),
                ),
                getBankDispRow(
                  name: 'pay_d',
                  price: data.payD,
                  dt: payStateD.date.toString(),
                ),
                getBankDispRow(
                  name: 'pay_e',
                  price: data.payE,
                  dt: payStateE.date.toString(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget displayGold() {
    final goldState = _ref.watch(goldLastProvider(date));

    if (goldState == null) {
      return Container();
    }

    final goldDate = '${goldState.year}-${goldState.month}-${goldState.day}';

    var goldDiff = 0;

    var score = 0;

    if (goldState.goldValue != null && goldState.payPrice != null) {
      goldDiff = goldState.goldValue.toString().toInt() -
          goldState.payPrice.toString().toInt();

      notMoneyAsset.add(goldState.goldValue);

      score = ((goldState.goldValue.toString().toInt() /
                  goldState.payPrice.toString().toInt()) *
              100)
          .round();
    }

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: const Text('GOLD'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(goldDate),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (goldState.payPrice == null)
                        ? Container()
                        : Text(goldState.payPrice.toString().toCurrency()),
                    (goldState.goldValue == null)
                        ? Container()
                        : Text(
                            goldState.goldValue.toString().toCurrency(),
                            style: const TextStyle(color: Colors.yellowAccent),
                          ),
                    Text(goldDiff.toString().toCurrency()),
                    Text('$score %'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                MoneyDialog(
                  context: _context,
                  widget: GoldAlert(),
                );
              },
              child: const Icon(Icons.info_outline),
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget displayStock() {
    final stockState = _ref.watch(stockProvider(date));

    notMoneyAsset.add(stockState.price);

    var score = '';

    if (stockState.price != null && stockState.cost != null) {
      score = ((stockState.price.toString().toInt() /
                  stockState.cost.toString().toInt()) *
              100)
          .toString()
          .split('.')[0];
    }

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: const Text('STOCK'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(stockState.date.yyyymmdd),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(stockState.cost.toString().toCurrency()),
                    Text(
                      stockState.price.toString().toCurrency(),
                      style: const TextStyle(color: Colors.yellowAccent),
                    ),
                    Text(stockState.diff.toString().toCurrency()),
                    Text('$score %'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                MoneyDialog(
                  context: _context,
                  widget: StockAlert(date: stockState.date),
                );
              },
              child: const Icon(Icons.info_outline),
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget displayShintaku() {
    final shintakuState = _ref.watch(shintakuProvider(date));

    notMoneyAsset.add(shintakuState.price);

    var score = '';

    if (shintakuState.price != null && shintakuState.cost != null) {
      score = ((shintakuState.price.toString().toInt() /
                  shintakuState.cost.toString().toInt()) *
              100)
          .toString()
          .split('.')[0];
    }

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: const Text('SHINTAKU'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(shintakuState.date.yyyymmdd),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(shintakuState.cost.toString().toCurrency()),
                    Text(
                      shintakuState.price.toString().toCurrency(),
                      style: const TextStyle(color: Colors.yellowAccent),
                    ),
                    Text(shintakuState.diff.toString().toCurrency()),
                    Text('$score %'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                MoneyDialog(
                  context: _context,
                  widget: ShintakuAlert(date: shintakuState.date),
                );
              },
              child: const Icon(Icons.info_outline),
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget displayNotMoneyAsset() {
    var price = 0;
    notMoneyAsset.forEach((element) {
      price += element;
    });

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(color: Colors.deepPurple.withOpacity(0.3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Text(
            price.toString().toCurrency(),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.yellowAccent,
            ),
          ),
        ],
      ),
    );
  }
}