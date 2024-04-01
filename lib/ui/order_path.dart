import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sayaaratukcom/addition/calculate_mid_point.dart';
import 'package:sayaaratukcom/addition/padding.dart';
import 'package:sayaaratukcom/addition/widgets.dart';
import 'package:uicons/uicons.dart';

class OrderPath extends StatefulWidget {
  const OrderPath({super.key});

  @override
  State<OrderPath> createState() => _OrderPathState();
}

class _OrderPathState extends State<OrderPath> {
  //deliveryPoint
  final double _originLatitude = 24.631463357580124;
  final double _originLongitude = 46.70812960714102;

  //receivingPoint
  final double _destLatitude = 24.66210894398098;
  final double _destLongitude = 46.718915440142155;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyCPPW_gu6CBK63lcyr1DT4RmPv4nq3mjUo";

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.driving,);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }

  @override
  void initState() {
    super.initState();

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  GoogleMapController? mapController;

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(UIcons.regularRounded.cross)),
      ),
      body: SafeArea(
        child: Padding(
          padding: bodyPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heading(context,
                  title: "مسار الطلب",
                  subTitle: "تتبع مسار طلبك من نقطة الإستلام إلى نقطة التوصيل"),
              gap(height: 10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GoogleMap(
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: calculateMidPoint(LatLng(_originLatitude, _originLongitude), LatLng(_destLatitude, _destLongitude)),
                          zoom: 14),
                      polylines: Set<Polyline>.of(polylines.values),
                      markers: Set<Marker>.of(markers.values),
                      onMapCreated: (controller) async {
                        mapController = controller;
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
