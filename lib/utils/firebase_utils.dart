import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:cloud_firestore/cloud_firestore.dart' as fs;

//define a data model that can be cast from firebase data
class BusDetails {
  final String busName;
  final int capacity;
  final String conductorName;
  final String driverName;
  final String endLocation;
  final String endTime;
  final String model;
  final String remarks;
  final bool running;
  final String startLocation;
  final String startTime;
  final String type;

  BusDetails({
    required this.busName,
    required this.capacity,
    required this.conductorName,
    required this.driverName,
    required this.endLocation,
    required this.endTime,
    required this.model,
    required this.remarks,
    required this.running,
    required this.startLocation,
    required this.startTime,
    required this.type,
  });

  factory BusDetails.fromMap(Map<String, dynamic> data) {
    return BusDetails(
      busName: data["busName"],
      capacity: data["capacity"],
      conductorName: data["conductorName"],
      driverName: data["driverName"],
      endLocation: data["endLocation"],
      endTime: data["endTime"],
      model: data["model"],
      remarks: data["remarks"],
      running: data["running"],
      startLocation: data["startLocation"],
      startTime: data["startTime"],
      type: data["type"],
    );
  }
}

class StopDetails {
  final String id;
  final fs.GeoPoint location;
  final String name;
  final String time;

  StopDetails({
    required this.id,
    required this.location,
    required this.name,
    required this.time,
  });

  factory StopDetails.fromMap(Map<dynamic, dynamic> data) {
    return StopDetails(
      id: data["id"],
      location: data["location"] as fs.GeoPoint,
      name: data["name"],
      time: data["time"],
    );
  }
}

class Stops {
  final List<StopDetails> stops;

  Stops({required this.stops});

  /*
  {0: {name: Kadampazhipuram, location: Instance of 'GeoPoint', time: 8:00, id: 1}, 1: {name: Kongad, location: Instance of 'GeoPoint', id: 2, time: 8:20}, 2: {name: Pathiripala, location: Instance of 'GeoPoint', time: 8:30, id: 3}, 3: {name: Parali, location: Instance of 'GeoPoint', time: 8:50, id: 4}, 4: {name: Mepparambu, location: Instance of 'GeoPoint', time: 9:00, id: 5}}
   */
  factory Stops.fromMap(Map<String, dynamic> data) {
    List<StopDetails> stops = [];
    data.forEach((key, value) {
      stops.add(StopDetails.fromMap(value as Map<dynamic, dynamic>));
    });
    return Stops(stops: stops);
  }
}

class FirebaseUtils {
  final db = fs.FirebaseFirestore.instance.collection("current");

  Stream LiveLocation() async* {
    yield* db.snapshots().map((event) {
      osm.GeoPoint gp = osm.GeoPoint(
        latitude: event.docs[0]["latitude"] as double,
        longitude: event.docs[0]["longitude"] as double,
      );
      return gp;
    });
  }

  final bus1 = fs.FirebaseFirestore.instance.collection("bus1");
  Future<BusDetails> getBusDetails() async {
    var data = await bus1.doc("details").get();
    return BusDetails.fromMap(data.data() as Map<String, dynamic>);
  }

  Future<Stops> getStops() async {
    var data = await bus1.doc("stops").get();
    return Stops.fromMap(data.data() as Map<String, dynamic>);
  }
}
