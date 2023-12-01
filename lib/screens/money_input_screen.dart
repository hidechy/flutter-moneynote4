// ignore_for_file: must_be_immutable, cascade_invocations, use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:soundpool/soundpool.dart';
import 'package:vibration/vibration.dart';

import '../extensions/extensions.dart';
import '../models/money.dart';
import '../route/routes.dart';
import '../state/money/money_notifier.dart';
import '../state/money_input/money_input_notifier.dart';
import '../state/spend/spend_notifier.dart';
import '../utility/utility.dart';

class MoneyInputScreen extends ConsumerWidget {
  MoneyInputScreen({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  String lastInputDate = '';

  int lastSum = 0;
  int formTotal = 0;

  Money moneyState = Money(
    date: DateTime.now(),
    ym: '',
    yen10000: '',
    yen5000: '',
    yen2000: '',
    yen1000: '',
    yen500: '',
    yen100: '',
    yen50: '',
    yen10: '',
    yen5: '',
    yen1: '',
    bankA: '',
    bankB: '',
    bankC: '',
    bankD: '',
    bankE: '',
    payA: '',
    payB: '',
    payC: '',
    payD: '',
    payE: '',
    sum: '',
    currency: 0,
  );

  TextEditingController tecYen10000 = TextEditingController(text: '0');
  TextEditingController tecYen5000 = TextEditingController(text: '0');
  TextEditingController tecYen2000 = TextEditingController(text: '0');
  TextEditingController tecYen1000 = TextEditingController(text: '0');
  TextEditingController tecYen500 = TextEditingController(text: '0');
  TextEditingController tecYen100 = TextEditingController(text: '0');
  TextEditingController tecYen50 = TextEditingController(text: '0');
  TextEditingController tecYen10 = TextEditingController(text: '0');
  TextEditingController tecYen5 = TextEditingController(text: '0');
  TextEditingController tecYen1 = TextEditingController(text: '0');

  TextEditingController tecBankA = TextEditingController(text: '0');
  TextEditingController tecBankB = TextEditingController(text: '0');
  TextEditingController tecBankC = TextEditingController(text: '0');
  TextEditingController tecBankD = TextEditingController(text: '0');
  TextEditingController tecBankE = TextEditingController(text: '0');

  TextEditingController tecPayA = TextEditingController(text: '0');
  TextEditingController tecPayB = TextEditingController(text: '0');
  TextEditingController tecPayC = TextEditingController(text: '0');
  TextEditingController tecPayD = TextEditingController(text: '0');
  TextEditingController tecPayE = TextEditingController(text: '0');

  Soundpool soundpool = Soundpool(streamType: StreamType.notification);

  late int soundC;
  late int soundD;
  late int soundE;

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    loadSound();

    //
    //
    // final spendMonthDetailState = _ref.watch(spendMonthDetailProvider(date));
    //
    // if (spendMonthDetailState.list.isNotEmpty) {
    //   lastInputDate = spendMonthDetailState.list[spendMonthDetailState.list.length - 1].date.yyyymmdd;
    //
    //

    final spendYearlyList = _ref.watch(spendMonthDetailProvider(date).select((value) => value.spendYearlyList));

    if (spendYearlyList.value != null) {
      if (spendYearlyList.value!.isNotEmpty) {
        lastInputDate = spendYearlyList.value!.last.date.yyyymmdd;
      }
    } else {
      final now = DateTime.now();
      lastInputDate = DateTime(
        now.yyyymmdd.split('-')[0].toInt(),
        now.yyyymmdd.split('-')[1].toInt(),
        now.yyyymmdd.split('-')[2].toInt() - 1,
      ).yyyymmdd;
    }

    final formTotalState = ref.watch(formTotalProvider);

    final beforeCallState = ref.watch(beforeCallProvider);

    final spendDiffState = ref.watch(spendDiffProvider);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            _utility.getBackGround(),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Container(width: context.screenSize.width),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        IconButton(
                          onPressed: () => context.goNamed(RouteNames.home),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 90, child: Text('Today')),
                                  Text(date.yyyymmdd),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 90, child: Text('Last Day')),
                                  Text(
                                    lastInputDate,
                                    style: (date.yyyymmdd == lastInputDate)
                                        ? const TextStyle(
                                            color: Colors.yellowAccent,
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('form total'),
                              Text(
                                formTotalState.toString().toCurrency(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.3),
                      thickness: 2,
                    ),
                    displayMoneyInput(),
                    displayBankInput(),
                    displayPayInput(),
                    Divider(
                      color: Colors.white.withOpacity(0.3),
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await soundpool.play(soundC);

                                await ref.read(beforeCallProvider.notifier).setFlag(flag: 1);

                                setDefaultMoneyData();

                                // if (date.yyyymmdd != lastInputDate) {
                                //   setDefaultMoneyData(usage: 'before');
                                // }
                              },
                              icon: Icon(
                                Icons.copy,
                                color: (beforeCallState == 1) ? Colors.yellowAccent : Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await soundpool.play(soundD);

                                await ref.read(stopDefaultProvider.notifier).setStop(stop: 1);

                                makeTotal();
                              },
                              icon: const Icon(Icons.check_box),
                            ),
                            IconButton(
                              onPressed: () async {
                                await soundpool.play(soundE);

                                await ref.read(stopDefaultProvider.notifier).setStop(stop: 1);

                                await ref.read(spendDiffProvider.notifier).setSpend(spend: lastSum - formTotal);
                              },
                              icon: const Icon(Icons.arrow_circle_right),
                            ),
                            Text(spendDiffState.toString().toCurrency()),
                          ],
                        ),
                        IconButton(
                          onPressed: moneyInsert,
                          icon: const Icon(
                            Icons.input,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  void setDefaultMoneyData() {
    Money? ms;

    if (date.yyyymmdd == lastInputDate) {
      ms = _ref.watch(moneyProvider(date).select((value) => value.money));
    } else {
      ms = _ref.watch(moneyProvider(DateTime.parse('$lastInputDate 00:00:00')).select((value) => value.money));
    }

    if (ms != null) {
      moneyState = ms;
    }

    tecYen10000.text = moneyState.yen10000;
    tecYen5000.text = moneyState.yen5000;
    tecYen2000.text = moneyState.yen2000;
    tecYen1000.text = moneyState.yen1000;
    tecYen500.text = moneyState.yen500;
    tecYen100.text = moneyState.yen100;
    tecYen50.text = moneyState.yen50;
    tecYen10.text = moneyState.yen10;
    tecYen5.text = moneyState.yen5;
    tecYen1.text = moneyState.yen1;

    tecBankA.text = moneyState.bankA;
    tecBankB.text = moneyState.bankB;
    tecBankC.text = moneyState.bankC;
    tecBankD.text = moneyState.bankD;
    tecBankE.text = moneyState.bankE;

    tecPayA.text = moneyState.payA;
    tecPayB.text = moneyState.payB;
    tecPayC.text = moneyState.payC;
    tecPayD.text = moneyState.payD;
    tecPayE.text = moneyState.payE;

    _ref.read(moneyInputProvider.notifier).setDate(date: date.yyyymmdd);

    _ref.read(moneyInputProvider.notifier).setYen10000(yen10000: moneyState.yen10000);
    _ref.read(moneyInputProvider.notifier).setYen5000(yen5000: moneyState.yen5000);
    _ref.read(moneyInputProvider.notifier).setYen2000(yen2000: moneyState.yen2000);
    _ref.read(moneyInputProvider.notifier).setYen1000(yen1000: moneyState.yen1000);
    _ref.read(moneyInputProvider.notifier).setYen500(yen500: moneyState.yen500);
    _ref.read(moneyInputProvider.notifier).setYen100(yen100: moneyState.yen100);
    _ref.read(moneyInputProvider.notifier).setYen50(yen50: moneyState.yen50);
    _ref.read(moneyInputProvider.notifier).setYen10(yen10: moneyState.yen10);
    _ref.read(moneyInputProvider.notifier).setYen5(yen5: moneyState.yen5);
    _ref.read(moneyInputProvider.notifier).setYen1(yen1: moneyState.yen1);

    _ref.read(moneyInputProvider.notifier).setBankA(bankA: moneyState.bankA);
    _ref.read(moneyInputProvider.notifier).setBankB(bankB: moneyState.bankB);
    _ref.read(moneyInputProvider.notifier).setBankC(bankC: moneyState.bankC);
    _ref.read(moneyInputProvider.notifier).setBankD(bankD: moneyState.bankD);
    _ref.read(moneyInputProvider.notifier).setBankE(bankE: moneyState.bankE);

    _ref.read(moneyInputProvider.notifier).setPayA(payA: moneyState.payA);
    _ref.read(moneyInputProvider.notifier).setPayB(payB: moneyState.payB);
    _ref.read(moneyInputProvider.notifier).setPayC(payC: moneyState.payC);
    _ref.read(moneyInputProvider.notifier).setPayD(payD: moneyState.payD);
    _ref.read(moneyInputProvider.notifier).setPayE(payE: moneyState.payE);

    lastSum = moneyState.sum.toInt();
  }

  ///
  Widget displayMoneyInput() {
    return Column(
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
            Expanded(child: Container()),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: displayInputParts(
                name: '10000',
                kind: 'yen_10000',
                tec: tecYen10000,
              ),
            ),
            Expanded(
              child: displayInputParts(
                name: '5000',
                kind: 'yen_5000',
                tec: tecYen5000,
              ),
            ),
            Expanded(
              child: displayInputParts(
                name: '2000',
                kind: 'yen_2000',
                tec: tecYen2000,
              ),
            ),
            Expanded(
              child: displayInputParts(
                name: '1000',
                kind: 'yen_1000',
                tec: tecYen1000,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: displayInputParts(
                name: '500',
                kind: 'yen_500',
                tec: tecYen500,
              ),
            ),
            Expanded(
              child: displayInputParts(
                name: '100',
                kind: 'yen_100',
                tec: tecYen100,
              ),
            ),
            Expanded(
              child: displayInputParts(
                name: '50',
                kind: 'yen_50',
                tec: tecYen50,
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: displayInputParts(
                name: '10',
                kind: 'yen_10',
                tec: tecYen10,
              ),
            ),
            Expanded(
              child: displayInputParts(
                name: '5',
                kind: 'yen_5',
                tec: tecYen5,
              ),
            ),
            Expanded(
              child: displayInputParts(
                name: '1',
                kind: 'yen_1',
                tec: tecYen1,
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }

  ///
  Widget displayBankInput() {
    final bankName = _utility.getBankName();

    return Column(
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
            Expanded(child: Container()),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: displayInputParts(
                name: bankName['bank_a'].toString(),
                kind: 'bank_a',
                tec: tecBankA,
              ),
            ),
            Expanded(
              child: displayInputParts(
                name: bankName['bank_b'].toString(),
                kind: 'bank_b',
                tec: tecBankB,
              ),
            ),
            Expanded(
              child: displayInputParts(
                name: bankName['bank_c'].toString(),
                kind: 'bank_c',
                tec: tecBankC,
              ),
            ),
            Expanded(
              child: displayInputParts(
                name: bankName['bank_d'].toString(),
                kind: 'bank_d',
                tec: tecBankD,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: displayInputParts(
                name: bankName['bank_e'].toString(),
                kind: 'bank_e',
                tec: tecBankE,
              ),
            ),
            Expanded(child: Container()),
            Expanded(child: Container()),
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }

  ///
  Widget displayPayInput() {
    final bankName = _utility.getBankName();

    return Column(
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
        Row(
          children: [
            Expanded(
              child: displayInputParts(
                name: bankName['pay_a'].toString(),
                kind: 'pay_a',
                tec: tecPayA,
              ),
            ),
            Expanded(
              child: displayInputParts(
                name: bankName['pay_b'].toString(),
                kind: 'pay_b',
                tec: tecPayB,
              ),
            ),
            Expanded(
              child: displayInputParts(
                name: bankName['pay_c'].toString(),
                kind: 'pay_c',
                tec: tecPayC,
              ),
            ),
            Expanded(
              child: displayInputParts(
                name: bankName['pay_d'].toString(),
                kind: 'pay_d',
                tec: tecPayD,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: displayInputParts(
                name: bankName['pay_e'].toString(),
                kind: 'pay_e',
                tec: tecPayE,
              ),
            ),
            Expanded(child: Container()),
            Expanded(child: Container()),
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }

  ///
  Widget displayInputParts({required String name, required String kind, required TextEditingController tec}) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: tec,
        textAlign: TextAlign.end,
        decoration: InputDecoration(labelText: name),
        style: const TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
        onChanged: (value) {
          setMoneyInputStateKind(kind: kind, value: value);
        },
      ),
    );
  }

  ///
  void setMoneyInputStateKind({required String kind, required String value}) {
    final inputMoneyViewModel = _ref.read(moneyInputProvider.notifier);

    inputMoneyViewModel.setDate(date: date.yyyymmdd);

    switch (kind) {
      case 'yen_10000':
        inputMoneyViewModel.setYen10000(yen10000: value);
        break;
      case 'yen_5000':
        inputMoneyViewModel.setYen5000(yen5000: value);
        break;
      case 'yen_2000':
        inputMoneyViewModel.setYen2000(yen2000: value);
        break;
      case 'yen_1000':
        inputMoneyViewModel.setYen1000(yen1000: value);
        break;
      case 'yen_500':
        inputMoneyViewModel.setYen500(yen500: value);
        break;
      case 'yen_100':
        inputMoneyViewModel.setYen100(yen100: value);
        break;
      case 'yen_50':
        inputMoneyViewModel.setYen50(yen50: value);
        break;
      case 'yen_10':
        inputMoneyViewModel.setYen10(yen10: value);
        break;
      case 'yen_5':
        inputMoneyViewModel.setYen5(yen5: value);
        break;
      case 'yen_1':
        inputMoneyViewModel.setYen1(yen1: value);
        break;
      case 'bank_a':
        inputMoneyViewModel.setBankA(bankA: value);
        break;
      case 'bank_b':
        inputMoneyViewModel.setBankB(bankB: value);
        break;
      case 'bank_c':
        inputMoneyViewModel.setBankC(bankC: value);
        break;
      case 'bank_d':
        inputMoneyViewModel.setBankD(bankD: value);
        break;
      case 'bank_e':
        inputMoneyViewModel.setBankE(bankE: value);
        break;
      case 'pay_a':
        inputMoneyViewModel.setPayA(payA: value);
        break;
      case 'pay_b':
        inputMoneyViewModel.setPayB(payB: value);
        break;
      case 'pay_c':
        inputMoneyViewModel.setPayC(payC: value);
        break;
      case 'pay_d':
        inputMoneyViewModel.setPayD(payD: value);
        break;
      case 'pay_e':
        inputMoneyViewModel.setPayE(payE: value);
        break;
    }
  }

  ///
  void makeTotal() {
    var onedayTotal = 0;

    final totalValue = <List<String>>[];
    totalValue.add(['10000', tecYen10000.text]);
    totalValue.add(['5000', tecYen5000.text]);
    totalValue.add(['2000', tecYen2000.text]);
    totalValue.add(['1000', tecYen1000.text]);
    totalValue.add(['500', tecYen500.text]);
    totalValue.add(['100', tecYen100.text]);
    totalValue.add(['50', tecYen50.text]);
    totalValue.add(['10', tecYen10.text]);
    totalValue.add(['5', tecYen5.text]);
    totalValue.add(['1', tecYen1.text]);

    totalValue.add(['1', tecBankA.text]);
    totalValue.add(['1', tecBankB.text]);
    totalValue.add(['1', tecBankC.text]);
    totalValue.add(['1', tecBankD.text]);
    totalValue.add(['1', tecBankE.text]);

    totalValue.add(['1', tecPayA.text]);
    totalValue.add(['1', tecPayB.text]);
    totalValue.add(['1', tecPayC.text]);
    totalValue.add(['1', tecPayD.text]);
    totalValue.add(['1', tecPayE.text]);

    for (var i = 0; i < totalValue.length; i++) {
      onedayTotal += totalValue[i][0].toInt() * totalValue[i][1].toInt();
    }

    _ref.read(formTotalProvider.notifier).setTotal(total: onedayTotal);

    formTotal = onedayTotal;
  }

  ///
  Future<void> moneyInsert() async {
    final uploadData = <String, dynamic>{};

    uploadData['date'] = date.yyyymmdd;

    uploadData['yen_10000'] = tecYen10000.text;
    uploadData['yen_5000'] = tecYen5000.text;
    uploadData['yen_2000'] = tecYen2000.text;
    uploadData['yen_1000'] = tecYen1000.text;
    uploadData['yen_500'] = tecYen500.text;
    uploadData['yen_100'] = tecYen100.text;
    uploadData['yen_50'] = tecYen50.text;
    uploadData['yen_10'] = tecYen10.text;
    uploadData['yen_5'] = tecYen5.text;
    uploadData['yen_1'] = tecYen1.text;

    uploadData['bank_a'] = tecBankA.text;
    uploadData['bank_b'] = tecBankB.text;
    uploadData['bank_c'] = tecBankC.text;
    uploadData['bank_d'] = tecBankD.text;
    uploadData['bank_e'] = tecBankE.text;

    uploadData['pay_a'] = tecPayA.text;
    uploadData['pay_b'] = tecPayB.text;
    uploadData['pay_c'] = tecPayC.text;
    uploadData['pay_d'] = tecPayD.text;
    uploadData['pay_e'] = tecPayE.text;

    await _ref.read(moneyInputProvider.notifier).insertMoney(uploadData: uploadData);

    await _ref.read(moneyProvider(date).notifier).getMoney(date: date);

    await Vibration.vibrate(pattern: [500, 1000, 500, 2000]);

    _context.goNamed(RouteNames.home);
  }

  ///
  Future<void> loadSound() async {
    soundC = await rootBundle.load('assets/sounds/sound_c.mp3').then((ByteData soundData) {
      return soundpool.load(soundData);
    });

    soundD = await rootBundle.load('assets/sounds/sound_d.mp3').then((ByteData soundData) {
      return soundpool.load(soundData);
    });

    soundE = await rootBundle.load('assets/sounds/sound_e.mp3').then((ByteData soundData) {
      return soundpool.load(soundData);
    });
  }
}

////////////////////////////////////////////////////////////
final beforeCallProvider = StateNotifierProvider.autoDispose<BeforeCallStateNotifier, int>((ref) {
  return BeforeCallStateNotifier();
});

class BeforeCallStateNotifier extends StateNotifier<int> {
  BeforeCallStateNotifier() : super(0);

  ///
  Future<void> setFlag({required int flag}) async {
    state = flag;
  }
}

////////////////////////////////////////////////////////////
final formTotalProvider = StateNotifierProvider.autoDispose<FormTotalStateNotifier, int>((ref) {
  return FormTotalStateNotifier();
});

class FormTotalStateNotifier extends StateNotifier<int> {
  FormTotalStateNotifier() : super(0);

  ///
  Future<void> setTotal({required int total}) async {
    state = total;
  }
}

////////////////////////////////////////////////////////////
final spendDiffProvider = StateNotifierProvider.autoDispose<SpendDiffStateNotifier, int>((ref) {
  return SpendDiffStateNotifier();
});

class SpendDiffStateNotifier extends StateNotifier<int> {
  SpendDiffStateNotifier() : super(0);

  ///
  Future<void> setSpend({required int spend}) async {
    state = spend;
  }
}

////////////////////////////////////////////////////////////
final stopDefaultProvider = StateNotifierProvider.autoDispose<StopDefaultStateNotifier, int>((ref) {
  return StopDefaultStateNotifier();
});

class StopDefaultStateNotifier extends StateNotifier<int> {
  StopDefaultStateNotifier() : super(0);

  ///
  Future<void> setStop({required int stop}) async {
    state = stop;
  }
}
