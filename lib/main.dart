import 'package:flutter/material.dart';
import 'package:maps_geogra/screens/start/introduction.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter',),
      home: const IntroductionScreen(),
    );
  }
}