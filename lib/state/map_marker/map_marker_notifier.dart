import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../time_location/time_location_notifier.dart';
import 'map_marker_state.dart';

//////////////////////////////////////////////////////

final mapMarkerProvider = StateNotifierProvider.autoDispose<MapMarkerNotifier, MapMarkerState>((ref) {
  return MapMarkerNotifier(const MapMarkerState(), ref: ref);
});

class MapMarkerNotifier extends StateNotifier<MapMarkerState> {
  MapMarkerNotifier(super.state, {required this.ref});

  final AutoDisposeStateNotifierProviderRef<MapMarkerNotifier, MapMarkerState> ref;

  Future<void> getMapMarker({required DateTime date, required String time}) async {
    var marker = const Marker(markerId: MarkerId(''));

    final timeLocationList = ref.watch(timeLocationProvider(date).select((value) => value.timeLocationList));

    timeLocationList.value?.forEach((element) {
      if (element.time == time) {
        marker = Marker(
          markerId: const MarkerId('marker'),
          position: LatLng(double.parse(element.latitude), double.parse(element.longitude)),
          infoWindow: InfoWindow(title: element.time),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        );
      }
    });

    /*



    final timeLocationState = ref.watch(timeLocationProvider(date));

    timeLocationState.forEach((element) {
      if (element.time == time) {
        marker = Marker(
          markerId: const MarkerId('marker'),
          position: LatLng(
            double.parse(element.latitude),
            double.parse(element.longitude),
          ),
          infoWindow: InfoWindow(title: element.time),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        );
      }
    });


    */

    state = state.copyWith(markers: {marker}, selectTime: time);
  }
}

//////////////////////////////////////////////////////
