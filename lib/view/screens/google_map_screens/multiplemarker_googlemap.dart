import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MultipleMarkerGoogleMap extends StatefulWidget {
  @override
  _MultipleMarkerGoogleMap createState() => _MultipleMarkerGoogleMap();
}

class _MultipleMarkerGoogleMap extends State<MultipleMarkerGoogleMap> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(28.6139, 77.2090), // Corrected coordinates
    zoom: 14.456,
  );
  List<Marker> _markers = [];
  List<Marker> _list = const [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(26.6139, 85.2090),
      infoWindow: InfoWindow(title: "Sample Marker"),
    ),Marker(
      markerId: MarkerId("2"),
      position: LatLng(27.6139, 85.2090),
      infoWindow: InfoWindow(title: "Sample Marker"),
    ),
    Marker(
      markerId: MarkerId("3"),
      position: LatLng(28.6139, 85.2090),
      infoWindow: InfoWindow(title: "Sample Marker"),
    ),
    Marker(
      markerId: MarkerId("4"),
      position: LatLng(25.6139, 85.2090),
      infoWindow: InfoWindow(title: "Sample Marker"),
    ),
    Marker(
      markerId: MarkerId("5"),
      position: LatLng(33.6139, 85.2090),
      infoWindow: InfoWindow(title: "Sample Marker"),
    ),
  ];

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Multiple Marker Google Map')),
          backgroundColor: Colors.green,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _cameraPosition,
              markers: Set.from(_list),
            ),
          ],
        ),
      ),
    );
  }
}

