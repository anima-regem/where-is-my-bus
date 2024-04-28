import 'package:flutter/material.dart';
import 'package:where_is_my_bus/pages/bus_page.dart';
import 'package:where_is_my_bus/pages/home_page.dart';
import 'package:where_is_my_bus/pages/landing_page.dart';
import 'package:where_is_my_bus/pages/maps_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:where_is_my_bus/pages/timeline_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Where is my bus?',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      routes: {
        '/': (context) => const LandingPage(),
        '/homepage': (context) => const HomePage(),
        '/maps': (context) => const MapsPage(),
        '/bus-page': (context) => const BusPage(),
      },
      initialRoute: '/',
    );
  }
}
