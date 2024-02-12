import 'package:firebase/view/screens/google_map_screens/simple_google_map.dart';
import 'package:firebase/view/screens/google_map_screens/singlemarker_googlemap.dart';
import 'package:flutter/material.dart';

import 'multiplemarker_googlemap.dart';




void main(){
  runApp(Map());
}
class Map extends StatelessWidget {
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultipleMarkerGoogleMap(),
    );
  }
}
