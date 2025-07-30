import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _time = 'Loading...';
  String _country = 'Select Location';
  String _flagUrl = '';
  bool _isDaytime = true;
  Map data = {};

  Future<void> _changeLocation() async {
    dynamic result = await Navigator.pushNamed(context, '/location');
    setState(() {
      data = {
        'location': result['location'],
        'time': result['time'],
        'flag': result['flag'],
        'isDaytime': result['isDaytime'],
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map;
    _time = data['time'];
    _country = data['location'];
    _flagUrl = data['flag'];
    _isDaytime = data['isDaytime'];

    return Scaffold(
      backgroundColor: _isDaytime ? Colors.blue[50] : Colors.indigo[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/about');
                      },
                      icon: Icon(Icons.info, size: 32,),
                      color: _isDaytime ? Colors.blue[100] : Colors.blue[800],
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Flag image
                if (_flagUrl.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        _flagUrl,
                        width: 120,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.flag,
                              size: 80,
                              color: Colors.grey,
                            ),
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
                // Country name
                Text(
                  _country,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _isDaytime ? Colors.black : Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                // Time display
                Text(
                  _time,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: _isDaytime ? Colors.blue[800] : Colors.amber[200],
                  ),
                ),
                const Spacer(),
                // Change location button
                ElevatedButton(
                  onPressed: _changeLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isDaytime
                        ? Colors.blue
                        : Colors.indigo[700],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'Change Location',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
