import 'package:flutter/material.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/location_picker.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/pages/about.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/' : (context) => Loading(),
      '/home' : (context) => Home(),
      '/location' : (context) => LocationPicker(),
      '/about' : (context) => About(),
    },
  ));
}






