import 'package:cpa_ui/get/get_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../screens/map_view.dart';

Future<void> get getCurrentLocation async {
  GetController controller = Get.put(GetController());
  bool permission = await Permission.location.isGranted;
  if (permission) {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    controller.updateCurrentLocation(position: position);
    print('calling animator...............');
    animateCamera();

    // await getAddress();
  } else {
    return;
  }
  return;
}
