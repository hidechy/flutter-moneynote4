// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../models/time_location.dart';
import '../state/polyline/polyline_notifier.dart';
import '../state/polyline/polyline_param_state.dart';
import '../utility/utility.dart';

class TimeLocationMapScreen extends ConsumerWidget {
  TimeLocationMapScreen({super.key, required this.date, required this.list});

  final DateTime date;
  final List<TimeLocation> list;

  final Utility _utility = Utility();

  ///
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Polyline> polylineSet = {};

  late CameraPosition basePoint;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    basePoint = CameraPosition(
      target: LatLng(list[0].latitude.toDouble(), list[0].longitude.toDouble()),
      zoom: 14,
    );

    if (list.length > 1) {
      makePolyline();
    }

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
              child: GoogleMap(
            initialCameraPosition: basePoint,
            onMapCreated: _controller.complete,
            polylines: polylineSet,
          )),
        ],
      ),
    );
  }

  ///
  Future<void> makePolyline() async {
    final twelveColor = _utility.getTwelveColor();

    for (var i = 0; i < list.length - 1; i++) {
      final polylineState = _ref.watch(polylineProvider(
        PolylineParamState(
          origin: '${list[i].latitude},${list[i].longitude}',
          destination: '${list[i + 1].latitude},${list[i + 1].longitude}',
        ),
      ));

      polylineSet.add(
        Polyline(
          polylineId: PolylineId('overview_polyline{$i}'),
          color: twelveColor[i % 12],
          width: 5,
          points: polylineState.polylinePoints
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList(),
        ),
      );
    }
  }
}
