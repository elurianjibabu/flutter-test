import 'package:cpa_ui/components/get_current_location.dart';
import 'package:cpa_ui/get/get_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../globals/colors.dart';
import 'searchboxes.dart';

late GoogleMapController mapController;
final _scaffoldKey = GlobalKey<ScaffoldState>();

GetController getController = Get.put(GetController());
void animateCamera() {
  Position? position = getController.initialPosition;
  mapController.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position!.latitude, position.longitude),
        zoom: 18.0,
      ),
    ),
  );
}

void animateWithPolyLine(double northEastLatitude, double northEastLongitude,
    double southWestLatitude, double southWestLongitude) {
  mapController.animateCamera(
    CameraUpdate.newLatLngBounds(
      LatLngBounds(
        northeast: LatLng(northEastLatitude, northEastLongitude),
        southwest: LatLng(southWestLatitude, southWestLongitude),
      ),
      100.0,
    ),
  );
}

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  void initState() {
    super.initState();
    getCurrentLocation;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: width,
      child: Scaffold(
        /*
        drawer: Drawer(
            backgroundColor: GetColor().transparent,
            child: ListView(
              shrinkWrap: true,
              children: const [
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text('Settings'),
                )
              ],
            )),
        */
        key: _scaffoldKey,
        body: GetBuilder<GetController>(
            init: GetController(),
            builder: (controller) {
              return Stack(
                children: <Widget>[
                  GoogleMap(
                    buildingsEnabled: true,
                    compassEnabled: true,
                    markers: Set<Marker>.from(controller.getmarkers),
                    initialCameraPosition:
                        CameraPosition(target: getController.initLatLng),
                    mapToolbarEnabled: true,
                    rotateGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    mapType: MapType.terrain,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    polylines:
                        Set<Polyline>.of(getController.getpolylines.values),
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipOval(
                            child: Material(
                              color: GetColor().blueShade,
                              child: InkWell(
                                splashColor: GetColor().blue,
                                child: const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Icon(Icons.add),
                                ),
                                onTap: () {
                                  mapController.animateCamera(
                                    CameraUpdate.zoomIn(),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ClipOval(
                            child: Material(
                              color: GetColor().blueShade, // button color
                              child: InkWell(
                                splashColor: GetColor().blue, // inkwell color
                                child: const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Icon(Icons.remove),
                                ),
                                onTap: () {
                                  mapController.animateCamera(
                                    CameraUpdate.zoomOut(),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SearchBoxes(),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        splashColor: GetColor().orange, // inkwell color
                        child: const SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.my_location),
                        ),
                        onTap: () async {
                          print('location icon .');
                          try {
                            var isGranted = await Geolocator.checkPermission();
                            if (isGranted != LocationPermission.denied) {
                              print('inside granted................');
                              var loc = await Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.high);
                              print('${loc.toJson()}');
                              print('sending current loc to getx');
                              getController.updateCurrentLocation(
                                  position: loc);
                              animateCamera();
                            } else {
                              await Permission.location.request();
                            }
                          } catch (e) {}
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 70,
                    child: InkWell(
                      onTap: () async {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      child: const Icon(Icons.menu),
                    ),
                  ),

                  // Visibility(
                  //     visible:
                  //         getController.getTotalDistance <= 0 ? false : true,
                  //     child: Align(
                  //       alignment: Alignment.bottomCenter,
                  //       child: Text(
                  //         'Total Distance is: ${getController.getTotalDistance.toStringAsFixed(2)} KM',
                  //         style:
                  //             TextStyle(fontSize: 25, color: GetColor().white),
                  //       ),
                  //     ))
                ],
              );
            }),
      ),
    );
  }
}
