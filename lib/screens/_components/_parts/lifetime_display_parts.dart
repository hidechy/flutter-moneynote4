import 'package:flutter/material.dart';

import '../../../extensions/extensions.dart';
import '../../../models/lifetime.dart';
import '../../../models/walk_record.dart';

// ignore: must_be_immutable
class LifetimeDisplayParts extends StatelessWidget {
  LifetimeDisplayParts({super.key, required this.lifetime, this.walkRecord, this.textDisplay});

  final Lifetime lifetime;
  WalkRecord? walkRecord;
  bool? textDisplay;

  List<String> bottomBorderItem = ['05', '11', '17'];

  ///
  @override
  Widget build(BuildContext context) {
    final trainVal = (walkRecord != null && walkRecord!.train != '') ? walkRecord!.train.split('、') : <String>[];

    return SingleChildScrollView(
      child: Column(
        children: [
          _lifetimeDisplayParts(key: '00', value: lifetime.hour00),
          _lifetimeDisplayParts(key: '01', value: lifetime.hour01),
          _lifetimeDisplayParts(key: '02', value: lifetime.hour02),
          _lifetimeDisplayParts(key: '03', value: lifetime.hour03),
          _lifetimeDisplayParts(key: '04', value: lifetime.hour04),
          _lifetimeDisplayParts(key: '05', value: lifetime.hour05),
          _lifetimeDisplayParts(key: '06', value: lifetime.hour06),
          _lifetimeDisplayParts(key: '07', value: lifetime.hour07),
          _lifetimeDisplayParts(key: '08', value: lifetime.hour08),
          _lifetimeDisplayParts(key: '09', value: lifetime.hour09),
          _lifetimeDisplayParts(key: '10', value: lifetime.hour10),
          _lifetimeDisplayParts(key: '11', value: lifetime.hour11),
          _lifetimeDisplayParts(key: '12', value: lifetime.hour12),
          _lifetimeDisplayParts(key: '13', value: lifetime.hour13),
          _lifetimeDisplayParts(key: '14', value: lifetime.hour14),
          _lifetimeDisplayParts(key: '15', value: lifetime.hour15),
          _lifetimeDisplayParts(key: '16', value: lifetime.hour16),
          _lifetimeDisplayParts(key: '17', value: lifetime.hour17),
          _lifetimeDisplayParts(key: '18', value: lifetime.hour18),
          _lifetimeDisplayParts(key: '19', value: lifetime.hour19),
          _lifetimeDisplayParts(key: '20', value: lifetime.hour20),
          _lifetimeDisplayParts(key: '21', value: lifetime.hour21),
          _lifetimeDisplayParts(key: '22', value: lifetime.hour22),
          _lifetimeDisplayParts(key: '23', value: lifetime.hour23),
          if (walkRecord != null) ...[
            const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${walkRecord!.step.toString().toCurrency()} steps.'),
                  Text('${walkRecord!.distance.toString().toCurrency()} m.'),
                  if (walkRecord!.train != '') ...[
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.train, size: 12),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: trainVal.map(Text.new).toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  ///
  Widget _lifetimeDisplayParts({required String key, required String value}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _getLifetimeRowBgColor(value: value),
        border:
            (bottomBorderItem.contains(key)) ? Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))) : null,
      ),
      child: (textDisplay == false)
          ? const Text('*', style: TextStyle(color: Colors.transparent))
          : Row(
              children: [
                Expanded(child: Text(key)),
                Expanded(flex: 3, child: Text(value)),
              ],
            ),
    );
  }

  ///
  Color _getLifetimeRowBgColor({required String value}) {
    final opa = (textDisplay == false) ? 0.4 : 0.2;

    switch (value) {
      case '自宅':
      case '実家':
        return Colors.white.withOpacity(opa);

      case '睡眠':
        return Colors.yellowAccent.withOpacity(opa);

      case '移動':
        return Colors.green.withOpacity(opa);

      case '仕事':
        return Colors.indigo.withOpacity(opa);

      case '外出':
      case '旅行':
      case 'イベント':
        return Colors.pinkAccent.withOpacity(opa);

      case 'ボクシング':
      case '俳句会':
      case '勉強':
        return Colors.purpleAccent.withOpacity(opa);

      case '飲み会':
        return Colors.orangeAccent.withOpacity(opa);

      case '歩き':
        return Colors.lightBlueAccent.withOpacity(opa);

      case '緊急事態':
        return Colors.redAccent.withOpacity(opa);
    }

    return Colors.transparent;
  }
}
