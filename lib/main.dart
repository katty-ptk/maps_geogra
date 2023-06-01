import 'package:flutter/material.dart';
import 'package:maps_geogra/screens/app/Home.screen.dart';
import 'package:maps_geogra/screens/app/NewPlace.screen.dart';
import 'package:maps_geogra/screens/app/SearchImage.screen.dart';
import 'package:maps_geogra/screens/start/introduction.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(fontFamily: 'Inter', textTheme: Theme.of(context).textTheme.apply(
      //   bodyColor: Colors.green,
      //   displayColor: Colors.pinkAccent
      // )),
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroductionScreen(),
        '/home': (context) => const HomePage(),
        '/newPlace': (context) => const NewPlaceScreen(),
        '/searchImage':(context) => const SearchImagePage()
      },
    );
  }

}