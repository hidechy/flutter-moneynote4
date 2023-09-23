// ignore_for_file: cascade_invocations, must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/temple.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/station/station_notifier.dart';
import '../../state/temple_latlng/temple_latlng_notifier.dart';
import '../../state/temple_photos/temple_photos_notifier.dart';
import '../../utility/utility.dart';
import '_money_dialog.dart';
import 'temple_photo_history_alert.dart';

class TempleDisplayAlert extends ConsumerWidget {
  TempleDisplayAlert({super.key, required this.temple, required this.date});

  final DateTime date;
  final Temple temple;

  final Utility _utility = Utility();

  Map<String, String> templePhotoMap = {};

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    getDateTemplePhotoMap();

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
  void getDateTemplePhotoMap() {
    templePhotoMap = {};

    final templePhotoDateMap = _ref.watch(templePhotosProvider.select((value) => value.templePhotoDateMap));

    final list = templePhotoDateMap[date.yyyymmdd] ?? [];

    final list2 = <String>[];

    list.forEach((element) {
      if (!list2.contains(element.temple)) {
        templePhotoMap[element.temple] = getRandomTemplePhoto(templePhotos: element.templephotos);

        list2.add(element.temple);
      }
    });
  }

  ///
  String getRandomTemplePhoto({required List<String> templePhotos}) {
    final random = Random();

    return templePhotos[random.nextInt(templePhotos.length)];
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
      (templeLatLngMap[temple.temple] != null)
          ? Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (templePhotoMap[temple.temple] != null) ...[
                    SizedBox(
                      width: 40,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/no_image.png',
                        image: templePhotoMap[temple.temple]!,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(temple.temple),
                        Text(templeLatLngMap[temple.temple]!.address),
                        Text(
                          '${templeLatLngMap[temple.temple]!.lat} / ${templeLatLngMap[temple.temple]!.lng}',
                          style: const TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () =>
                          MoneyDialog(context: _context, widget: TemplePhotoHistoryAlert(temple: temple.temple)),
                      child: Icon(FontAwesomeIcons.toriiGate, color: Colors.white.withOpacity(0.6), size: 16)),
                ],
              ),
            )
          : Container(),
    );

    if (temple.memo != '') {
      temple.memo.split('、').forEach(
            (element) => list.add(
              (templeLatLngMap[element] != null)
                  ? Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration:
                          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (templePhotoMap[element] != null) ...[
                            SizedBox(
                              width: 40,
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/no_image.png',
                                image: templePhotoMap[element]!,
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(element),
                                Text(templeLatLngMap[element]!.address),
                                Text(
                                  '${templeLatLngMap[element]!.lat} / ${templeLatLngMap[element]!.lng}',
                                  style: const TextStyle(fontSize: 8),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                              onTap: () =>
                                  MoneyDialog(context: _context, widget: TemplePhotoHistoryAlert(temple: element)),
                              child: Icon(FontAwesomeIcons.toriiGate, color: Colors.white.withOpacity(0.6), size: 16)),
                        ],
                      ),
                    )
                  : Container(),
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

    list.add(const SizedBox(height: 20));

    return SingleChildScrollView(
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list),
      ),
    );
  }
}
