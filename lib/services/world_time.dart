import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  late String time;
  String flag;
  String url;
  late bool isDaytime = true;

  WorldTime({required this.location, required this.flag, required this.url}) {
    flag = 'https://flagcdn.com/w320/${flag}.png';
  }
  // WorldTime(this.location, this.flag, this.url);

  Future <void> getTime() async {
    try {
      final response = await http.get(
        Uri.parse('http://api.timezonedb.com/v2.1/get-time-zone?key=41WNX2ED67DT&format=json&by=zone&zone=$url'),
        headers: {
          "Accept": "application/json",
        },
      );
        final data = jsonDecode(response.body);
        DateTime currentTime = DateTime.parse(data['formatted']);
        time = DateFormat.jm().format(currentTime);

        isDaytime = currentTime.hour > 6 && currentTime.hour < 20 ? true : false;
    } catch (e) {
      print('Error: $e');
      time = 'Ops! Could not get time data.';
    }
  }
}

