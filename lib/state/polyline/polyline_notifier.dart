// ignore_for_file: avoid_dynamic_calls, avoid_catches_without_on_clauses, only_throw_errors

import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

import 'polyline_param_state.dart';
import 'polyline_result_state.dart';

//////////////////////////////////////////////////////

final polylineProvider = StateNotifierProvider.family
    .autoDispose<PolylineNotifier, PolylineResultState, PolylineParamState>(
        (ref, param) {
  return PolylineNotifier(const PolylineResultState())
    ..getPolyline(param: param);
});

class PolylineNotifier extends StateNotifier<PolylineResultState> {
  PolylineNotifier(super.state);

  Future<void> getPolyline({required PolylineParamState param}) async {
    try {
      final queryParameters = <String, dynamic>{
        'mode': 'walking',
        'language': 'ja',
        'key': 'AIzaSyD9PkTM1Pur3YzmO-v4VzS0r8ZZ0jRJTIU',
        'origin': param.origin,
        'destination': param.destination,
      };

      final uri = Uri.https(
        'maps.googleapis.com',
        'maps/api/directions/json',
        queryParameters,
      );

      final response = await get(uri);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        final routes = decoded['routes'] as Iterable;
        if (routes.isNotEmpty) {
          final data = decoded['routes'][0];

          final sw = data['bounds']['southwest'];
          final southwest = LatLng(
            double.parse(sw['lat'].toString()),
            double.parse(sw['lng'].toString()),
          );
          final ne = data['bounds']['northeast'];
          final northeast = LatLng(
            double.parse(ne['lat'].toString()),
            double.parse(ne['lng'].toString()),
          );
          final bounds =
              LatLngBounds(southwest: southwest, northeast: northeast);

          var distance = '';
          var duration = '';
          if ((data['legs'] as List).isNotEmpty) {
            final leg = data['legs'][0];
            distance = leg['distance']['text'].toString();
            duration = leg['duration']['text'].toString();
          }

          final polylinePoints = PolylinePoints()
              .decodePolyline(data['overview_polyline']['points'].toString());

          state = PolylineResultState(
            bounds: bounds,
            distance: distance,
            duration: duration,
            polylinePoints: polylinePoints,
            southwestLat: sw['lat'],
            southwestLng: sw['lng'],
            northeastLat: ne['lat'],
            northeastLng: ne['lng'],
          );
        }
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

//////////////////////////////////////////////////////
