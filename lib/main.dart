import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'trip_selection.dart';
import 'trip_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    // Ensure that the provider is initialized at the root of the widget tree
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TripProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Trip Selection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TripSelectionPage(), // This page can now access TripProvider
    );
  }
}
