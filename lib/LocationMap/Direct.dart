import 'package:Ucoe/LocationMap/Direction.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({Dio dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirections({
    @required LatLng origin,
    @required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${19.2798547},${72.8740709}',
        'destination': '${19.3505548},${72.9166332}',
        // 'origin': '${origin.latitude},${origin.longitude}',
        // 'destination': '${destination.latitude},${destination.longitude}',
        'key': 'AIzaSyDfgqTqhA1NkD8KzwgIS6Z0nNwL2JV-cuQ',
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null;
  }
}
