import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:sayaaratukcom/addition/colors.dart';
import 'package:uicons/uicons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    as google_maps_flutter;

const kGoogleApiKey = "AIzaSyCPPW_gu6CBK63lcyr1DT4RmPv4nq3mjUo";

Future<Prediction?> searchAddress(context) async {
  Prediction? prediction = await PlacesAutocomplete.show(
    context: context,
    apiKey: kGoogleApiKey,
    mode: Mode.overlay,
    overlayBorderRadius: BorderRadius.circular(10),
    strictbounds: false,
    language: "ar",
    logo: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/Powered_by_Google.png", height: 20),
        ],
      ),
    ),
    backArrowIcon: Icon(UIcons.regularRounded.angle_right),
    textDecoration: InputDecoration(
      hintText: "إبحث عن عنوان",
      border: InputBorder.none,
      hintStyle: TextStyle(color: AppColors.highlight1),
    ),
    components: [Component(Component.country, "SA")],
    types: [],
  );

  return prediction;
}

Future<google_maps_flutter.LatLng> getPlaceLatLng(
    Prediction? prediction) async {
  final places =
      GoogleMapsPlaces(apiKey: "AIzaSyCPPW_gu6CBK63lcyr1DT4RmPv4nq3mjUo");

  PlacesDetailsResponse placeDetails =
      await places.getDetailsByPlaceId(prediction!.placeId!);

  double lat = placeDetails.result.geometry?.location.lat ?? 0.0;
  double lng = placeDetails.result.geometry?.location.lng ?? 0.0;

  return google_maps_flutter.LatLng(lat, lng);
}
