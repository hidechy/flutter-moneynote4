import 'package:go_router/go_router.dart';

import '../models/time_location.dart';
import '../screens/bank_input_screen.dart';
import '../screens/home_screen.dart';
import '../screens/money_input_screen.dart';
import '../screens/monthly_spend_check_screen.dart';
import '../screens/spend_item_input_screen.dart';
import '../screens/time_location_map_screen.dart';
import '../screens/timeplace_input_screen.dart';

// ignore: avoid_classes_with_only_static_members
class RouteNames {
  static String home = 'home';

  //================================================= money_page.dart
  static String moneyInput = 'moneyInput';
  static String spendItemInput = 'spendItemInput';
  static String timePlaceInput = 'timePlaceInput';
  static String bankInput = 'bankInput';

  //================================================= money_spend_page.dart
  static String monthlySpendCheck = 'monthlySpendCheck';

  //================================================= time_location_alert.dart
  static String timeLocationMap = 'timeLocationMap';
}

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.home,
      builder: (context, state) {
        return HomeScreen();
      },
      routes: [
        //================================================= money_page.dart
        GoRoute(
          path: 'moneyInput',
          name: RouteNames.moneyInput,
          builder: (context, state) {
            final extra = state.extra;
            final date = (extra != null) ? (extra as Map<String, dynamic>)['date']! : DateTime.now();
            return MoneyInputScreen(date: date);
          },
        ),
        GoRoute(
          path: 'spendItemInput',
          name: RouteNames.spendItemInput,
          builder: (context, state) {
            final extra = state.extra;
            final date = (extra != null) ? (extra as Map<String, dynamic>)['date']! : DateTime.now();
            final diff = (extra != null) ? (extra as Map<String, dynamic>)['diff'] : 0;
            return SpendItemInputScreen(date: date, diff: diff);
          },
        ),
        GoRoute(
          path: 'timePlaceInput',
          name: RouteNames.timePlaceInput,
          builder: (context, state) {
            final extra = state.extra;
            final date = (extra != null) ? (extra as Map<String, dynamic>)['date']! : DateTime.now();
            final diff = (extra != null) ? (extra as Map<String, dynamic>)['diff'] : 0;
            return TimeplaceInputScreen(date: date, diff: diff);
          },
        ),
        GoRoute(
          path: 'bankInput',
          name: RouteNames.bankInput,
          builder: (context, state) {
            final extra = state.extra;
            final date = (extra != null) ? (extra as Map<String, dynamic>)['date']! : DateTime.now();
            return BankInputScreen(date: date);
          },
        ),

        //================================================= money_spend_page.dart
        GoRoute(
          path: 'monthlySpendCheck',
          name: RouteNames.monthlySpendCheck,
          builder: (context, state) {
            final extra = state.extra;
            final date = (extra != null) ? (extra as Map<String, dynamic>)['date']! : DateTime.now();
            return MonthlySpendCheckScreen(date: date);
          },
        ),

        //================================================= time_location_alert.dart
        GoRoute(
          path: 'timeLocationMap',
          name: RouteNames.timeLocationMap,
          builder: (context, state) {
            final extra = state.extra;
            final date = (extra != null) ? (extra as Map<String, dynamic>)['date']! : DateTime.now();
            final list = (extra != null) ? (extra as Map<String, dynamic>)['list']! : <TimeLocation>[];
            return TimeLocationMapScreen(date: date, list: list);
          },
        ),
      ],
    ),
  ],
);
