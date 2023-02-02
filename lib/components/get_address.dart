import 'package:cpa_ui/components/markers/markers.dart';
import 'package:cpa_ui/get/get_controller.dart';
import 'package:cpa_ui/globals/colors.dart';
import 'package:cpa_ui/screens/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../globals/apikey.dart';
import 'get_distance.dart';

GetController controller = Get.find<GetController>();

getAddress() async {
  GetController getController = Get.find<GetController>();
  try {
    List<Placemark> p = await placemarkFromCoordinates(
      getController.initialPosition!.latitude,
      getController.initialPosition!.latitude,
    );
    Placemark place = p[0];
    var _currentAddress =
        "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
    var startAddressController = _currentAddress;
    var startAddress = _currentAddress;
    print('---------------current address' + startAddress.toString());
  } catch (e) {
    print(e);
  }
}

createPolylines(double startLatitude, double startLongitude,
    double destinationLatitude, double destinationLongitude) async {
  print(
      'coordinates are: $startLatitude $startLongitude  $destinationLatitude $destinationLongitude');
  PolylineResult result = await getController.polylinePoints
      .getRouteBetweenCoordinates(
          APIKEY,
          PointLatLng(startLatitude, startLongitude),
          PointLatLng(destinationLatitude, destinationLongitude),
          travelMode: TravelMode.transit);
  if (result.points.isNotEmpty) {
    for (var point in result.points) {
      controller.addPolyLinePoints(
          latLng: LatLng(point.latitude, point.longitude));
    }
  }
  PolylineId pId = const PolylineId('poly');
  Polyline polyline = Polyline(
    polylineId: pId,
    color: GetColor().blue,
    points: controller.getPolylineCoordinates,
    width: 3,
  );
  controller.addPolyLines(pId: pId, polyline: polyline);
  totalDistance();
}

getaddressDetails() async {
  List<Location> startPlacemark =
      await locationFromAddress(controller.startAddress.toString());
  List<Location> destinationPlacemark =
      await locationFromAddress(controller.destAddress.toString());
  double startLatitude = startPlacemark[0].latitude;
  double startLongitude = startPlacemark[0].longitude;
  double destinationLatitude = destinationPlacemark[0].latitude;
  double destinationLongitude = destinationPlacemark[0].longitude;
  String startCoordinatesString = '($startLatitude, $startLongitude)';
  String destinationCoordinatesString =
      '($destinationLatitude, $destinationLongitude)';
  var start = addMarker(
    markerId: startCoordinatesString,
    latLng: LatLng(startLatitude, startLongitude),
    icon: BitmapDescriptor.defaultMarkerWithHue(60.0),
  );
  var end = addMarker(
    markerId: destinationCoordinatesString,
    latLng: LatLng(destinationLatitude, destinationLongitude),
  );
  controller.addMarker(marker: start);
  controller.addMarker(marker: end);
  double miny = (startLatitude <= destinationLatitude)
      ? startLatitude
      : destinationLatitude;
  double minx = (startLongitude <= destinationLongitude)
      ? startLongitude
      : destinationLongitude;
  double maxy = (startLatitude <= destinationLatitude)
      ? destinationLatitude
      : startLatitude;
  double maxx = (startLongitude <= destinationLongitude)
      ? destinationLongitude
      : startLongitude;
  double southWestLatitude = miny;
  double southWestLongitude = minx;
  double northEastLatitude = maxy;
  double northEastLongitude = maxx;
  await createPolylines(
      startLatitude, startLongitude, destinationLatitude, destinationLongitude);
  animateWithPolyLine(northEastLatitude, northEastLongitude, southWestLatitude,
      southWestLongitude);
  /*
  double distanceInMeters = Geolocator.bearingBetween(
    startLatitude,
    startLongitude,
    destinationLatitude,
    destinationLongitude,
  );
  print('Totoal distance is :' + distanceInMeters.toString());

  return distanceInMeters;
  */
}
