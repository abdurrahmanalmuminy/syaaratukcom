import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension DoubleExtensions on double {
  double toRadians() => this * (pi / 180.0);
  double toDegrees() => this * (180.0 / pi);
}

LatLng calculateMidPoint(LatLng point1, LatLng point2) {
  double lat1 = point1.latitude;
  double lon1 = point1.longitude;
  double lat2 = point2.latitude;
  double lon2 = point2.longitude;

  double dLon = (lon2 - lon1).toRadians();

  lat1 = lat1.toRadians();
  lat2 = lat2.toRadians();
  lon1 = lon1.toRadians();

  double bx = cos(lat2) * cos(dLon);
  double by = cos(lat2) * sin(dLon);
  double lat3 = atan2(sin(lat1) + sin(lat2),
      sqrt((cos(lat1) + bx) * (cos(lat1) + bx) + by * by));
  double lon3 = lon1 + atan2(by, cos(lat1) + bx);

  return LatLng(lat3.toDegrees(), lon3.toDegrees());
}
