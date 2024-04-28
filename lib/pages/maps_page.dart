import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:where_is_my_bus/utils/firebase_utils.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late MapController controller;
  late GeoPoint markerPosition;
  late BusDetails gloablBusDetails;
  late Stops gloablStopsDetails;
  List<GeoPoint> markers = [];
  late RoadInfo roadInfo;
  var isLoaded;
  FirebaseUtils fu = FirebaseUtils();
  double? durationTillNextStop;
  GeoPoint? nextLoaction;
  GeoPoint? prevLocation;
  StopDetails? nextStop;
  StopDetails? prevStop;
  bool isDataReady = false;
  int minuteDealy = 0;

  Future tryAllPossibleRoutes(RoadInfo roadInfo, List<GeoPoint> markers,
      GeoPoint markerPosition) async {
    int length = markers.length;
    print(markers);
    print(markerPosition);
    List<GeoPoint> tempMarkerList = [];
    for (int i = 0; i <= length; i++) {
      print("\n\n\n");
      print(i);
      //copy the list markers to tempMarkerList
      tempMarkerList = markers;
      tempMarkerList.insert(i, markerPosition);
      var newRoadInfo = await controller.drawRoad(
        tempMarkerList.first,
        tempMarkerList.last,
        roadType: RoadType.car,
        roadOption: RoadOption(roadColor: Colors.lightBlue, roadWidth: 10.0),
        intersectPoint:
            tempMarkerList.getRange(1, tempMarkerList.length - 2).toList(),
      );

      if ((newRoadInfo.distance!.abs() - roadInfo.distance!.abs()).abs() <
          1.5) {
        break;
      } else {
        print(newRoadInfo.distance);
        print(roadInfo.distance);
        controller.removeLastRoad();
      }
      tempMarkerList.removeAt(i);
    }

    // split the array at markerPosition
    int index = tempMarkerList.indexOf(markerPosition);
    List<GeoPoint> passedPoints = tempMarkerList.sublist(0, index);
    return passedPoints;
  }

  Future<BusDetails> getBusDetails() async {
    gloablBusDetails = await fu.getBusDetails();
    return gloablBusDetails;
  }

  Future getStopsAndProceed() async {
    gloablStopsDetails = await fu.getStops();
    gloablStopsDetails.stops.sort((b, a) => a.id.compareTo(b.id));
    for (StopDetails stop in gloablStopsDetails.stops) {
      print(stop.id);
      await controller.addMarker(
        GeoPoint(
          latitude: stop.location.latitude,
          longitude: stop.location.longitude,
        ),
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.circle,
            color: Colors.grey,
            size: 20,
          ),
        ),
      );

      markers.add(
        GeoPoint(
            latitude: stop.location.latitude,
            longitude: stop.location.longitude),
      );
    }

    RoadInfo roadInfo = await controller.drawRoad(
      markers.first,
      markers.last,
      roadType: RoadType.car,
      intersectPoint: markers.getRange(1, markers.length - 2).toList(),
      roadOption: const RoadOption(
        roadColor: Colors.lightBlue,
        roadWidth: 5.0,
      ),
    );

    List<GeoPoint> passedPoints =
        await tryAllPossibleRoutes(roadInfo, markers, markerPosition);
    for (GeoPoint point in passedPoints) {
      controller.addMarker(
        point,
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.circle,
            color: Colors.green,
            size: 20,
          ),
        ),
      );
    }

    markers.remove(markerPosition);

    if (passedPoints.length == markers.length) {
      nextLoaction = null;
      prevLocation = markers[markers.indexOf(passedPoints.last)];
      print("Reached end of the route");
    } else if (passedPoints.isEmpty) {
      nextLoaction = markers.first;
      prevLocation = null;
      print("Reached start of the route");
    } else {
      nextLoaction = markers[markers.indexOf(passedPoints.last) + 1];
      prevLocation = markers[markers.indexOf(passedPoints.last)];
      print("Reached middle of the route");
    }

    if (nextLoaction == null) {
      nextStop = null;
    } else {
      nextStop = gloablStopsDetails.stops.firstWhere((element) =>
          element.location.latitude == nextLoaction!.latitude &&
          element.location.longitude == nextLoaction!.longitude);
    }

    if (prevLocation == null) {
      prevStop = null;
    } else {
      prevStop = gloablStopsDetails.stops.firstWhere((element) =>
          element.location.latitude == prevLocation!.latitude &&
          element.location.longitude == prevLocation!.longitude);
    }

    if (nextLoaction != null) {
      RoadInfo dummyRoadInfo = await controller.drawRoad(
        markerPosition,
        nextLoaction!,
        roadType: RoadType.car,
        roadOption: const RoadOption(
          roadColor: Colors.lightBlue,
          roadWidth: 5.0,
        ),
      );

      durationTillNextStop = dummyRoadInfo.duration;
      final now = DateTime.now();
      final nextStopSetTimeString = nextStop!.time;
      // convert the string of format hh:mm to DateTime
      final nextStopSetTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(nextStopSetTimeString.split(":")[0]),
        int.parse(nextStopSetTimeString.split(":")[1]),
      );

      // add the duration to current time to see if the bus is late
      final nextStopTime =
          now.add(Duration(seconds: durationTillNextStop!.toInt()));
      print(durationTillNextStop! / 60);
      print(nextStopTime);
      print(nextStopSetTime);
      if (nextStopTime.isAfter(nextStopSetTime)) {
        minuteDealy = nextStopTime.difference(nextStopSetTime).inMinutes;
        print("Bus is late by $minuteDealy minutes");
      } else if (nextStopTime.isAtSameMomentAs(nextStopSetTime)) {
        print("Bus is on time");
      } else {
        minuteDealy = nextStopSetTime.difference(nextStopTime).inMinutes;
        print("Bus is early by $minuteDealy minutes");
      }

      setState(() {
        isDataReady = true;
      });
    }

    //   GeoPoint? nextLocation;
    //   StopDetails? nextStop;
    //   if (passedPoints.length == markers.length) {
    //     nextLocation = null;
    //   } else if (passedPoints.length == 0) {
    //     nextLocation = markers.first;
    //   } else {
    //     nextLocation = markers[markers.indexOf(passedPoints.last) + 1];
    //   }
    //   if (nextLocation == null) {
    //     nextStop = null;
    //   } else {
    //     nextStop = gloablStopsDetails.stops.firstWhere((element) =>
    //         element.location.latitude == nextLocation!.latitude &&
    //         element.location.longitude == nextLocation.longitude);
    //   }
    //   setState(
    //     () {
    //       isLoaded = true;
    //     },
    //   );
    // }
  }

  @override
  void initState() {
    isDataReady = false;
    controller = MapController(
      initPosition: GeoPoint(latitude: 10.9033616, longitude: 76.4318741),
    );
    controller.init();
    fu.LiveLocation().listen((event) {
      controller.setZoom(zoomLevel: 13);
      markerPosition = event;
      controller.changeLocation(markerPosition);
      controller.setZoom(zoomLevel: 16);
      getStopsAndProceed();
    });
    // getBusDetails();
    super.initState();
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
          backgroundColor: const Color(0xffffec99),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "where is my college bus?",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff000000),
                  textStyle: const TextStyle(letterSpacing: 1),
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/maps');
                },
                icon: Icon(Icons.refresh_rounded))
          ],
        ),
        body: SlidingUpPanel(
          panel: Builder(builder: (context) {
            return isDataReady
                ? Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Next Stop: ${nextStop!.name}",
                          style: GoogleFonts.poppins().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          "Time: ${nextStop!.time}",
                          style: GoogleFonts.poppins().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Bus is ${(durationTillNextStop! ~/ 60)} minutes away from the next stop",
                          style: GoogleFonts.poppins().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Bus is $minuteDealy minutes ${minuteDealy > 0 ? "late" : "early"}",
                          style: GoogleFonts.poppins().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(child: CircularProgressIndicator());
          }),
          body: OSMFlutter(
            controller: controller,
            mapIsLoading: const Center(child: CircularProgressIndicator()),
            osmOption: const OSMOption(
              showDefaultInfoWindow: true,
              showZoomController: true,
              zoomOption: ZoomOption(
                initZoom: 16,
              ),
            ),
          ),
        ));
  }
}
