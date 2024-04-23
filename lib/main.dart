import 'package:flutter/material.dart';
import 'package:where_is_my_bus/pages/maps_page.dart';
import 'package:firebase_core/firebase_core.dart';
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
        theme:
            ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
        home: MapsPage());
  }
}
