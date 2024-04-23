import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class FirebaseUtils {
  final db = FirebaseFirestore.instance;

  Stream<GeoPoint> LiveLocation() async* {}
}
