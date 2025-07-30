import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    WorldTime currentTime = WorldTime(
      location: 'Casablanca',
      flag: 'ma',
      url: 'Africa/Casablanca',
    );
    await currentTime.getTime();
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: {
        'location': currentTime.location,
        'time': currentTime.time,
        'flag': currentTime.flag,
        'isDaytime': currentTime.isDaytime,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitSquareCircle(color: Colors.white, size: 50.0),
      ),
    );
  }
}
