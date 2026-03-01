import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class LocationService {
  loc.Location location = loc.Location();

  double defaultLat = 30.0444;
  double defaultLng = 31.2357;

  Future<loc.LocationData> getCurrentLocation() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return _getDefaultLocation();
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return _getDefaultLocation();
    }

    try {
      return await location.getLocation();
    } catch (e) {
      return _getDefaultLocation();
    }
  }

  loc.LocationData _getDefaultLocation() {
    return loc.LocationData.fromMap({
      'latitude': defaultLat,
      'longitude': defaultLng,
    });
  }

  Future<String> getAddressFromLatLng(double lat, double lng) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    Placemark place = placemarks[0];
    return "${place.street}, ${place.locality}, ${place.country}";
  } catch (e) {
    return "عنوان غير معروف";
  }
}
}