import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetController extends GetxController {
  LatLng _currentLatLng = LatLng(13.69415956453731, 13.97860047221184);
  LatLng _destLatLng = LatLng(0.0, 0.0);
  Position? _inital = Position(
      longitude: 13.0101,
      latitude: 13.0101,
      timestamp: DateTime.now(),
      accuracy: 5.0,
      altitude: 20,
      heading: 1.0,
      speed: 25,
      speedAccuracy: 10.0);
  Position? destination;
  Position? get initialPosition => _inital;
  Position? get _destPosition => _destPosition;
  LatLng get initLatLng => _currentLatLng;
  LatLng get destLatLng => _destLatLng;

  updateCurrentLocation({Position? position}) {
    print('updating loc current. ${position!.toJson()}');
    _currentLatLng = LatLng(position.latitude, position.longitude);
    _inital = position;
    update();
  }

  updateDestinationLocation({Position? position}) {
    _destLatLng = LatLng(position!.latitude, position.longitude);
    destination = position;
    update();
  }

  String? _startAddress = '';
  String? _destAddress;
  String? get startAddress => _startAddress;
  void updateStartAddress({String? address}) {
    _startAddress = address;
    update();
  }

  String? get destAddress => _destAddress;
  void updateDestAddress({String? address}) {
    _destAddress = address;
    update();
  }

  //

  final Set<Marker> _markers = {};

  final PolylinePoints _polylinePoints = PolylinePoints();
  final Map<PolylineId, Polyline> _polylines = {};
  final List<LatLng> _polylineCoordinates = [];
  Set<Marker> get getmarkers => _markers;
  Map<PolylineId, Polyline> get getpolylines => _polylines;
  PolylinePoints get polylinePoints => _polylinePoints;
  List<LatLng> get getPolylineCoordinates => _polylineCoordinates;
  void addMarker({required Marker marker}) {
    _markers.add(marker);
    print('marker added........');
    update();
  }

  void addPolyLinePoints({required LatLng latLng}) {
    _polylineCoordinates.add(latLng);
    print('marker added........');
    update();
  }

  void addPolyLines({required PolylineId pId, required polyline}) {
    _polylines[pId] = polyline;
    print('marker added........');
    update();
  }

  double _totalDistance = 0;
  double get getTotalDistance => _totalDistance;
  void updateTotalDistance(double distance) {
    _totalDistance = distance;
    update();
  }
}
