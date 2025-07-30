import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {

  List<WorldTime> locations = [
    WorldTime(url: 'Africa/Casablanca', location: 'Casablanca', flag: 'ma'),
    // Europe
    WorldTime(url: 'Europe/London', location: 'London', flag: 'gb'),
    WorldTime(url: 'Europe/Paris', location: 'Paris', flag: 'fr'),
    WorldTime(url: 'Europe/Berlin', location: 'Berlin', flag: 'de'),
    WorldTime(url: 'Europe/Rome', location: 'Rome', flag: 'it'),
    // Africa
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'eg'),
    WorldTime(url: 'Africa/Johannesburg', location: 'Johannesburg', flag: 'za'),
    WorldTime(url: 'Africa/Lagos', location: 'Lagos', flag: 'ng'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'ke'),
    // America
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'us'),
    WorldTime(url: 'America/Sao_Paulo', location: 'Sao Paulo', flag: 'br'),
    WorldTime(url: 'America/Mexico_City', location: 'Mexico City', flag: 'mx'),
    WorldTime(url: 'America/Argentina/Buenos_Aires', location: 'Buenos Aires', flag: 'ar'),
    // Asia
    WorldTime(url: 'Asia/tokyo', location: 'Tokyo', flag: 'jp'),
    WorldTime(url: 'Asia/Manila', location: 'Manila', flag: 'ph'),
    WorldTime(url: 'Europe/Moscow', location: 'Moscow', flag: 'ru'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'kr'),
  ];

  void updateTime(index) async {
    WorldTime clickedLocation = locations[index];
    await clickedLocation.getTime();
    Navigator.pop(context, {
      'location': clickedLocation.location,
      'time': clickedLocation.time,
      'flag': clickedLocation.flag,
      'isDaytime': clickedLocation.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Change Location',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return LocationButton(
            location: locations[index],
            onTap: () {
              updateTime(index);
            },
          );
        },
      ),
    );
  }
}

class LocationButton extends StatelessWidget {
  final WorldTime location;
  final VoidCallback onTap;

  const LocationButton({Key? key, required this.location, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Flag
                Container(
                  width: 40,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      location.flag,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.flag, size: 80, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Location name
                Text(
                  location.location,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                // Chevron icon
                Icon(Icons.chevron_right, color: Colors.grey[600]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
