// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../models/time_location.dart';

class TimeLocationMapScreen extends ConsumerWidget {
  TimeLocationMapScreen({super.key, required this.date, required this.list});

  final DateTime date;
  final List<TimeLocation> list;

  ///
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  //
  late CameraPosition basePoint;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    basePoint = CameraPosition(
      target: LatLng(list[0].latitude.toDouble(), list[0].longitude.toDouble()),
      zoom: 14,
    );

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
            ),
          ),
        ],
      ),
    );
  }
}
