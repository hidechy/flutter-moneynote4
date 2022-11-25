// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/extensions/extensions.dart';
import 'package:moneynote4/screens/_components/seiyu_alert.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/spend_month_summary.dart';
import '../utility/utility.dart';
import '../viewmodel/spend_notifier.dart';
import '_components/_money_dialog.dart';
import '_components/credit_alert.dart';
import '_components/money_alert.dart';
import '_components/monthly_spend_alert.dart';

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

    final spendMonthSummaryState = ref.watch(
      spendMonthSummaryProvider(focusDayState.toString()),
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
                    Container(),
                    Text(
                      total.toString().toCurrency(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: const TextStyle(fontSize: 12),
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 10),
                      itemBuilder: (context, index) {
                        final spend = spendMonthSummaryState[index];

                        return DefaultTextStyle(
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
                                  child: Table(
                                    children: [
                                      TableRow(children: [
                                        Text(spend.item),
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            spend.sum.toString().toCurrency(),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: Text('${spend.percent} %'),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                getLinkIcon(item: spend.item),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Container(),
                      itemCount: spendMonthSummaryState.length,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
      floatingActionButton: FabCircularMenu(
        fabSize: 40,
        alignment: Alignment.centerLeft,
        ringColor: Colors.indigo.withOpacity(0.8),
        fabOpenColor: Colors.indigo.withOpacity(0.8),
        fabCloseColor: Colors.indigo.withOpacity(0.8),
        ringWidth: 10,
        ringDiameter: 200,
        children: <Widget>[
          IconButton(
            icon: const Icon(FontAwesomeIcons.bullseye),
            onPressed: () {
              MoneyDialog(
                context: context,
                widget: SeiyuAlert(date: focusDayState),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.details),
            onPressed: () {
              MoneyDialog(
                context: context,
                widget: MonthlySpendAlert(date: focusDayState),
              );
            },
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
