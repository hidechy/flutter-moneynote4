// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final focusDayState = ref.watch(focusDayProvider);

    debugPrint(focusDayState.toString());

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 70),
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
              return isSameDay(ref.watch(selectedDayProvider), day);
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
    );
  }

  ///
  void onDayPressed({required DateTime date}) {
    _ref.watch(selectedDayProvider.notifier).setDateTime(dateTime: date);
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
final selectedDayProvider =
    StateNotifierProvider.autoDispose<SelectedDayStateNotifier, DateTime>(
        (ref) {
  return SelectedDayStateNotifier();
});

class SelectedDayStateNotifier extends StateNotifier<DateTime> {
  SelectedDayStateNotifier() : super(DateTime.now());

  ///
  Future<void> setDateTime({required DateTime dateTime}) async {
    state = dateTime;
  }
}
