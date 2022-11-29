// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/screens/_components/spend_summary_alert.dart';
import 'package:table_calendar/table_calendar.dart';

import '../extensions/extensions.dart';
import '../models/spend_month_summary.dart';
import '../utility/utility.dart';
import '../viewmodel/home_menu_notifier.dart';
import '../viewmodel/spend_notifier.dart';
import '_components/_money_dialog.dart';
import '_components/amazon_alert.dart';
import '_components/credit_alert.dart';
import '_components/credit_summary_alert.dart';
import '_components/duty_alert.dart';
import '_components/home_fix_alert.dart';
import '_components/money_alert.dart';
import '_components/monthly_spend_alert.dart';
import '_components/seiyu_alert.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  late BuildContext _context;
  late WidgetRef _ref;

  final Utility _utility = Utility();

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final focusDayState = ref.watch(focusDayProvider);

    final homeMenuState = ref.watch(homeMenuProvider);

    final spendMonthSummaryState = ref.watch(
      spendMonthSummaryProvider(focusDayState),
    );

    final total = makeTotalPrice(data: spendMonthSummaryState);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),

          ///////////// calendar
          Column(
            children: [
              const SizedBox(height: 20),
              TableCalendar(
                rowHeight: 35,

                ///
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(color: Colors.transparent),
                  selectedDecoration: BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.circle,
                  ),

                  ///
                  todayTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                  selectedTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                  rangeStartTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                  rangeEndTextStyle: TextStyle(color: Color(0xFFFAFAFA)),
                  disabledTextStyle: TextStyle(color: Colors.grey),
                  weekendTextStyle: TextStyle(color: Colors.white),

                  ///
                  markerDecoration: BoxDecoration(color: Colors.white),
                  rangeStartDecoration: BoxDecoration(color: Color(0xFF6699FF)),
                  rangeEndDecoration: BoxDecoration(color: Color(0xFF6699FF)),
                  holidayDecoration: BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Color(0xFF9FA8DA),
                      ),
                    ),
                  ),
                ),

                ///
                headerStyle: const HeaderStyle(formatButtonVisible: false),
                firstDay: DateTime.utc(2020),
                lastDay: DateTime.utc(2030, 12, 31),

                focusedDay: focusDayState,

                ///
                selectedDayPredicate: (day) {
                  return isSameDay(ref.watch(blueBallProvider), day);
                },

                ///
                onDaySelected: (selectedDay, focusedDay) {
                  onDayPressed(date: selectedDay);
                },

                ///
                onPageChanged: (focusedDay) {
                  onPageMoved(date: focusedDay);
                },
              ),
            ],
          ),
          ///////////// calendar
          Column(
            children: [
              Container(
                width: double.infinity,
                height: context.screenSize.height * 0.45,
                padding: const EdgeInsets.only(right: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        ref
                            .watch(focusDayProvider.notifier)
                            .setDateTime(dateTime: DateTime.now());

                        ref
                            .watch(blueBallProvider.notifier)
                            .setDateTime(dateTime: DateTime.now());

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.indigo.withOpacity(0.8),
                thickness: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        openAlertWindow(flag: homeMenuState.menuFlag);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.indigo.withOpacity(0.8),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: context.screenSize.width / 4,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            homeMenuState.menuName,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      total.toString().toCurrency(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Container(
                height: context.screenSize.height * 0.40,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: displayIcons(),
                    ),
                    Expanded(
                      child: displayMonthSpend(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  ///
  Widget getLinkIcon({required String item}) {
    final focusDayState = _ref.watch(focusDayProvider);

    switch (item) {
      case 'credit':
        return GestureDetector(
          onTap: () {
            MoneyDialog(
              context: _context,
              widget: CreditAlert(date: focusDayState),
            );
          },
          child: const Icon(Icons.credit_card),
        );
      default:
        return Icon(
          Icons.check_box_outline_blank,
          color: Colors.black.withOpacity(0.1),
        );
    }
  }

  ///
  void onDayPressed({required DateTime date}) {
    _ref.watch(blueBallProvider.notifier).setDateTime(dateTime: date);
    _ref.watch(focusDayProvider.notifier).setDateTime(dateTime: date);

    MoneyDialog(
      context: _context,
      widget: MoneyAlert(date: date),
    );
  }

  ///
  void onPageMoved({required DateTime date}) {
    _ref.watch(focusDayProvider.notifier).setDateTime(dateTime: date);
  }

  ///
  int makeTotalPrice({required List<SpendMonthSummary> data}) {
    var ret = 0;

    for (var i = 0; i < data.length; i++) {
      ret += int.parse(data[i].sum.toString());
    }

    return ret;
  }

  ///
  Widget displayMonthSpend() {
    final list = <Widget>[];

    final focusDayState = _ref.watch(focusDayProvider);

    final spendMonthSummaryState = _ref.watch(
      spendMonthSummaryProvider(focusDayState),
    );

    for (var i = 0; i < spendMonthSummaryState.length; i++) {
      final spend = spendMonthSummaryState[i];

      list.add(
        DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
            margin: const EdgeInsets.only(bottom: 3),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(spend.item),
                        flex: 2,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            spend.sum.toString().toCurrency(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Text('${spend.percent} %'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                getLinkIcon(item: spend.item),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }

  ///
  Widget displayIcons() {
    final homeMenuState = _ref.watch(homeMenuProvider);

    final list = <Widget>[];

    list.add(
      IconButton(
        onPressed: () {
          _ref.watch(homeMenuProvider.notifier).setHomeMenu(
                menuFlag: 'monthly_spend',
                menuName: '月間使用金額履歴',
              );
        },
        icon: Icon(
          Icons.details,
          color: (homeMenuState.menuFlag == 'monthly_spend')
              ? Colors.lightBlueAccent
              : Colors.white,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () {
          _ref.watch(homeMenuProvider.notifier).setHomeMenu(
                menuFlag: 'spend_summary',
                menuName: '使用金額比較',
              );
        },
        icon: Icon(
          Icons.select_all,
          color: (homeMenuState.menuFlag == 'spend_summary')
              ? Colors.lightBlueAccent
              : Colors.white,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () {
          _ref.watch(homeMenuProvider.notifier).setHomeMenu(
                menuFlag: 'credit_summary',
                menuName: 'クレジット使用比較',
              );
        },
        icon: Icon(
          Icons.list,
          color: (homeMenuState.menuFlag == 'credit_summary')
              ? Colors.lightBlueAccent
              : Colors.white,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () {
          _ref.watch(homeMenuProvider.notifier).setHomeMenu(
                menuFlag: 'duty_paid',
                menuName: '支払い義務金額履歴',
              );
        },
        icon: Icon(
          FontAwesomeIcons.biohazard,
          color: (homeMenuState.menuFlag == 'duty_paid')
              ? Colors.lightBlueAccent
              : Colors.white,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () {
          _ref.watch(homeMenuProvider.notifier).setHomeMenu(
                menuFlag: 'home_fix',
                menuName: '家計固定費履歴',
              );
        },
        icon: Icon(
          FontAwesomeIcons.house,
          color: (homeMenuState.menuFlag == 'home_fix')
              ? Colors.lightBlueAccent
              : Colors.white,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () {
          _ref.watch(homeMenuProvider.notifier).setHomeMenu(
                menuFlag: 'seiyuu_purchase',
                menuName: '西友購入履歴',
              );
        },
        icon: Icon(
          FontAwesomeIcons.bullseye,
          color: (homeMenuState.menuFlag == 'seiyuu_purchase')
              ? Colors.lightBlueAccent
              : Colors.white,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () {
          _ref.watch(homeMenuProvider.notifier).setHomeMenu(
                menuFlag: 'amazon_purchase',
                menuName: 'Amazon購入履歴',
              );
        },
        icon: Icon(
          FontAwesomeIcons.amazon,
          color: (homeMenuState.menuFlag == 'amazon_purchase')
              ? Colors.lightBlueAccent
              : Colors.white,
        ),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }

  ///
  void openAlertWindow({required String flag}) {
    final focusDayState = _ref.watch(focusDayProvider);

    switch (flag) {
      case 'monthly_spend':
        MoneyDialog(
          context: _context,
          widget: MonthlySpendAlert(date: focusDayState),
        );
        break;

      case 'spend_summary':
        MoneyDialog(
          context: _context,
          widget: SpendSummaryAlert(date: focusDayState),
        );
        break;

      case 'credit_summary':
        MoneyDialog(
          context: _context,
          widget: CreditSummaryAlert(date: focusDayState),
        );
        break;

      case 'duty_paid':
        MoneyDialog(
          context: _context,
          widget: DutyAlert(date: focusDayState),
        );
        break;

      case 'home_fix':
        MoneyDialog(
          context: _context,
          widget: HomeFixAlert(date: focusDayState),
        );
        break;

      case 'seiyuu_purchase':
        MoneyDialog(
          context: _context,
          widget: SeiyuAlert(date: focusDayState),
        );
        break;

      case 'amazon_purchase':
        MoneyDialog(
          context: _context,
          widget: AmazonAlert(date: focusDayState),
        );
        break;
    }
  }
}

////////////////////////////////////////////////////////////
final focusDayProvider =
    StateNotifierProvider.autoDispose<FocusDayStateNotifier, DateTime>((ref) {
  return FocusDayStateNotifier();
});

class FocusDayStateNotifier extends StateNotifier<DateTime> {
  FocusDayStateNotifier() : super(DateTime.now());

  ///
  Future<void> setDateTime({required DateTime dateTime}) async {
    state = dateTime;
  }
}

////////////////////////////////////////////////////////////
final blueBallProvider =
    StateNotifierProvider.autoDispose<BlueBallStateNotifier, DateTime>((ref) {
  return BlueBallStateNotifier();
});

class BlueBallStateNotifier extends StateNotifier<DateTime> {
  BlueBallStateNotifier() : super(DateTime.now());

  ///
  Future<void> setDateTime({required DateTime dateTime}) async {
    state = dateTime;
  }
}
