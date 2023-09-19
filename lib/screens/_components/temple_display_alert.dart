// ignore_for_file: cascade_invocations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/state/temple_latlng/temple_latlng_notifier.dart';

import '../../extensions/extensions.dart';
import '../../models/temple.dart';
import '../../models/temple_photos.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/station/station_notifier.dart';
import '../../state/temple_photos/temple_photos_notifier.dart';
import '../../utility/utility.dart';

class TempleDisplayAlert extends ConsumerWidget {
  TempleDisplayAlert({super.key, required this.temple, required this.date});

  final DateTime date;
  final Temple temple;

  final Utility _utility = Utility();

  List<TemplePhoto> templePhotoList = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    getDateTemplePhotoList();

    /*
    print(templePhotoList);
    I/flutter (12724): [
    Instance of 'TemplePhoto',
    Instance of 'TemplePhoto',
    Instance of 'TemplePhoto',
    Instance of 'TemplePhoto',
    Instance of 'TemplePhoto',
    Instance of 'TemplePhoto'
    ]
    */

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

              Expanded(child: displayTemple()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void getDateTemplePhotoList() {
    templePhotoList = [];

    final templePhotoDateMap = _ref.watch(templePhotosProvider.select((value) => value.templePhotoDateMap));

    final list = templePhotoDateMap[date.yyyymmdd] ?? [];

    final list2 = <String>[];

    list.forEach((element) {
      if (!list2.contains(element.temple)) {
        templePhotoList.add(element);

        list2.add(element.temple);
      }
    });
  }

  ///
  Widget displayTemple() {
    final list = <Widget>[];

    final templeLatLngMap = _ref.watch(templeLatLngProvider.select((value) => value.templeLatLngMap));

    final stationMap = _ref.watch(stationProvider.select((value) => value.stationMap));

    list.add(Text(
      (temple.startPoint == '自宅' || temple.startPoint == '実家')
          ? temple.startPoint
          : '${stationMap[temple.startPoint]?.stationName}',
      style: const TextStyle(color: Colors.greenAccent),
    ));

    list.add(Divider(thickness: 3, color: Colors.white.withOpacity(0.2)));

    list.add(
      Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(temple.temple),
                Text((templeLatLngMap[temple.temple] != null) ? templeLatLngMap[temple.temple]!.address : ''),
                Text(
                  '${templeLatLngMap[temple.temple]!.lat} / ${templeLatLngMap[temple.temple]!.lng}',
                  style: const TextStyle(fontSize: 8),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (temple.memo != '') {
      temple.memo.split('、').forEach(
            (element) => list.add(
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(element),
                        Text((templeLatLngMap[element] != null) ? templeLatLngMap[element]!.address : ''),
                        Text(
                          '${templeLatLngMap[element]!.lat} / ${templeLatLngMap[element]!.lng}',
                          style: const TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
    }

    list.add(Divider(thickness: 3, color: Colors.white.withOpacity(0.2)));

    list.add(Text(
      (temple.endPoint == '自宅' || temple.endPoint == '実家')
          ? temple.endPoint
          : '${stationMap[temple.endPoint]?.stationName}',
      style: const TextStyle(color: Colors.greenAccent),
    ));

    return SingleChildScrollView(
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list),
      ),
    );
  }
}
