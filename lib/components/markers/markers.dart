import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker addMarker(
    {required String? markerId,
    required LatLng? latLng,
    String? snippet,
    BitmapDescriptor? icon}) {
  return Marker(
    draggable: true,
    markerId: MarkerId(markerId.toString()),
    position: latLng as LatLng,
    infoWindow: InfoWindow(
      title: '$markerId',
      snippet: snippet,
    ),
    icon: icon ?? BitmapDescriptor.defaultMarkerWithHue(0.0),
  );
}
