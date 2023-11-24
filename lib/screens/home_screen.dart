// ignore_for_file: must_be_immutable, cascade_invocations, empty_catches, deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../extensions/extensions.dart';
import '../state/device_info/device_info_notifier.dart';
import '../state/device_info/device_info_request_state.dart';
import '../state/home_menu/home_menu_notifier.dart';
import '../state/spend/spend_notifier.dart';
import '../utility/utility.dart';
import '_components/_money_dialog.dart';
import '_components/amazon_alert.dart';
import '_components/balance_sheet_alert.dart';
import '_components/benefit_alert.dart';
import '_components/credit_company_alert.dart';
import '_components/credit_summary_alert.dart';
import '_components/credit_yearly_detail_alert.dart';
import '_components/duty_alert.dart';
import '_components/food_expenses_alert.dart';
import '_components/home_fix_alert.dart';
import '_components/mercari_record_alert.dart';
import '_components/money_alert.dart';
import '_components/money_score_alert.dart';
import '_components/money_total_alert.dart';
import '_components/monthly_spend_alert.dart';
import '_components/monthly_unit_spend_alert.dart';
import '_components/sameday_spend_alert.dart';
import '_components/seiyu_alert.dart';
import '_components/spend_summary_alert.dart';
import '_components/spend_summary_item_alert.dart';
import '_components/spend_yearly_alert.dart';
import '_components/tax_payment_display_alert.dart';
import '_components/train_alert.dart';
import '_components/udemy_alert.dart';
import '_components/wells_reserve_alert.dart';
import '_components/yearly_calendar_alert.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  late BuildContext _context;
  late WidgetRef _ref;

  final Utility _utility = Utility();

  //---------------------------------------------------//

  Future<void> initPlatformState() async {
    try {
      if (Platform.isAndroid) {
        _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {}
  }

  ///
  void _readAndroidBuildData(AndroidDeviceInfo build) {
    final request = DeviceInfoRequestState(name: build.brand, systemName: build.product, model: build.model);

    _ref.read(deviceInfoProvider.notifier).setDeviceInfo(param: request);
  }

  ///
  void _readIosDeviceInfo(IosDeviceInfo data) {
    final request =
        DeviceInfoRequestState(name: data.name ?? '', systemName: data.systemName ?? '', model: data.model ?? '');

    _ref.read(deviceInfoProvider.notifier).setDeviceInfo(param: request);
  }

  //---------------------------------------------------//

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final focusDayState = ref.watch(focusDayProvider);

    final homeMenuState = ref.watch(homeMenuProvider);

    //
    //
    // final spendMonthSummaryState = ref.watch(spendMonthSummaryProvider(focusDayState));
    //
    // final total = makeTotalPrice(data: spendMonthSummaryState);
    //
    //
    //

    final total = makeTotalPrice();

    initPlatformState();

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
                rowHeight: 35,

                ///
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(color: Colors.transparent),
                  selectedDecoration: BoxDecoration(color: Colors.indigo, shape: BoxShape.circle),

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
                    border: Border.fromBorderSide(BorderSide(color: Color(0xFF9FA8DA))),
                  ),
                ),

                ///
                headerStyle: const HeaderStyle(formatButtonVisible: false),
                firstDay: DateTime.utc(2020),
                lastDay: DateTime.utc(2030, 12, 31),

                focusedDay: focusDayState,

                ///
                selectedDayPredicate: (day) => isSameDay(ref.watch(blueBallProvider), day),

                ///
                onDaySelected: (selectedDay, focusedDay) => onDayPressed(date: selectedDay),

                ///
                onPageChanged: (focusedDay) {
                  onPageMoved(date: focusedDay);
                },
              ),
            ],
          ),
          ///////////// calendar

          //

          Column(
            children: [
              Container(
                width: double.infinity,
                height: context.screenSize.height * 0.4,
                padding: const EdgeInsets.only(right: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 60),
                    GestureDetector(
                      onTap: () {
                        ref.read(focusDayProvider.notifier).setDateTime(dateTime: DateTime.now());

                        ref.read(blueBallProvider.notifier).setDateTime(dateTime: DateTime.now());

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      child: const Icon(Icons.refresh, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.indigo.withOpacity(0.8), thickness: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        openAlertWindow(flag: homeMenuState.menuFlag);
                      },
                      style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: Colors.indigo.withOpacity(0.8)),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: context.screenSize.width / 4),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(homeMenuState.menuName, style: const TextStyle(fontSize: 12)),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => MoneyDialog(context: context, widget: YearlyCalendarAlert()),
                          child: const Icon(Icons.calendar_today, size: 18),
                        ),
                        const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () => MoneyDialog(context: context, widget: MoneyTotalAlert(date: focusDayState)),
                          child: const Icon(Icons.all_out, size: 18),
                        ),
                        const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () =>
                              MoneyDialog(context: context, widget: SpendSummaryItemAlert(date: focusDayState)),
                          child: const Icon(FontAwesomeIcons.maximize, size: 18),
                        ),
                        const SizedBox(width: 20),
                        Text(total.toString().toCurrency(), style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: context.screenSize.height * 0.48,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(padding: const EdgeInsets.only(right: 20), child: displayIcons()),
                    Expanded(child: displayMonthSpend()),
                  ],
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
            MoneyDialog(
              context: _context,
              widget: CreditYearlyDetailAlert(date: focusDayState),
            );
          },
          child: const Icon(Icons.credit_card, size: 14),
        );
      default:
        return const Icon(Icons.check_box_outline_blank, color: Colors.transparent, size: 14);
    }
  }

  ///
  void onDayPressed({required DateTime date}) {
    _ref.read(blueBallProvider.notifier).setDateTime(dateTime: date);
    _ref.read(focusDayProvider.notifier).setDateTime(dateTime: date);

    MoneyDialog(context: _context, widget: MoneyAlert(date: date));
  }

  ///
  void onPageMoved({required DateTime date}) => _ref.read(focusDayProvider.notifier).setDateTime(dateTime: date);

  ///
  int makeTotalPrice() {
//    {required List<SpendMonthSummary> data}

    //
    //
    // final spendMonthSummaryState = ref.watch(spendMonthSummaryProvider(focusDayState));
    //
    // final total = makeTotalPrice(data: spendMonthSummaryState);
    //
    //
    //

    final focusDayState = _ref.watch(focusDayProvider);

    var ret = 0;

    final spendMonthSummaryList =
        _ref.watch(spendMonthSummaryProvider(focusDayState).select((value) => value.spendMonthSummaryList));

    spendMonthSummaryList.value?.forEach((element) {
      ret += element.sum.toString().toInt();
    });

    // for (var i = 0; i < data.length; i++) {
    //   ret += data[i].sum.toString().toInt();
    // }
    //
    //

    return ret;
  }

  ///
  Widget displayMonthSpend() {
    final list = <Widget>[];

    final focusDayState = _ref.watch(focusDayProvider);

    /////////////////////////////////////

    final percentageList = <double>[];

    final spendMonthSummaryList =
        _ref.watch(spendMonthSummaryProvider(focusDayState).select((value) => value.spendMonthSummaryList));

    spendMonthSummaryList.value?.forEach((element) {
      percentageList.add(element.percent.toDouble());
    });

    //
    //
    // final spendMonthSummaryState = _ref.watch(spendMonthSummaryProvider(focusDayState));
    //
    // for (var i = 0; i < spendMonthSummaryState.length; i++) {
    //   final spend = spendMonthSummaryState[i];
    //   percentageList.add(spend.percent.toDouble());
    // }
    //
    //
    //

    percentageList.sort((a, b) => -1 * a.compareTo(b));

    var topPercentageList = <double>[];

    if (percentageList.isNotEmpty && percentageList.length > 5) {
      topPercentageList = percentageList.sublist(0, 5);
    }

    /////////////////////////////////////

    return spendMonthSummaryList.when(
      data: (value) {
        for (var i = 0; i < value.length; i++) {
          final spend = value[i];

          var textColor = (spend.sum >= 10000) ? Colors.yellowAccent : Colors.white;

          textColor = getTextColor(item: spend.item);

          list.add(
            DefaultTextStyle(
              style: const TextStyle(fontSize: 12),
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.2)))),
                margin: const EdgeInsets.only(bottom: 3),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(spend.item, style: TextStyle(color: textColor)),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.topRight,
                              child: Text(spend.sum.toString().toCurrency(), style: TextStyle(color: textColor)),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                '${spend.percent} %',
                                style: TextStyle(
                                  color: (topPercentageList.contains(spend.percent.toDouble()))
                                      ? Colors.redAccent
                                      : textColor,
                                ),
                              ),
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

        return SingleChildScrollView(child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*


    for (var i = 0; i < spendMonthSummaryState.length; i++) {
      final spend = spendMonthSummaryState[i];

      var textColor = (spend.sum >= 10000) ? Colors.yellowAccent : Colors.white;

      textColor = getTextColor(item: spend.item);

      list.add(
        DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.2)))),
            margin: const EdgeInsets.only(bottom: 3),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(spend.item, style: TextStyle(color: textColor)),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Text(spend.sum.toString().toCurrency(), style: TextStyle(color: textColor)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            '${spend.percent} %',
                            style: TextStyle(
                              color:
                                  (topPercentageList.contains(spend.percent.toDouble())) ? Colors.redAccent : textColor,
                            ),
                          ),
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

    return SingleChildScrollView(child: Column(children: list));



    */
  }

  ///
  Color getTextColor({required String item}) {
    final fixPaymentValue = _utility.getFixPaymentValue();

    switch (fixPaymentValue[item]) {
      case 1:
        return Colors.orangeAccent;
      case 2:
        return Colors.greenAccent;
      case 3:
        return Colors.lightBlueAccent;
    }

    return Colors.white;
  }

  ///
  Widget displayIcons() {
    final homeMenuState = _ref.watch(homeMenuProvider);

    final list = <Widget>[];

    list.add(
      IconButton(
        onPressed: () =>
            _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'monthly_spend', menuName: '月間消費金額履歴'),
        icon: Icon(
          Icons.details,
          color: (homeMenuState.menuFlag == 'monthly_spend') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () =>
            _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'sameday_spend', menuName: '同日消費金額履歴'),
        icon: Icon(
          Icons.account_tree,
          color: (homeMenuState.menuFlag == 'sameday_spend') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () =>
            _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'monthly_unit_spend', menuName: '月別消費金額履歴'),
        icon: Icon(
          Icons.bar_chart_sharp,
          color: (homeMenuState.menuFlag == 'monthly_unit_spend') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () =>
            _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'yearly_spend', menuName: '年間消費金額履歴'),
        icon: Icon(
          FontAwesomeIcons.calculator,
          color: (homeMenuState.menuFlag == 'yearly_spend') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () =>
            _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'spend_summary', menuName: '消費金額ブロック比較'),
        icon: Icon(
          Icons.select_all,
          color: (homeMenuState.menuFlag == 'spend_summary') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () =>
            _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'credit_company', menuName: 'クレジット会社比較'),
        icon: Icon(
          Icons.calendar_view_month_rounded,
          color: (homeMenuState.menuFlag == 'credit_company') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () => _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'tax_payment', menuName: '確定申告資料'),
        icon: Icon(
          Icons.publish,
          color: (homeMenuState.menuFlag == 'tax_payment') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () => _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'money_score', menuName: 'マネースコア'),
        icon: Icon(
          Icons.trending_up,
          color: (homeMenuState.menuFlag == 'money_score') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () => _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'benefit', menuName: '収入獲得履歴'),
        icon: Icon(
          Icons.monetization_on,
          color: (homeMenuState.menuFlag == 'benefit') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () => _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'duty_paid', menuName: '支払い義務金額履歴'),
        icon: Icon(
          FontAwesomeIcons.biohazard,
          color: (homeMenuState.menuFlag == 'duty_paid') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () => _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'home_fix', menuName: '家計固定費履歴'),
        icon: Icon(
          FontAwesomeIcons.house,
          color: (homeMenuState.menuFlag == 'home_fix') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () => _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'food_expenses', menuName: '食費'),
        icon: Icon(
          Icons.fastfood,
          color: (homeMenuState.menuFlag == 'food_expenses') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () =>
            _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'seiyuu_purchase', menuName: '西友購入履歴'),
        icon: Icon(
          FontAwesomeIcons.bullseye,
          color: (homeMenuState.menuFlag == 'seiyuu_purchase') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () =>
            _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'amazon_purchase', menuName: 'Amazon購入履歴'),
        icon: Icon(
          FontAwesomeIcons.amazon,
          color: (homeMenuState.menuFlag == 'amazon_purchase') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () => _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'train', menuName: '電車乗車履歴'),
        icon: Icon(
          Icons.train,
          color: (homeMenuState.menuFlag == 'train') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () => _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'mercari', menuName: 'メルカリ'),
        icon: Icon(
          FontAwesomeIcons.handshake,
          color: (homeMenuState.menuFlag == 'mercari') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () => _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'udemy', menuName: 'UDEMY'),
        icon: Icon(
          FontAwesomeIcons.u,
          color: (homeMenuState.menuFlag == 'udemy') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () =>
            _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'balanceSheet', menuName: 'balanceSheet'),
        icon: Icon(
          FontAwesomeIcons.balanceScale,
          color: (homeMenuState.menuFlag == 'balanceSheet') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    list.add(
      IconButton(
        onPressed: () =>
            _ref.read(homeMenuProvider.notifier).setHomeMenu(menuFlag: 'wells_reserve', menuName: '積立年金記録'),
        icon: Icon(
          FontAwesomeIcons.pagelines,
          color: (homeMenuState.menuFlag == 'wells_reserve') ? Colors.lightBlueAccent : Colors.white,
          size: 14,
        ),
      ),
    );

    return SingleChildScrollView(child: Column(children: list));
  }

  ///
  void openAlertWindow({required String flag}) {
    final focusDayState = _ref.watch(focusDayProvider);

    switch (flag) {
      case 'monthly_spend':
        final selectedMonth = focusDayState.month;
        final todayMonth = DateTime.now().month;

        MoneyDialog(
          context: _context,
          widget: MonthlySpendAlert(date: focusDayState, index: todayMonth - selectedMonth),
        );
        break;

      case 'sameday_spend':
        MoneyDialog(context: _context, widget: SamedaySpendAlert(date: focusDayState));
        break;

      case 'monthly_unit_spend':
        MoneyDialog(context: _context, widget: MonthlyUnitSpendAlert(date: focusDayState));
        break;

      case 'yearly_spend':
        MoneyDialog(context: _context, widget: SpendYearlyAlert(date: focusDayState));
        break;

      case 'tax_payment':
        MoneyDialog(context: _context, widget: TaxPaymentDisplayAlert(date: focusDayState));
        break;

      case 'money_score':
        MoneyDialog(context: _context, widget: MoneyScoreAlert(date: focusDayState));
        break;

      case 'benefit':
        MoneyDialog(context: _context, widget: BenefitAlert(date: focusDayState));
        break;

      case 'spend_summary':
        MoneyDialog(context: _context, widget: SpendSummaryAlert(date: focusDayState));
        break;

      case 'credit_summary':
        MoneyDialog(context: _context, widget: CreditSummaryAlert(date: focusDayState));
        break;

      case 'credit_company':
        MoneyDialog(context: _context, widget: CreditCompanyAlert(date: focusDayState));
        break;

      case 'duty_paid':
        MoneyDialog(context: _context, widget: DutyAlert(date: focusDayState));
        break;

      case 'home_fix':
        MoneyDialog(context: _context, widget: HomeFixAlert(date: focusDayState));
        break;

      case 'food_expenses':
        MoneyDialog(context: _context, widget: FoodExpensesAlert(date: focusDayState));

        break;

      case 'seiyuu_purchase':
        MoneyDialog(context: _context, widget: SeiyuAlert(date: focusDayState));
        break;

      case 'amazon_purchase':
        MoneyDialog(context: _context, widget: AmazonAlert(date: focusDayState));
        break;

      case 'train':
        MoneyDialog(context: _context, widget: TrainAlert(date: focusDayState));
        break;

      case 'mercari':
        MoneyDialog(context: _context, widget: MercariRecordAlert(date: focusDayState));
        break;

      case 'udemy':
        MoneyDialog(context: _context, widget: UdemyAlert(date: focusDayState));
        break;

      case 'balanceSheet':
        MoneyDialog(context: _context, widget: BalanceSheetAlert(date: focusDayState));
        break;

      case 'wells_reserve':
        MoneyDialog(context: _context, widget: WellsReserveAlert(date: focusDayState));
        break;
    }
  }
}

////////////////////////////////////////////////////////////
final focusDayProvider = StateNotifierProvider.autoDispose<FocusDayStateNotifier, DateTime>((ref) {
  return FocusDayStateNotifier();
});

class FocusDayStateNotifier extends StateNotifier<DateTime> {
  FocusDayStateNotifier() : super(DateTime.now());

  ///
  Future<void> setDateTime({required DateTime dateTime}) async => state = dateTime;
}

////////////////////////////////////////////////////////////
final blueBallProvider = StateNotifierProvider.autoDispose<BlueBallStateNotifier, DateTime>((ref) {
  return BlueBallStateNotifier();
});

class BlueBallStateNotifier extends StateNotifier<DateTime> {
  BlueBallStateNotifier() : super(DateTime.now());

  ///
  Future<void> setDateTime({required DateTime dateTime}) async => state = dateTime;
}
