// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../route/routes.dart';
import '../state/bank/bank_notifier.dart';
import '../state/bank_input/bank_input_notifier.dart';
import '../state/holiday/holiday_notifier.dart';
import '../utility/utility.dart';

class BankInputScreen extends ConsumerWidget {
  BankInputScreen({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  TextEditingController tecBankMoney = TextEditingController(text: '0');

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final bankInputState = ref.watch(bankInputProvider);
    return Scaffold(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: context.screenSize.height * 0.45,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.4), width: 2)),
                          child: Container(child: getMonthlyBankRecord()),
                        ),
                      ),
                      getButtonAreaWidget(),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: IconButton(
                                    onPressed: () => showDatepick(usage: 'left'),
                                    icon: Icon(Icons.calendar_month_outlined,
                                        color: (bankInputState.selectInOutFlag == 0)
                                            ? Colors.yellowAccent
                                            : Colors.lightBlueAccent),
                                  ),
                                ),
                                Text(
                                  (bankInputState.selectInOutFlag == 0)
                                      ? bankInputState.selectDate
                                      : bankInputState.outArrowDate,
                                  style: TextStyle(
                                      color: (bankInputState.selectInOutFlag == 0)
                                          ? Colors.yellowAccent
                                          : Colors.lightBlueAccent),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: (bankInputState.selectInOutFlag == 0)
                                ? Container()
                                : Row(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: IconButton(
                                          onPressed: () => showDatepick(usage: 'right'),
                                          icon: const Icon(Icons.calendar_month_outlined, color: Colors.greenAccent),
                                        ),
                                      ),
                                      Text(
                                        bankInputState.inArrowDate,
                                        style: const TextStyle(color: Colors.greenAccent),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: tecBankMoney,
                              textAlign: TextAlign.end,
                              decoration: const InputDecoration(labelText: 'Bank Money'),
                              style: const TextStyle(fontSize: 13, color: Colors.white),
                              onChanged: (value) => ref.read(bankInputProvider.notifier).setBankMoney(bankMoney: value),
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: IconButton(
                              onPressed: () {
                                switch (bankInputState.selectInOutFlag) {
                                  case 0:
                                    final uploadData = <String, dynamic>{
                                      'date': bankInputState.selectDate,
                                      'bank': bankInputState.selectBank,
                                      'price': bankInputState.bankMoney,
                                    };

                                    _ref.read(bankInputProvider.notifier).updateBankMoney(uploadData: uploadData);

                                    break;
                                  case 1:
                                    final uploadData = <String, dynamic>{
                                      'from_date': bankInputState.outArrowDate,
                                      'from_bank': bankInputState.outArrowBank,
                                      'to_date': bankInputState.inArrowDate,
                                      'to_bank': bankInputState.inArrowBank,
                                      'price': bankInputState.bankMoney,
                                    };

                                    _ref.read(bankInputProvider.notifier).setBankMove(uploadData: uploadData);

                                    break;
                                }

                                _ref.read(bankInputProvider.notifier).onTapSubmit();

                                context.goNamed(RouteNames.home);
                              },
                              icon: const Icon(Icons.input),
                            ),
                          ),
                        ],
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
  Widget getButtonAreaWidget() {
    final bankInputState = _ref.watch(bankInputProvider);

    final bankName = _utility.getBankName();

    return SizedBox(
      width: _context.screenSize.width * 0.40,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: bankName.entries.map(
              (e) {
                final boxColor = (e.key.toString() == bankInputState.selectBank)
                    ? Colors.yellowAccent
                    : Colors.white.withOpacity(0.4);

                final inArrowColor = (e.key.toString() == bankInputState.inArrowBank)
                    ? Colors.greenAccent
                    : Colors.white.withOpacity(0.4);

                final outArrowColor = (e.key.toString() == bankInputState.outArrowBank)
                    ? Colors.lightBlueAccent
                    : Colors.white.withOpacity(0.4);

                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            _ref.read(bankInputProvider.notifier).onTapOutArrowBank(outArrowBank: e.key.toString()),
                        child: Icon(Icons.arrow_back, color: outArrowColor),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () =>
                            _ref.read(bankInputProvider.notifier).onTapSelectBank(selectBank: e.key.toString()),
                        child: Container(
                          width: _context.screenSize.width * 0.2,
                          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
                          decoration: BoxDecoration(border: Border.all(color: boxColor, width: 2)),
                          child: Text(e.value.toString(), style: TextStyle(color: boxColor)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () =>
                            _ref.read(bankInputProvider.notifier).onTapInArrowBank(inArrowBank: e.key.toString()),
                        child: Icon(
                          Icons.arrow_back,
                          color: inArrowColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('OUT'), Text('IN')],
          ),
        ],
      ),
    );
  }

  ///
  Widget getMonthlyBankRecord() {
    final bankInputState = _ref.watch(bankInputProvider);

    final bankCompanyList = _ref.watch(
      bankCompanyListProvider(bankInputState.selectBank).select((value) => value.bankCompanyList),
    );

    final holidayState = _ref.watch(holidayProvider);

    final ym = date.yyyymm;

    return bankCompanyList.when(
      data: (value) {
        final list = <Widget>[];

        for (var i = 0; i < value.length; i++) {
          if (value[i].date.yyyymm == ym) {
            list.add(
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
                  color: _utility.getYoubiColor(
                    date: value[i].date,
                    youbiStr: value[i].date.youbiStr,
                    holiday: holidayState.data,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [Text(value[i].date.yyyy), Text(value[i].date.mmdd)]),
                    Row(
                      children: [
                        Text(value[i].price.toCurrency()),
                        const SizedBox(width: 10),
                        getBankMark(mark: value[i].mark),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }

        return SingleChildScrollView(child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*



    final list = <Widget>[];

    for (var i = 0; i < bankAllState.length; i++) {
      if (bankAllState[i].date.yyyymm == ym) {
        list.add(
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
              color: _utility.getYoubiColor(
                date: bankAllState[i].date,
                youbiStr: bankAllState[i].date.youbiStr,
                holiday: holidayState.data,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [Text(bankAllState[i].date.yyyy), Text(bankAllState[i].date.mmdd)]),
                Row(
                  children: [
                    Text(bankAllState[i].price.toCurrency()),
                    const SizedBox(width: 10),
                    getBankMark(mark: bankAllState[i].mark),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    }

    return SingleChildScrollView(child: Column(children: list));




    */
  }

  ///
  Widget getBankMark({required String mark}) {
    switch (mark) {
      case 'up':
        return const Icon(Icons.arrow_upward, color: Colors.greenAccent);
      case 'down':
        return const Icon(Icons.arrow_downward, color: Colors.redAccent);
      default:
        return const Icon(Icons.crop_square, color: Colors.black);
    }
  }

  ///
  Future<void> showDatepick({required String usage}) async {
    final bankInputState = _ref.watch(bankInputProvider);

    final selectedDate = await showDatePicker(
      context: _context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2016),
      lastDate: DateTime.now().add(const Duration(days: 360)),
    );

    if (selectedDate != null) {
      switch (usage) {
        case 'left':
          switch (bankInputState.selectInOutFlag) {
            case 0:
              await _ref.read(bankInputProvider.notifier).setSelectDate(selectDate: selectedDate.yyyymmdd);
              break;
            case 1:
              await _ref.read(bankInputProvider.notifier).setOutArrowDate(outArrowDate: selectedDate.yyyymmdd);
              break;
          }

          break;
        case 'right':
          await _ref.read(bankInputProvider.notifier).setInArrowDate(inArrowDate: selectedDate.yyyymmdd);
          break;
      }
    }
  }
}
