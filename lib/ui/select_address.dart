import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sayaaratukcom/addition/padding.dart';
import 'package:sayaaratukcom/addition/widgets.dart';
import 'package:uicons/uicons.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({super.key});

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  LatLng? userLocation;
  String? address;

  Location location = new Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  Future getCurrentLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation().then((location) {
      _locationData = location;
      setState(() {
        userLocation =
            LatLng(_locationData!.latitude!, _locationData!.longitude!);
        getAddress();
      });
    });
  }

  Future<void> getAddress() async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(userLocation!.latitude,
              userLocation!.longitude);
      geocoding.Placemark place = placemarks[0];
      setState(() {
        address = "${place.name}, ${place.locality}, ${place.country}";
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
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
                  title: "اختر العنوان",
                  subTitle: address ??
                      "اختر عنوانك من الخريطة او ابحث عن معلم"), //"6566، 4155، التلال، حفر الباطن 39957، السعودية"),
              textField(context,
                  readOnly: true,
                  hint: "إبحث عن عنوان",
                  icon: UIcons.regularRounded.search),
              gap(height: 10),
              userLocation == null
                  ? Expanded(child: grantPermission(context))
                  : Expanded(
                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GoogleMap(
                        onTap: (LatLng currentLocation) {
                          setState(() {
                            userLocation = currentLocation;
                            getAddress();
                            //userGeoPoint = GeoPoint.fromLatLng(point: userLocation!);
                          });
                        },
                        initialCameraPosition:
                            CameraPosition(target: userLocation!, zoom: 14.5),
                        markers: {
                          Marker(
                              markerId: const MarkerId("userLocation"),
                              position: userLocation!)
                        },
                      ),
                    )),
              // switchTile(context,
              //     switchWidget: Switch(
              //       value: saveAddress,
              //       onChanged: (value) => setState(() => saveAddress = value),
              //     ),
              //     title: "احفظ العنوان",
              //     subTitle: "احفظ هذا العنوان لإستخدامه لاحقاً"),
              gap(height: 10),
              primaryButton(context, "تأكيد العنوان", onPressed: () {
                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }
}
