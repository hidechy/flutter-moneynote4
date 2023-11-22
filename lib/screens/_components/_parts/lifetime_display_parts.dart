import 'package:flutter/material.dart';

import '../../../models/lifetime.dart';

class LifetimeDisplayParts extends StatelessWidget {
  const LifetimeDisplayParts({super.key, required this.data});

  final Lifetime data;

  ///
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _lifetimeDisplayParts(key: '00', value: data.hour00),
          _lifetimeDisplayParts(key: '01', value: data.hour01),
          _lifetimeDisplayParts(key: '02', value: data.hour02),
          _lifetimeDisplayParts(key: '03', value: data.hour03),
          _lifetimeDisplayParts(key: '04', value: data.hour04),
          _lifetimeDisplayParts(key: '05', value: data.hour05),
          _lifetimeDisplayParts(key: '06', value: data.hour06),
          _lifetimeDisplayParts(key: '07', value: data.hour07),
          _lifetimeDisplayParts(key: '08', value: data.hour08),
          _lifetimeDisplayParts(key: '09', value: data.hour09),
          _lifetimeDisplayParts(key: '10', value: data.hour10),
          _lifetimeDisplayParts(key: '11', value: data.hour11),
          _lifetimeDisplayParts(key: '12', value: data.hour12),
          _lifetimeDisplayParts(key: '13', value: data.hour13),
          _lifetimeDisplayParts(key: '14', value: data.hour14),
          _lifetimeDisplayParts(key: '15', value: data.hour15),
          _lifetimeDisplayParts(key: '16', value: data.hour16),
          _lifetimeDisplayParts(key: '17', value: data.hour17),
          _lifetimeDisplayParts(key: '18', value: data.hour18),
          _lifetimeDisplayParts(key: '19', value: data.hour19),
          _lifetimeDisplayParts(key: '20', value: data.hour20),
          _lifetimeDisplayParts(key: '21', value: data.hour21),
          _lifetimeDisplayParts(key: '22', value: data.hour22),
          _lifetimeDisplayParts(key: '23', value: data.hour23),
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
}
