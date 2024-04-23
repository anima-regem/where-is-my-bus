import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:where_is_my_bus/utils/firebase_utils.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late MapController controller;
  late GeoPoint markerPosition;

  void getRoadInfo() async {
    RoadInfo roadInfo = await controller.drawRoad(
      GeoPoint(latitude: 9.777789, longitude: 76.349743),
      GeoPoint(latitude: 9.774789, longitude: 76.341743),
      roadType: RoadType.car,
      roadOption: RoadOption(
        roadColor: Colors.red,
        roadWidth: 10,
      ),
    );

    print("${roadInfo.distance}km");
    print("${roadInfo.duration! / 60}min");
    print("${roadInfo.instructions}");
  }

  @override
  void initState() {
    super.initState();

    controller = MapController(
      initPosition: GeoPoint(latitude: 10.9033616, longitude: 76.4318741),
      // initMapWithUserPosition:
      //     UserTrackingOption(enableTracking: true, unFollowUser: false),
    );

    FirebaseUtils fu = FirebaseUtils();
    fu.LiveLocation().listen((event) {
      setState(() {
        markerPosition = event;
      });
    });

    // Set the marker position to a specific location
    markerPosition = GeoPoint(latitude: 9.773789, longitude: 76.341743);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Where is my bus?'),
      ),
      body: OSMFlutter(
        controller: controller,
        osmOption: OSMOption(
          showDefaultInfoWindow: true,
          showZoomController: true,
          zoomOption: ZoomOption(
            initZoom: 16,
          ),
        ),
      ),
    );
  }
}
