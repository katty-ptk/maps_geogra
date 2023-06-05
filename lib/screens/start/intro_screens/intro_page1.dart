import 'package:flutter/material.dart';

import '../../../utils/extentions.utils.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

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
             // child: Image.network("https://www.scusd.edu/sites/main/files/imagecache/tile/main-images/camera_lense_0.jpeg")
              child: const Image(
                image: AssetImage('assets/images/presentation/1.png'),
                width: 250,
              ),
            ),

            const SizedBox(height: 60,),

            const Text(
              "Explore and discover fascinating places around the world by navigating through our interactive map.",
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