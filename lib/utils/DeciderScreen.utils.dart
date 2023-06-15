import 'package:flutter/material.dart';
import 'package:maps_geogra/screens/app/Home.screen.dart';
import 'package:maps_geogra/screens/start/introduction.screen.dart';
import 'package:maps_geogra/utils/shared_preferences.utils.dart';

class DeciderSrceen extends StatefulWidget {
  const DeciderSrceen({super.key});

  @override
  State<DeciderSrceen> createState() => _DeciderSrceenState();
}

class _DeciderSrceenState extends State<DeciderSrceen> {
  Future<bool> isNotFirstLaunch() async {
    MySharedPreferences mySharedPreferences = MySharedPreferences();

    if ( await mySharedPreferences.isFirstLaunch("isNotFirstLaunch") ) {
      return false;
    }

    await mySharedPreferences.setFirstLaunch("isNotFirstLaunch", true);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isNotFirstLaunch(),
      builder: (context, snapshot) {
        return snapshot.data.toString() == "false" ? const HomePage() : const IntroductionScreen();
      },
    );
  }
}