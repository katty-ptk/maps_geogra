import 'package:flutter/material.dart';
import 'package:maps_geogra/screens/app/Home.screen.dart';
import 'package:maps_geogra/screens/app/NewPlace.screen.dart';
import 'package:maps_geogra/screens/app/PendingPosts.screen.dart';
import 'package:maps_geogra/utils/DeciderScreen.utils.dart';
import 'package:maps_geogra/utils/state_manager.utils.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StateManager(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const DeciderSrceen(),
          '/home': (context) => const HomePage(),
          '/newPlace': (context) => const NewPlaceScreen(),
          '/pendingPlaces': (context) => const PendingPlacesScreen(),
        },
      ),
    );
  }

}