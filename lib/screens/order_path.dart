import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:uicons/uicons.dart';

class OrderPath extends StatefulWidget {
  final LatLng origin;
  final LatLng destination;
  const OrderPath({super.key, required this.origin, required this.destination});

  @override
  State<OrderPath> createState() => _OrderPathState();
}

class _OrderPathState extends State<OrderPath> {
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
    Polyline polyline =
        Polyline(polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(widget.origin.latitude, widget.origin.longitude),
      PointLatLng(widget.destination.latitude, widget.destination.longitude),
      travelMode: TravelMode.driving,
    );
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
    _addMarker(widget.origin, "origin", BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(widget.destination, "destination",
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
          padding: Dimensions.bodyPadding,
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
                          target: widget.destination,
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