import 'package:flutter/material.dart';
import 'package:maps_geogra/utils/extentions.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("#8FB18F"),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: const Image(
                image: AssetImage('assets/images/presentation/3.png'),
                width: 250,
              ),            
            ),

            const SizedBox(height: 60,),

            const Text(
              "Click on the place's mark to reveal fascinating information about the location.",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                // fontFamily: "Inter-Bold"
              ),
            )   
          ],),
      )
    );
  }
}
