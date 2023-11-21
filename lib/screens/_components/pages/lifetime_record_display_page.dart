import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/state/app_param/app_param_notifier.dart';

import '../../../extensions/extensions.dart';
import '../../../state/lifetime/lifetime_notifier.dart';
import '../_money_dialog.dart';
import '../lifetime_record_input_alert.dart';

// ignore: must_be_immutable
class LifetimeRecordDisplayPage extends ConsumerWidget {
  LifetimeRecordDisplayPage({super.key, required this.date});

  final DateTime date;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(width: context.screenSize.width),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${date.yyyymmdd}（${date.youbiStr.substring(0, 3)}）'),
                      GestureDetector(
                        onTap: () => MoneyDialog(context: context, widget: LifetimeRecordInputAlert(date: date)),
                        child: Icon(Icons.input, color: Colors.white.withOpacity(0.6)),
                      ),
                    ],
                  ),
                  Expanded(child: _displayLifetime()),
                ],
              ),
              Column(
                children: [
                  Expanded(child: Container()),
                  _displayNextButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayLifetime() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _displayLifetimeRecord()),
        Expanded(flex: 2, child: Container()),
      ],
    );
  }

  ///
  Widget _displayLifetimeRecord() {
    final lifetimeState = _ref.watch(lifetimeProvider(date));

    return (lifetimeState.lifetime == null)
        ? Container()
        : SingleChildScrollView(
            child: Column(
              children: [
                _lifetimeDisplayParts(key: '00', value: lifetimeState.lifetime!.hour00),
                _lifetimeDisplayParts(key: '01', value: lifetimeState.lifetime!.hour01),
                _lifetimeDisplayParts(key: '02', value: lifetimeState.lifetime!.hour02),
                _lifetimeDisplayParts(key: '03', value: lifetimeState.lifetime!.hour03),
                _lifetimeDisplayParts(key: '04', value: lifetimeState.lifetime!.hour04),
                _lifetimeDisplayParts(key: '05', value: lifetimeState.lifetime!.hour05),
                _lifetimeDisplayParts(key: '06', value: lifetimeState.lifetime!.hour06),
                _lifetimeDisplayParts(key: '07', value: lifetimeState.lifetime!.hour07),
                _lifetimeDisplayParts(key: '08', value: lifetimeState.lifetime!.hour08),
                _lifetimeDisplayParts(key: '09', value: lifetimeState.lifetime!.hour09),
                _lifetimeDisplayParts(key: '10', value: lifetimeState.lifetime!.hour10),
                _lifetimeDisplayParts(key: '11', value: lifetimeState.lifetime!.hour11),
                _lifetimeDisplayParts(key: '12', value: lifetimeState.lifetime!.hour12),
                _lifetimeDisplayParts(key: '13', value: lifetimeState.lifetime!.hour13),
                _lifetimeDisplayParts(key: '14', value: lifetimeState.lifetime!.hour14),
                _lifetimeDisplayParts(key: '15', value: lifetimeState.lifetime!.hour15),
                _lifetimeDisplayParts(key: '16', value: lifetimeState.lifetime!.hour16),
                _lifetimeDisplayParts(key: '17', value: lifetimeState.lifetime!.hour17),
                _lifetimeDisplayParts(key: '18', value: lifetimeState.lifetime!.hour18),
                _lifetimeDisplayParts(key: '19', value: lifetimeState.lifetime!.hour19),
                _lifetimeDisplayParts(key: '20', value: lifetimeState.lifetime!.hour20),
                _lifetimeDisplayParts(key: '21', value: lifetimeState.lifetime!.hour21),
                _lifetimeDisplayParts(key: '22', value: lifetimeState.lifetime!.hour22),
                _lifetimeDisplayParts(key: '23', value: lifetimeState.lifetime!.hour23),
              ],
            ),
          );
  }

  ///
  Widget _lifetimeDisplayParts({required String key, required String value}) {
    return DecoratedBox(
      decoration: BoxDecoration(color: _getLifetimeRowBgColor(value: value)),
      child: Row(
        children: [
          Expanded(child: Text(key)),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }

  ///
  Color _getLifetimeRowBgColor({required String value}) {
    switch (value) {
      case '自宅':
      case '実家':
        return Colors.white.withOpacity(0.2);

      case '睡眠':
        return Colors.yellowAccent.withOpacity(0.2);

      case '移動':
        return Colors.green.withOpacity(0.2);

      case '仕事':
        return Colors.indigo.withOpacity(0.2);

      case '外出':
      case '旅行':
      case 'イベント':
        return Colors.pinkAccent.withOpacity(0.2);

      case 'ボクシング':
      case '俳句会':
      case '勉強':
        return Colors.purpleAccent.withOpacity(0.2);

      case '飲み会':
        return Colors.orangeAccent.withOpacity(0.2);

      case '歩き':
        return Colors.lightBlueAccent.withOpacity(0.2);

      case '緊急事態':
        return Colors.redAccent.withOpacity(0.2);
    }

    return Colors.transparent;
  }

  ///
  Widget _displayNextButton() {
    final selectedYearlyCalendarDate = _ref.watch(appParamProvider.select((value) => value.selectedYearlyCalendarDate));

    var dayDiff = 0;

    if (selectedYearlyCalendarDate != null) {
      dayDiff = date.difference(selectedYearlyCalendarDate).inDays;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        (selectedYearlyCalendarDate != null && dayDiff == 3)
            ? Column(
                children: [
                  Text(selectedYearlyCalendarDate.yyyymmdd),
                  Text(date.yyyymmdd),
                  Text(dayDiff.toString()),
                ],
              )
            : Container(),
      ],
    );
  }
}
