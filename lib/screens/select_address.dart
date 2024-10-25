import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_webservice/places.dart' as maps_webservice;
import 'package:location/location.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
import 'package:sayaaratukcom/widgets/ipad_location.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:sayaaratukcom/utils/search_address.dart';
import 'package:sizer/sizer.dart';
import 'package:uicons/uicons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectAddress extends StatefulWidget {
  final String address;
  const SelectAddress({super.key, required this.address});

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  LatLng? selectedPoint;
  String? selectedAddress;

  Location location = Location();
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
        selectedPoint =
            LatLng(_locationData!.latitude!, _locationData!.longitude!);
        getAddress();
      });
      return;
    });
  }

  Future<void> getAddress() async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
              selectedPoint?.latitude ?? 0, selectedPoint?.longitude ?? 0);
      geocoding.Placemark place = placemarks[0];
      setState(() {
        selectedAddress = "${place.name}, ${place.locality}, ${place.country}";
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

  GoogleMapController? mapController;

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(UIcons.regularRounded.cross)),
      ),
      body: Sizer(builder: (context, orientation, screenType) {
        return Device.screenType == ScreenType.tablet && Platform.isIOS
            ? const IpadLocation()
            : SafeArea(
                child: Padding(
                  padding: Dimensions.bodyPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      heading(context,
                          title: widget.address,
                          subTitle: selectedAddress ??
                              "اختر ${widget.address} من الخريطة او ابحث عن معلم"),
                      textField(context, readOnly: true, onTap: () async {
                        maps_webservice.Prediction? prediction =
                            await searchAddress(context);

                        if (prediction != null) {
                          LatLng placeLatLng = await getPlaceLatLng(prediction);
                          setState(() {
                            selectedPoint = placeLatLng;
                            getAddress();
                            if (mapController != null) {
                              mapController?.animateCamera(
                                  CameraUpdate.newLatLngZoom(placeLatLng, 14));
                            }
                          });
                        }
                      },
                          hint: "إبحث عن عنوان",
                          icon: UIcons.regularRounded.search),
                      gap(height: 10),
                      selectedPoint == null
                          ? Expanded(child: grantPermission(context))
                          : Expanded(
                              child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: GoogleMap(
                                myLocationEnabled: true,
                                onTap: (LatLng currentLocation) {
                                  setState(() {
                                    selectedPoint = currentLocation;
                                    getAddress();
                                    if (mapController != null) {
                                      mapController?.animateCamera(
                                          CameraUpdate.newLatLngZoom(
                                              selectedPoint!, 14));
                                    }
                                  });
                                },
                                initialCameraPosition: CameraPosition(
                                    target: selectedPoint ?? const LatLng(0, 0),
                                    zoom: 14),
                                onMapCreated: (controller) {
                                  mapController = controller;
                                },
                                markers: {
                                  Marker(
                                      markerId: const MarkerId("userLocation"),
                                      position:
                                          selectedPoint ?? const LatLng(0, 0)),
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
                        Navigator.pop(
                            context, [selectedPoint, selectedAddress]);
                      })
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
