import 'dart:async';

import 'package:brianpharmacy/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final Completer<GoogleMapController> _controllerGoogleMap =
      Completer<GoogleMapController>();
  late GoogleMapController newGoogleMapController;

  late Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  void locatePosition() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);

    // wait for the GoogleMapController to be initialized before animating the camera
    await _controllerGoogleMap.future;
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.hybrid,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              setState(() {
                bottomPaddingOfMap = 350.0;
              });
              locatePosition();
            },
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 350.0,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7))
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6.0),
                    const Text(
                      "Hey there,",
                      style: TextStyle(fontSize: 12.0),
                    ),
                    const Text(
                      "Where to?",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Brand-Bold",
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _addMarker,
                      child: const Icon(Icons.pin_drop),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7))
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.search,
                              color: Colors.lightBlueAccent,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text("Search Pharamcy")
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.home, color: Colors.grey),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Add location"),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Your current address",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12.0),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const DividerWidget(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.work, color: Colors.grey),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Add location"),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Your destination address",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12.0),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _addMarker() {}
}
