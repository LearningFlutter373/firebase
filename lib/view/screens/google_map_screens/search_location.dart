import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(SearchLocation());
}

class SearchLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapWithSearch(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapWithSearch extends StatefulWidget {
  @override
  _MapWithSearchState createState() => _MapWithSearchState();
}

class _MapWithSearchState extends State<MapWithSearch> {
  late GoogleMapController mapController;
  late TextEditingController searchController;
  PlacesAutocompleteResponse? _response;
  final places = GoogleMapsPlaces(apiKey: 'AIzaSyB_RYmhdi_x8wI8UqCd16E30gdSyd13b4M');
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Map with Search'),
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 12.0,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                color: Colors.white,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Location',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _onSearch();
                      },
                    ),
                  ),
                ),
              ),
            ),
            if (_response != null)
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount: _response!.predictions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_response!.predictions[index].description ?? 'No description available'),
                        onTap: () {
                          if (_response!.predictions[index].placeId != null) {
                            _onSelectPlace(_response!.predictions[index].placeId!);
                            setState(() {
                              _response = null;
                            });
                          } else {
                            // Handle the case where placeId is null
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  Future<void> _onSearch() async {
    PlacesAutocompleteResponse response = await places.autocomplete(
      searchController.text,
      language: 'en',
      location: Location( lat: _currentPosition.latitude, lng: _currentPosition.longitude,),
      radius: 10000, // Adjust the radius as needed
    );
    setState(() {
      _response = response;
    });
  }

  Future<void> _onSelectPlace(String placeId) async {
    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(placeId, language: 'en');
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    LatLng latLng = LatLng(lat, lng);
    mapController.animateCamera(CameraUpdate.newLatLng(latLng));
    setState(() {
      searchController.text = detail.result.formattedAddress!;
      _response = null;
    });
  }

  void _getCurrentLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
