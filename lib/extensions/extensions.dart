import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
extension ContextEx on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorTheme => Theme.of(this).colorScheme;

  Size get screenSize => MediaQuery.of(this).size;
}

///
extension DateTimeEx on DateTime {
  String get yyyymmdd {
    final outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(this);
  }

  String get yyyymm {
    final outputFormat = DateFormat('yyyy-MM');
    return outputFormat.format(this);
  }

  String get mmdd {
    final outputFormat = DateFormat('MM-dd');
    return outputFormat.format(this);
  }

  String get yyyy {
    final outputFormat = DateFormat('yyyy');
    return outputFormat.format(this);
  }

  String get mm {
    final outputFormat = DateFormat('MM');
    return outputFormat.format(this);
  }

  String get dd {
    final outputFormat = DateFormat('dd');
    return outputFormat.format(this);
  }

  String get youbiStr {
    final outputFormat = DateFormat('EEEE');
    return outputFormat.format(this);
  }
}

///
extension StringEx on String {
  DateTime toDateTime() {
    final dateFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return dateFormatter.parseStrict(this);
  }

  int toInt() {
    return int.parse(this);
  }

  String toCurrency() {
    final formatter = NumberFormat('#,###');
    return formatter.format(int.parse(this));
  }

  double toDouble() {
    return double.parse(this);
  }
}
