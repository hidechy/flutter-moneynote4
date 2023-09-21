// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/temple_latlng/temple_latlng_notifier.dart';
import '../../state/temple_photos/temple_photos_notifier.dart';
import '../../utility/utility.dart';

class TemplePhotoHistoryAlert extends ConsumerWidget {
  TemplePhotoHistoryAlert({super.key, required this.temple});

  final String temple;

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final templeLatLngMap = ref.watch(templeLatLngProvider.select((value) => value.templeLatLngMap));

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
          style: const TextStyle(fontSize: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(temple),
                  Text((templeLatLngMap[temple] != null) ? templeLatLngMap[temple]!.address : ''),
                ],
              ),

              Divider(thickness: 3, color: Colors.white.withOpacity(0.2)),

              Expanded(child: displayPhotoHistory()),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayPhotoHistory() {
    final list = <Widget>[];

    _ref.watch(templePhotosProvider.select((value) => value.templePhotoTempleMap)).forEach((key, value) {
      if (key == temple) {
        value.forEach((element2) {
          list.add(Column(
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
                child: Text('${element2.date.yyyymmdd} (${element2.date.youbiStr.substring(0, 3)})'),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: element2.templephotos.map((e) {
                  return Container(
                    width: 40,
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: FadeInImage.assetNetwork(placeholder: 'assets/images/no_image.png', image: e),
                  );
                }).toList()),
              ),
            ],
          ));
        });
      }
    });

    return SingleChildScrollView(
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list),
      ),
    );
  }
}
