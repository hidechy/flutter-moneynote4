// ignore_for_file: must_be_immutable, inference_failure_on_untyped_parameter, avoid_dynamic_calls

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../models/time_location.dart';
import '../state/map_marker/map_marker_notifier.dart';
import '../state/polyline/polyline_notifier.dart';
import '../state/polyline/polyline_param_state.dart';
import '../utility/utility.dart';

class TimeLocationMapScreen extends ConsumerWidget {
  TimeLocationMapScreen({super.key, required this.date, required this.list});

  final DateTime date;
  final List<TimeLocation> list;

  Utility utility = Utility();

  ///
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Polyline> polylineSet = {};

  List<double> latList = [];
  List<double> lngList = [];

  late LatLngBounds bounds;

  late CameraPosition basePoint;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        makeBoundsLine();
      },
    );

    basePoint = CameraPosition(
      target: LatLng(
        list[0].latitude.toDouble(),
        list[0].longitude.toDouble(),
      ),
      zoom: 14,
    );

    bounds = LatLngBounds(
      southwest: LatLng(
        list[0].latitude.toDouble(),
        list[0].longitude.toDouble(),
      ),
      northeast: LatLng(
        list[0].latitude.toDouble(),
        list[0].longitude.toDouble(),
      ),
    );

    if (list.length > 1) {
      makePolyline();
    }

    final mapMarkerState = ref.watch(mapMarkerProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          utility.getBackGround(),
          Column(
            children: [
              const SizedBox(height: 80),
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

              //------------------------------------//

              Expanded(
                child: GoogleMap(
                  mapType: MapType.terrain,
                  initialCameraPosition: basePoint,
                  onMapCreated: _controller.complete,
                  polylines: polylineSet,
                  markers: mapMarkerState.markers,
                ),
              ),

              //------------------------------------//

              timeSelectButton(),

              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }

  ///
  Widget timeSelectButton() {
    final mapMarkerState = _ref.watch(mapMarkerProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list.map((val) {
          return GestureDetector(
            onTap: () async {
              await _ref.watch(mapMarkerProvider.notifier).getMapMarker(
                    date: date,
                    time: val.time,
                  );
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.6),
                  ),
                  color: mapMarkerState.selectTime == val.time
                      ? Colors.yellowAccent.withOpacity(0.2)
                      : Colors.transparent),
              child: Text(val.time),
            ),
          );
        }).toList(),
      ),
    );
  }

  List<double> southwestLatList = [];
  List<double> southwestLngList = [];
  List<double> northeastLatList = [];
  List<double> northeastLngList = [];

  ///
  Future<void> makePolyline() async {
    southwestLatList = [];
    southwestLngList = [];
    northeastLatList = [];
    northeastLngList = [];

    for (var i = 0; i < list.length - 1; i++) {
      final polylineState = _ref.watch(polylineProvider(
        PolylineParamState(
          origin: '${list[i].latitude},${list[i].longitude}',
          destination: '${list[i + 1].latitude},${list[i + 1].longitude}',
        ),
      ));

      southwestLatList.add(polylineState.southwestLat.toString().toDouble());
      southwestLngList.add(polylineState.southwestLng.toString().toDouble());
      northeastLatList.add(polylineState.northeastLat.toString().toDouble());
      northeastLngList.add(polylineState.northeastLng.toString().toDouble());

      polylineSet.add(
        Polyline(
          polylineId: PolylineId('overview_polyline{$i}'),
          color: Colors.redAccent,
          width: 5,
          points: polylineState.polylinePoints
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList(),
        ),
      );
    }
  }

  ///
  Future<void> makeBoundsLine() async {
    final minSouthwestLat = southwestLatList.reduce(min);
    final minSouthwestLng = southwestLngList.reduce(min);
    final maxNortheastLat = northeastLatList.reduce(max);
    final maxNortheastLng = northeastLngList.reduce(max);

    bounds = LatLngBounds(
      southwest: LatLng(minSouthwestLat, minSouthwestLng),
      northeast: LatLng(maxNortheastLat, maxNortheastLng),
    );

    final controller = await _controller.future;

    await controller.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50),
    );

    const marker = MarkerId('marker');
    await controller.showMarkerInfoWindow(marker);
  }
}
