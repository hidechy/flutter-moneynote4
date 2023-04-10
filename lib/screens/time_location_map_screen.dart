// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/state/route_transit/route_transit_param_state.dart';

import '../extensions/extensions.dart';
import '../models/time_location.dart';
import '../state/polyline/polyline_notifier.dart';
import '../state/polyline/polyline_param_state.dart';
import '../state/route_transit/route_transit_notifier.dart';
import '../state/route_transit/route_transit_result_state.dart';

class TimeLocationMapScreen extends ConsumerWidget {
  TimeLocationMapScreen({super.key, required this.date, required this.list});

  final DateTime date;
  final List<TimeLocation> list;

  ///
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Polyline> polylineSet = {};

  List<double> southwestLatList = [];
  List<double> southwestLngList = [];
  List<double> northeastLatList = [];
  List<double> northeastLngList = [];

  late LatLngBounds bounds;

  late CameraPosition basePoint;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        makeBoundsLine();
      },
    );

    _ref = ref;

    basePoint = CameraPosition(
      target: LatLng(
        list[0].latitude.toDouble(),
        list[0].longitude.toDouble(),
      ),
      zoom: 14,
    );

    bounds = LatLngBounds(
      southwest:
          LatLng(list[0].latitude.toDouble(), list[0].longitude.toDouble()),
      northeast:
          LatLng(list[0].latitude.toDouble(), list[0].longitude.toDouble()),
    );

    if (list.length > 1) {
      makePolyline();
    }

    return Scaffold(
      body: Column(
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
              initialCameraPosition: basePoint,
              onMapCreated: _controller.complete,
              polylines: polylineSet,
            ),
          ),
          //------------------------------------//
        ],
      ),
    );
  }

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

      /*

      final routeTransitState = _ref.watch(
        routeTransitProvider(
          RouteTransitParamState(
            start: '${list[0].latitude},${list[0].longitude}',
            goal: '${list[i + 1].latitude},${list[i + 1].longitude}',
            startTime: '${list[0].date.yyyymmdd}T${list[0].time}',
          ),
        ),
      );

      for (var j = 0;
          j < routeTransitState.list.length.toString().toInt() - 1;
          j++) {
        var origin = routeTransitState.list[j] as RouteTransitResultItemState;
        var destination =
            routeTransitState.list[j + 1] as RouteTransitResultItemState;

        print('ori ${origin.latitude},${origin.longitude}');
        print('des ${destination.latitude},${destination.longitude}');

        final polylineState = _ref.watch(polylineProvider(
          PolylineParamState(
            origin: '${origin.latitude},${origin.longitude}',
            destination: '${destination.latitude},${destination.longitude}',
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

      */

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
  }
}
