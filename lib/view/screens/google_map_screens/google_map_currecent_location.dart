import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const CurrentLocationHomePage());
}

class CurrentLocationHomePage extends StatefulWidget {
  const CurrentLocationHomePage({Key? key}) : super(key: key);

  @override
  _CurrentLocationHomePageState createState() => _CurrentLocationHomePageState();
}

class _CurrentLocationHomePageState extends State<CurrentLocationHomePage> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );

  Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(20.42796133580664, 75.885749655962),
      infoWindow: InfoWindow(
        title: 'My Position',
      ),
    ),
  };

  String appBarTitle = "Google Map In Flutter"; // Initial title

  // Method for getting user's current location
  Future<Position?> getCurrentUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return null;
    } else {
      return await Geolocator.getCurrentPosition();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF0F9D58),
            title: Text(appBarTitle), // Use dynamic title
          ),
          body: Container(
            child: SafeArea(
              child: GoogleMap(
                initialCameraPosition: _kGoogle,
                markers: _markers,
                mapType: MapType.normal,
                myLocationEnabled: true,
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Position? userLocation = await getCurrentUserLocation();
              if (userLocation != null) {
                print('${userLocation.latitude} ${userLocation.longitude}');
                setState(() {
                  _markers.add(
                    Marker(
                      markerId: MarkerId("2"),
                      position: LatLng(userLocation.latitude, userLocation.longitude),
                      infoWindow: InfoWindow(
                        title: 'My Current Location',
                      ),
                    ),
                  );

                  appBarTitle = "Current Location: ${userLocation.latitude}, ${userLocation.longitude}";
                });
                CameraPosition cameraPosition = CameraPosition(
                  target: LatLng(userLocation.latitude, userLocation.longitude),
                  zoom: 14,
                );
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
              } else {
                // Handle the case where user location is null
              }
            },
            child: const Icon(Icons.local_activity),
          ),
        ),
      ),
    );
  }
}
