// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/time_location.dart';
import '../../route/routes.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/time_location/time_location_notifier.dart';
import '../../utility/utility.dart';

class TimeLocationAlert extends ConsumerWidget {
  TimeLocationAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  List<TimeLocation> timeLocationList = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

              GestureDetector(
                onTap: () =>
                    context.goNamed(RouteNames.timeLocationMap, extra: {'date': date, 'list': timeLocationList}),
                child: const Icon(Icons.map),
              ),

              const SizedBox(height: 20),

              Expanded(child: displayTimeLocation()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayTimeLocation() {
    final tlList = _ref.watch(timeLocationProvider(date).select((value) => value.timeLocationList));

    return tlList.when(
      data: (value) {
        timeLocationList = tlList.value!;

        final list = <Widget>[];

        value.forEach((element) {
          list.add(
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(child: Text(element.time)),
                  Expanded(child: Text(element.latitude)),
                  Expanded(child: Text(element.longitude)),
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



    final list = <Widget>[];

    final timeLocationState = _ref.watch(timeLocationProvider(date));
    timeLocationList = timeLocationState;

    timeLocationState.forEach((element) {
      // final latLngAddressState = _ref.watch(
      //   latLngAddressProvider(
      //     LatLngAddressParamState(
      //       latitude: element.latitude,
      //       longitude: element.longitude,
      //     ),
      //   ),
      // );

      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(child: Text(element.time)),
              Expanded(child: Text(element.latitude)),
              Expanded(child: Text(element.longitude)),
            ],
          ),
        ),
      );

//      sleep(Duration(milliseconds: 500));
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );



    */
  }
}
