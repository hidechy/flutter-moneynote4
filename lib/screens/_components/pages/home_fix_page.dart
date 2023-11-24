// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/home_fix/home_fix_notifier.dart';
import '../../../utility/utility.dart';

class HomeFixPage extends ConsumerWidget {
  HomeFixPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

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
                if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
                //----------//

                displayHomeFix(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayHomeFix() {
    final homeFixList = _ref.watch(homeFixProvider(date).select((value) => value.homeFixList));

    return homeFixList.when(
      data: (value) {
        final list = <Widget>[];

        value.forEach((element) {
          //--------------------------------
          final datas = [
            {'icon': FontAwesomeIcons.house, 'title': 'yachin', 'data': element.yachin},
            {'icon': FontAwesomeIcons.wifi, 'title': 'wifi', 'data': element.wifi},
            {'icon': FontAwesomeIcons.mobileScreenButton, 'title': 'mobile', 'data': element.mobile},
            {'icon': FontAwesomeIcons.fireFlameSimple, 'title': 'gas', 'data': element.gas},
            {'icon': FontAwesomeIcons.bolt, 'title': 'denki', 'data': element.denki},
            {'icon': FontAwesomeIcons.droplet, 'title': 'suidou', 'data': element.suidou},
          ];
          //--------------------------------

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
                        colors: [Colors.indigo.withOpacity(0.8), Colors.transparent],
                        stops: const [0.7, 1],
                      ),
                    ),
                    child: Text(element.ym),
                  ),

                  //forで仕方ない
                  for (var i = 0; i < datas.length; i++) ...[
                    const SizedBox(height: 20),
                    dispData(
                      icon: datas[i]['icon']! as IconData,
                      title: datas[i]['title'].toString(),
                      data: datas[i]['data'].toString(),
                    ),
                  ],
                ],
              ),
            ),
          );
        });

        return SingleChildScrollView(child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*



    final homeFixState = _ref.watch(homeFixProvider(date));

    homeFixState.forEach((element) {
      //--------------------------------
      final datas = [
        {'icon': FontAwesomeIcons.house, 'title': 'yachin', 'data': element.yachin},
        {'icon': FontAwesomeIcons.wifi, 'title': 'wifi', 'data': element.wifi},
        {'icon': FontAwesomeIcons.mobileScreenButton, 'title': 'mobile', 'data': element.mobile},
        {'icon': FontAwesomeIcons.fireFlameSimple, 'title': 'gas', 'data': element.gas},
        {'icon': FontAwesomeIcons.bolt, 'title': 'denki', 'data': element.denki},
        {'icon': FontAwesomeIcons.droplet, 'title': 'suidou', 'data': element.suidou},
      ];
      //--------------------------------

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
                    colors: [Colors.indigo.withOpacity(0.8), Colors.transparent],
                    stops: const [0.7, 1],
                  ),
                ),
                child: Text(element.ym),
              ),

              //forで仕方ない
              for (var i = 0; i < datas.length; i++) ...[
                const SizedBox(height: 20),
                dispData(
                  icon: datas[i]['icon']! as IconData,
                  title: datas[i]['title'].toString(),
                  data: datas[i]['data'].toString(),
                ),
              ],
            ],
          ),
        ),
      );
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );




    */
  }

  ///
  Widget dispData({required IconData icon, required String title, required String data}) {
    return Row(
      children: [
        Icon(icon, size: 14),
        const SizedBox(width: 20),
        Expanded(child: Text(title)),
        Expanded(
          flex: 3,
          child: Text(data),
        ),
      ],
    );
  }
}
