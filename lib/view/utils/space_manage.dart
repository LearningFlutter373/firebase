import 'package:flutter/material.dart';

class SpaceMange {
  BuildContext context;
  SpaceMange({required this.context});


   getScreenWidth() {
    return MediaQuery.of(context).size.width;
  }

   getScreenHeight() {
    return MediaQuery.of(context).size.height;
  }
}

