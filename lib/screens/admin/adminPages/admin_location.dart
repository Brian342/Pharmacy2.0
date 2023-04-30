import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LoationPicker extends StatefulWidget {
  const LoationPicker({super.key});

  @override
  State<LoationPicker> createState() => _LoationPickerState();
}

class _LoationPickerState extends State<LoationPicker> {
  late GoogleMapController mapController;

  static const LatLng _initialPosition = LatLng(37.7749, -122.4194);
  LatLng _pickedLocation = _initialPosition;

  final destinationAddressController = TextEditingController();
  final desrinationAddressFocusNode = FocusNode();
  String _destinationAddress = '';

  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    required Icon prefixIcon,
    Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return Card(
      child: SizedBox(
        width: width * 0.8,
        child: TextField(
          onChanged: (value) {
            locationCallback(value);
          },
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            labelText: label,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(
                color: Colors.blue.shade300,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.all(15),
            hintText: hint,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition:
              const CameraPosition(target: _initialPosition, zoom: 14.0),
          onMapCreated: (controller) {
            mapController = controller;
          },
          onTap: (location) {
            setState(() {
              _pickedLocation = location;
            });
            _onLocationSelected();
          },
          markers: {
            Marker(
              markerId: const MarkerId('picked-location'),
              position: _pickedLocation,
            ),
          },
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                width: width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Places',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(height: 10),
                      _textField(
                          label: 'Pharmacy Location',
                          hint: 'Choose Location',
                          prefixIcon: const Icon(Icons.looks_two),
                          controller: destinationAddressController,
                          focusNode: desrinationAddressFocusNode,
                          width: width,
                          locationCallback: (String value) {
                            setState(() {
                              _destinationAddress = value;
                            });
                          }),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onLocationSelected() {
    Navigator.pop(context, _pickedLocation);
    setState(() {
      _destinationAddress =
          '${_pickedLocation.latitude},${_pickedLocation.longitude}';
    });
  }
}
