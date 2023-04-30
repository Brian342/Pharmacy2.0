import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeolocationPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const GeolocationPage({super.key, required this.data});

  @override
  State<GeolocationPage> createState() => _GeolocationPageState();
}

class _GeolocationPageState extends State<GeolocationPage> {
  String locationMessage = 'current location';
  late String lat;
  late String long;
  double distance = 0.0;

  //Getting current location
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('location services are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'location permission are permanently denied, we cannot request permission to access the location');
    }
    return await Geolocator.getCurrentPosition();
  }

  //listen to location updates
  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();

      setState(() {
        locationMessage = 'latitude: $lat , longitude: $long';
      });
    });
  }

  GoogleMapController? _controller;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  void _addPolyline(LatLng source, LatLng destination) {
    _polylines.add(Polyline(
      polylineId: const PolylineId('route'),
      visible: true,
      points: [source, destination],
      width: 4,
      color: Colors.blue,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    ));
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller = controller;

    Position currentPosition = await _getCurrentLocation();
    String sourceLat = currentPosition.latitude.toString();
    String sourceLong = currentPosition.longitude.toString();

    LatLng sourceLatLng =
        LatLng(currentPosition.latitude, currentPosition.longitude);
    LatLng destinationLatLng = LatLng(
        double.parse(widget.data['location'].first),
        double.parse(widget.data['location'].last));

    // calculate distance between source and destination
    distance = await _calculateDistance(sourceLatLng, destinationLatLng);

    CameraPosition cameraPosition = CameraPosition(
      target: sourceLatLng,
      zoom: 14.4746,
    );
    _controller!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: const MarkerId('source'),
        position: sourceLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: 'Your Location'),
      ));
      _markers.add(Marker(
        markerId: const MarkerId('destination'),
        position: destinationLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: widget.data['name']),
      ));
      _polylines.clear();
      _addPolyline(sourceLatLng, destinationLatLng);
    });
  }

  Future<double> _calculateDistance(
      LatLng sourceLatLng, LatLng destinationLatLng) async {
    double distanceInMeters = Geolocator.distanceBetween(
        sourceLatLng.latitude,
        sourceLatLng.longitude,
        destinationLatLng.latitude,
        destinationLatLng.longitude);
    double distanceInKm = distanceInMeters / 1000;
    return distanceInKm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
      ),
      body: Stack(children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          polylines: _polylines,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 14.4746,
          ),
          myLocationEnabled: true,
        ),
        Visibility(
          visible: distance != 0.0,
          child: Text(
            'Distance: ${distance.toStringAsFixed(2)} km',
            style: const TextStyle(fontSize: 24),
          ), // show only when distance is calculated
        ),
      ]),
    );
  }
}
