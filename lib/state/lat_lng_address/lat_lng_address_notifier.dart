// ignore_for_file: avoid_catches_without_on_clauses, only_throw_errors

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

import '../../models/lat_lng_address.dart';
import 'lat_lng_address_param_state.dart';

//////////////////////////////////////////////////////

final latLngAddressProvider =
    StateNotifierProvider.autoDispose<LatLngAddressNotifier, LocationAddress>(
        (ref) {
  return LatLngAddressNotifier(
    LocationAddress(
      city: '',
      cityKana: '',
      town: '',
      townKana: '',
      x: '',
      y: '',
      distance: 0,
      prefecture: '',
      postal: '',
    ),
  );
});

class LatLngAddressNotifier extends StateNotifier<LocationAddress> {
  LatLngAddressNotifier(super.state);

  Future<void> getLatLngAddress(
      {required LatLngAddressParamState param}) async {
    try {
      final queryParameters = <String>[
        'method=searchByGeoLocation',
        'x=${param.longitude.substring(0, 7)}',
        'y=${param.latitude.substring(0, 6)}'
      ];

      final url =
          "https://geoapi.heartrails.com/api/json?${queryParameters.join('&')}";

      final response = await get(Uri.parse(url));

      final latLngAddress = latLngAddressFromJson(response.body);

      state = LocationAddress(
        city: latLngAddress.response.location[0].city,
        cityKana: latLngAddress.response.location[0].cityKana,
        town: latLngAddress.response.location[0].town,
        townKana: latLngAddress.response.location[0].townKana,
        x: latLngAddress.response.location[0].x,
        y: latLngAddress.response.location[0].y,
        distance: latLngAddress.response.location[0].distance,
        prefecture: latLngAddress.response.location[0].prefecture,
        postal: latLngAddress.response.location[0].postal,
      );
    } catch (e) {
      throw e.toString();
    }
  }
}

//////////////////////////////////////////////////////
