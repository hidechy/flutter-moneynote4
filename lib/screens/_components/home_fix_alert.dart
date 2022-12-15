// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/home_fix_notifier.dart';

class HomeFixAlert extends ConsumerWidget {
  HomeFixAlert({super.key, required this.date});

  final DateTime date;

  Uuid uuid = const Uuid();

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final yearWidgetList = makeYearWidgetList();

    final deviceInfoState = ref.read(deviceInfoProvider);

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(width: context.screenSize.width),

                //----------//
                if (deviceInfoState.model == 'iPhone')
                  _utility.getFileNameDebug(name: runtimeType.toString()),
                //----------//

                Row(children: yearWidgetList),
                const SizedBox(height: 20),
                displayHomeFix(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  List<Widget> makeYearWidgetList() {
    final exYmd = date.yyyymmdd.split('-');

    final selectYearState = _ref.watch(selectYearProvider);

    final yearList = <Widget>[];
    for (var i = exYmd[0].toInt(); i >= 2020; i--) {
      yearList.add(
        GestureDetector(
          onTap: () {
            _ref
                .watch(selectYearProvider.notifier)
                .setSelectYear(selectYear: i.toString());
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: (i.toString() == selectYearState)
                  ? Colors.yellowAccent.withOpacity(0.2)
                  : null,
            ),
            child: Text(i.toString()),
          ),
        ),
      );
    }

    return yearList;
  }

  ///
  Widget displayHomeFix() {
    final list = <Widget>[];

    final selectYearState = _ref.watch(selectYearProvider);

    final homeFixState = _ref.watch(
      homeFixProvider(
        '$selectYearState-01-01 00:00:00'.toDateTime(),
      ),
    );

    for (var i = 0; i < homeFixState.length; i++) {
      list.add(
        Container(
          width: _context.screenSize.width,
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: _context.screenSize.width,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigo.withOpacity(0.8),
                      Colors.transparent
                    ],
                  ),
                ),
                child: Text(homeFixState[i].ym),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(FontAwesomeIcons.house),
                  SizedBox(width: 20),
                  Expanded(child: Text('yachin')),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(homeFixState[i].yachin),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(FontAwesomeIcons.wifi),
                  SizedBox(width: 20),
                  Expanded(child: Text('wifi')),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(homeFixState[i].wifi),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(FontAwesomeIcons.mobileScreenButton),
                  SizedBox(width: 20),
                  Expanded(child: Text('mobile')),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(homeFixState[i].mobile),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(FontAwesomeIcons.fireFlameSimple),
                  SizedBox(width: 20),
                  Expanded(child: Text('gas')),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(homeFixState[i].gas),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(FontAwesomeIcons.bolt),
                  SizedBox(width: 20),
                  Expanded(child: Text('denki')),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(homeFixState[i].denki),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(FontAwesomeIcons.droplet),
                  SizedBox(width: 20),
                  Expanded(child: Text('suidou')),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(homeFixState[i].suidou),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      key: PageStorageKey(uuid.v1()),
      child: Column(
        children: list,
      ),
    );
  }
}

////////////////////////////////////////////////

final selectYearProvider =
    StateNotifierProvider.autoDispose<SelectYearStateNotifier, String>((ref) {
  return SelectYearStateNotifier();
});

class SelectYearStateNotifier extends StateNotifier<String> {
  SelectYearStateNotifier() : super(DateTime.now().toString().split('-')[0]);

  ///
  Future<void> setSelectYear({required String selectYear}) async {
    state = selectYear;
  }
}
