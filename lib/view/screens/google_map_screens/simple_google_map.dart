import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class SimpleGoogleMap extends StatefulWidget {
  @override
  _SimpleGoogleMap createState() => _SimpleGoogleMap();
}
class _SimpleGoogleMap extends State<SimpleGoogleMap> {

  static final CameraPosition _cameraPosition =
  CameraPosition(target: LatLng(37.4545678956, -122.03456767), zoom: 14.456);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Simple Google Map')),
          backgroundColor: Colors.green,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: _cameraPosition,
            ),

          ],
        ),
      ),
    );
  }
}
