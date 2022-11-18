// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/screens/credit_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utility/utility.dart';
import '../viewmodel/spend_month_summary_viewmodel.dart';

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

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),

          ///////////// calendar
          Column(
            children: [
              const SizedBox(height: 40),
              TableCalendar(
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
              Container(height: size.height * 0.5),
              Divider(
                color: Colors.yellowAccent.withOpacity(0.2),
                thickness: 5,
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

                        return Container(
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
                                          _utility.makeCurrencyDisplay(
                                            spend.sum.toString(),
                                          ),
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
                        );
                      },
                      separatorBuilder: (context, index) => Container(),
                      itemCount: spendMonthSummaryState.length,
                    ),
                  ),
                ),
              ),
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
            Navigator.push(
              _context,
              MaterialPageRoute(
                builder: (context) => CreditScreen(date: focusDayState),
              ),
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
  }

  ///
  void onPageMoved({required DateTime date}) {
    _ref.watch(focusDayProvider.notifier).setDateTime(dateTime: date);
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
