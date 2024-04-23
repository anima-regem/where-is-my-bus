import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseUtils {
  final db = FirebaseFirestore.instance.collection("current");

  Stream LiveLocation() async* {
    yield* db.snapshots().map((event) {
      osm.GeoPoint gp = osm.GeoPoint(
        latitude: event.docs[0]["latitude"],
        longitude: event.docs[0]["longitude"],
      );
      return gp;
    });
  }
}
