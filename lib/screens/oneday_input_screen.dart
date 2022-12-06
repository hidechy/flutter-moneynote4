// ignore_for_file: must_be_immutable, cascade_invocations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../models/money.dart';
import '../utility/utility.dart';
import '../viewmodel/money_notifier.dart';
import '../viewmodel/oneday_input_notifier.dart';
import '../viewmodel/spend_notifier.dart';

class OnedayInputScreen extends ConsumerWidget {
  OnedayInputScreen({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  String lastInputDate = '';

  int lastSum = 0;
  int formTotal = 0;

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final spendMonthDetailState = _ref.watch(spendMonthDetailProvider(date));

    if (spendMonthDetailState.isNotEmpty) {
      lastInputDate =
          spendMonthDetailState[spendMonthDetailState.length - 1].date.yyyymmdd;
    }

    final formTotalState = ref.watch(formTotalProvider);

    final beforeCallState = ref.watch(beforeCallProvider);

    final stopDefaultState = ref.watch(stopDefaultProvider);

    if (beforeCallState == 0 && stopDefaultState == 0) {
      setDefaultMoneyData(usage: 'today');
    }

    final spendDiffState = ref.watch(spendDiffProvider);

    return Scaffold(
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
                        onPressed: () => Navigator.pop(context),
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
                                const SizedBox(
                                    width: 90, child: Text('Last Day')),
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
                            onPressed: () {
                              ref
                                  .watch(beforeCallProvider.notifier)
                                  .setFlag(flag: 1);

                              if (date.yyyymmdd != lastInputDate) {
                                setDefaultMoneyData(usage: 'before');
                              }
                            },
                            icon: Icon(
                              Icons.copy,
                              color: (beforeCallState == 1)
                                  ? Colors.yellowAccent
                                  : Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .watch(stopDefaultProvider.notifier)
                                  .setStop(stop: 1);

                              makeTotal();
                            },
                            icon: const Icon(Icons.check_box),
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .watch(stopDefaultProvider.notifier)
                                  .setStop(stop: 1);

                              ref
                                  .watch(spendDiffProvider.notifier)
                                  .setSpend(spend: lastSum - formTotal);
                            },
                            icon: const Icon(Icons.arrow_circle_right),
                          ),
                          Text(spendDiffState.toString().toCurrency()),
                        ],
                      ),
                      IconButton(
                        onPressed: updateMoney,
                        icon: const Icon(Icons.input),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  void setDefaultMoneyData({required String usage}) {
    var moneyState = Money(
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
    );

    switch (usage) {
      case 'today':
        moneyState = _ref.watch(moneyProvider(date));
        break;
      case 'before':
        moneyState = _ref.watch(
          moneyProvider(
            '$lastInputDate 00:00:00'.toDateTime(),
          ),
        );
        break;
    }

    final yen10000State = _ref.watch(yen10000Provider);
    final yen5000State = _ref.watch(yen5000Provider);
    final yen2000State = _ref.watch(yen2000Provider);
    final yen1000State = _ref.watch(yen1000Provider);
    final yen500State = _ref.watch(yen500Provider);
    final yen100State = _ref.watch(yen100Provider);
    final yen50State = _ref.watch(yen50Provider);
    final yen10State = _ref.watch(yen10Provider);
    final yen5State = _ref.watch(yen5Provider);
    final yen1State = _ref.watch(yen1Provider);

    yen10000State.text =
        (moneyState.yen10000 == 'null') ? '0' : moneyState.yen10000;
    yen5000State.text =
        (moneyState.yen5000 == 'null') ? '0' : moneyState.yen5000;
    yen2000State.text =
        (moneyState.yen2000 == 'null') ? '0' : moneyState.yen2000;
    yen1000State.text =
        (moneyState.yen1000 == 'null') ? '0' : moneyState.yen1000;
    yen500State.text = (moneyState.yen500 == 'null') ? '0' : moneyState.yen500;
    yen100State.text = (moneyState.yen100 == 'null') ? '0' : moneyState.yen100;
    yen50State.text = (moneyState.yen50 == 'null') ? '0' : moneyState.yen50;
    yen10State.text = (moneyState.yen10 == 'null') ? '0' : moneyState.yen10;
    yen5State.text = (moneyState.yen5 == 'null') ? '0' : moneyState.yen5;
    yen1State.text = (moneyState.yen1 == 'null') ? '0' : moneyState.yen1;

    final bankAState = _ref.watch(bankAProvider);
    final bankBState = _ref.watch(bankBProvider);
    final bankCState = _ref.watch(bankCProvider);
    final bankDState = _ref.watch(bankDProvider);
    final bankEState = _ref.watch(bankEProvider);

    bankAState.text = (moneyState.bankA == 'null') ? '0' : moneyState.bankA;
    bankBState.text = (moneyState.bankB == 'null') ? '0' : moneyState.bankB;
    bankCState.text = (moneyState.bankC == 'null') ? '0' : moneyState.bankC;
    bankDState.text = (moneyState.bankD == 'null') ? '0' : moneyState.bankD;
    bankEState.text = (moneyState.bankE == 'null') ? '0' : moneyState.bankE;

    final payAState = _ref.watch(payAProvider);
    final payBState = _ref.watch(payBProvider);
    final payCState = _ref.watch(payCProvider);
    final payDState = _ref.watch(payDProvider);
    final payEState = _ref.watch(payEProvider);

    payAState.text = (moneyState.payA == 'null') ? '0' : moneyState.payA;
    payBState.text = (moneyState.payB == 'null') ? '0' : moneyState.payB;
    payCState.text = (moneyState.payC == 'null') ? '0' : moneyState.payC;
    payDState.text = (moneyState.payD == 'null') ? '0' : moneyState.payD;
    payEState.text = (moneyState.payE == 'null') ? '0' : moneyState.payE;

    if (moneyState.sum.toInt() > 0) {
      lastSum = moneyState.sum.toInt();
    }
  }

  ///
  Widget displayMoneyInput() {
    final yen10000State = _ref.watch(yen10000Provider);
    final yen5000State = _ref.watch(yen5000Provider);
    final yen2000State = _ref.watch(yen2000Provider);
    final yen1000State = _ref.watch(yen1000Provider);
    final yen500State = _ref.watch(yen500Provider);
    final yen100State = _ref.watch(yen100Provider);
    final yen50State = _ref.watch(yen50Provider);
    final yen10State = _ref.watch(yen10Provider);
    final yen5State = _ref.watch(yen5Provider);
    final yen1State = _ref.watch(yen1Provider);

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
                child: displayInputParts(kind: '10000', tec: yen10000State)),
            Expanded(child: displayInputParts(kind: '5000', tec: yen5000State)),
            Expanded(child: displayInputParts(kind: '2000', tec: yen2000State)),
            Expanded(child: displayInputParts(kind: '1000', tec: yen1000State)),
          ],
        ),
        Row(
          children: [
            Expanded(child: displayInputParts(kind: '500', tec: yen500State)),
            Expanded(child: displayInputParts(kind: '100', tec: yen100State)),
            Expanded(child: displayInputParts(kind: '50', tec: yen50State)),
            Expanded(child: Container()),
          ],
        ),
        Row(
          children: [
            Expanded(child: displayInputParts(kind: '10', tec: yen10State)),
            Expanded(child: displayInputParts(kind: '5', tec: yen5State)),
            Expanded(child: displayInputParts(kind: '1', tec: yen1State)),
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }

  ///
  Widget displayBankInput() {
    final bankName = _utility.getBankName();

    final bankAState = _ref.watch(bankAProvider);
    final bankBState = _ref.watch(bankBProvider);
    final bankCState = _ref.watch(bankCProvider);
    final bankDState = _ref.watch(bankDProvider);
    final bankEState = _ref.watch(bankEProvider);

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
                kind: bankName['bank_a'].toString(),
                tec: bankAState,
              ),
            ),
            Expanded(
              child: displayInputParts(
                kind: bankName['bank_b'].toString(),
                tec: bankBState,
              ),
            ),
            Expanded(
              child: displayInputParts(
                kind: bankName['bank_c'].toString(),
                tec: bankCState,
              ),
            ),
            Expanded(
              child: displayInputParts(
                kind: bankName['bank_d'].toString(),
                tec: bankDState,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: displayInputParts(
                kind: bankName['bank_e'].toString(),
                tec: bankEState,
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

    final payAState = _ref.watch(payAProvider);
    final payBState = _ref.watch(payBProvider);
    final payCState = _ref.watch(payCProvider);
    final payDState = _ref.watch(payDProvider);
    final payEState = _ref.watch(payEProvider);

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
                kind: bankName['pay_a'].toString(),
                tec: payAState,
              ),
            ),
            Expanded(
              child: displayInputParts(
                kind: bankName['pay_b'].toString(),
                tec: payBState,
              ),
            ),
            Expanded(
              child: displayInputParts(
                kind: bankName['pay_c'].toString(),
                tec: payCState,
              ),
            ),
            Expanded(
              child: displayInputParts(
                kind: bankName['pay_d'].toString(),
                tec: payDState,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: displayInputParts(
                kind: bankName['pay_e'].toString(),
                tec: payEState,
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
  Widget displayInputParts(
      {required String kind, required TextEditingController tec}) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: tec,
        textAlign: TextAlign.end,
        decoration: InputDecoration(labelText: kind),
        style: const TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
        onChanged: (value) {
          tec.text = value;
        },
      ),
    );
  }

  ///
  void makeTotal() {
    var onedayTotal = 0;

    final totalValue = <List<String>>[];
    totalValue.add(['10000', _ref.watch(yen10000Provider).text]);
    totalValue.add(['5000', _ref.watch(yen5000Provider).text]);
    totalValue.add(['2000', _ref.watch(yen2000Provider).text]);
    totalValue.add(['1000', _ref.watch(yen1000Provider).text]);
    totalValue.add(['500', _ref.watch(yen500Provider).text]);
    totalValue.add(['100', _ref.watch(yen100Provider).text]);
    totalValue.add(['50', _ref.watch(yen50Provider).text]);
    totalValue.add(['10', _ref.watch(yen10Provider).text]);
    totalValue.add(['5', _ref.watch(yen5Provider).text]);
    totalValue.add(['1', _ref.watch(yen1Provider).text]);

    totalValue.add(['1', _ref.watch(bankAProvider).text]);
    totalValue.add(['1', _ref.watch(bankBProvider).text]);
    totalValue.add(['1', _ref.watch(bankCProvider).text]);
    totalValue.add(['1', _ref.watch(bankDProvider).text]);
    totalValue.add(['1', _ref.watch(bankEProvider).text]);

    totalValue.add(['1', _ref.watch(payAProvider).text]);
    totalValue.add(['1', _ref.watch(payBProvider).text]);
    totalValue.add(['1', _ref.watch(payCProvider).text]);
    totalValue.add(['1', _ref.watch(payDProvider).text]);
    totalValue.add(['1', _ref.watch(payEProvider).text]);

    for (var i = 0; i < totalValue.length; i++) {
      onedayTotal += totalValue[i][0].toInt() * totalValue[i][1].toInt();
    }

    _ref.watch(formTotalProvider.notifier).setTotal(total: onedayTotal);

    formTotal = onedayTotal;
  }

  ///
  Future<void> updateMoney() async {
    final uploadData = <String, dynamic>{};

    uploadData['date'] = date.yyyymmdd;

    uploadData['yen_10000'] = _ref.watch(yen10000Provider).text;
    uploadData['yen_5000'] = _ref.watch(yen5000Provider).text;
    uploadData['yen_2000'] = _ref.watch(yen2000Provider).text;
    uploadData['yen_1000'] = _ref.watch(yen1000Provider).text;
    uploadData['yen_500'] = _ref.watch(yen500Provider).text;
    uploadData['yen_100'] = _ref.watch(yen100Provider).text;
    uploadData['yen_50'] = _ref.watch(yen50Provider).text;
    uploadData['yen_10'] = _ref.watch(yen10Provider).text;
    uploadData['yen_5'] = _ref.watch(yen5Provider).text;
    uploadData['yen_1'] = _ref.watch(yen1Provider).text;

    uploadData['bank_a'] = _ref.watch(bankAProvider).text;
    uploadData['bank_b'] = _ref.watch(bankBProvider).text;
    uploadData['bank_c'] = _ref.watch(bankCProvider).text;
    uploadData['bank_d'] = _ref.watch(bankDProvider).text;
    uploadData['bank_e'] = _ref.watch(bankEProvider).text;

    uploadData['pay_a'] = _ref.watch(payAProvider).text;
    uploadData['pay_b'] = _ref.watch(payBProvider).text;
    uploadData['pay_c'] = _ref.watch(payCProvider).text;
    uploadData['pay_d'] = _ref.watch(payDProvider).text;
    uploadData['pay_e'] = _ref.watch(payEProvider).text;

    await _ref
        .watch(onedayInputProvider.notifier)
        .insertMoney(uploadData: uploadData);

    await _ref.watch(moneyProvider(date).notifier).getMoney(date: date);

    Navigator.pop(_context);
  }
}

////////////////////////////////////////////////////////////

final yen10000Provider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final yen5000Provider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final yen2000Provider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final yen1000Provider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final yen500Provider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final yen100Provider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final yen50Provider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final yen10Provider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final yen5Provider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final yen1Provider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final bankAProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final bankBProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final bankCProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final bankDProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final bankEProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final payAProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final payBProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final payCProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final payDProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

final payEProvider = StateProvider.autoDispose((ref) {
  return TextEditingController(text: '');
});

////////////////////////////////////////////////////////////
final beforeCallProvider =
    StateNotifierProvider.autoDispose<BeforeCallStateNotifier, int>((ref) {
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
final formTotalProvider =
    StateNotifierProvider.autoDispose<FormTotalStateNotifier, int>((ref) {
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
final spendDiffProvider =
    StateNotifierProvider.autoDispose<SpendDiffStateNotifier, int>((ref) {
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
final stopDefaultProvider =
    StateNotifierProvider.autoDispose<StopDefaultStateNotifier, int>((ref) {
  return StopDefaultStateNotifier();
});

class StopDefaultStateNotifier extends StateNotifier<int> {
  StopDefaultStateNotifier() : super(0);

  ///
  Future<void> setStop({required int stop}) async {
    state = stop;
  }
}
