import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LatLng _geoPoint = LatLng(9.77, 3.44);

  @override
  void initState() {
    super.initState();
    // Start the timer when the state is initialized
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      // Update the location slightly after 5 seconds
      setState(() {
        _geoPoint =
            LatLng(_geoPoint.latitude + 0.001, _geoPoint.longitude + 0.001);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: FlutterMap(
          options: MapOptions(
            initialCenter: _geoPoint,
            initialZoom: 15.0,
            interactionOptions: InteractionOptions(flags: InteractiveFlag.all),
          ),
          children: [
            openStreetMapTileLayer,
            MarkerLayer(
              markers: [
                Marker(
                  point: _geoPoint,
                  child: Builder(
                    builder: (BuildContext context) {
                      return Icon(
                        Icons.circle,
                        color: Colors.red,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.flemap.flutter_map.example',
    );
