import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'get_address.dart';
//"google maps distance in flutter ?" 
//https://maps.googleapis.com/maps/api/distancematrix/json?destinations=40.659569,-73.933783&origins=40.6655101,-73.89188969999998&key=**YOUR_API_KEY_HERE**

/*
import 'package:dio/dio.dart';
void getDistanceMatrix() async {
  try {
    var response = await Dio().get('https://maps.googleapis.com/maps/api/distancematrix/json?destinations=40.659569,-73.933783&origins=40.6655101,-73.89188969999998&key=YOUR_API_KEY_HERE');
    print(response);
  } catch (e) {
    print(e);
  }
}

*/


double coordinateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}



/*
double getStraightLineDistances(lat1, lon1, lat2, lon2) {
  var R = 6371;
  var destinationLat = degreesToRadius(lat2 - lat1);
  var destinationLon = degreesToRadius(lon2 - lon1);
  var a = sin(destinationLat / 2) * sin(destinationLat / 2) +
      cos(degreesToRadius(lat1)) *
          cos(degreesToRadius(lat2)) *
          sin(destinationLon / 2) *
          sin(destinationLon / 2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a*2));
  var d = R * c; // Distance in km
  return d * 1000; //in m
}
*/

// double degreesToRadius(double deg) {
//   return deg * (pi / 180);
// }

totalDistance() async {
  double totalDistance = 0.0;
  List<LatLng> polylineCoordinates = controller.getPolylineCoordinates;
  for (int i = 0; i < polylineCoordinates.length - 1; i++) {
    totalDistance += coordinateDistance(
      polylineCoordinates[i].latitude,
      polylineCoordinates[i].longitude,
      polylineCoordinates[i + 1].latitude,
      polylineCoordinates[i + 1].longitude,
    );
  }
  controller.updateTotalDistance(totalDistance);
}
