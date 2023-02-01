import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network("https://www.scusd.edu/sites/main/files/imagecache/tile/main-images/camera_lense_0.jpeg")
            ),

            const SizedBox(height: 60,),

            const Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
              style: TextStyle(
                fontSize: 24,
                // fontWeight: FontWeight.bold,
                // fontFamily: "Inter-Bold"
              ),
            )   
          ],),
      )
    );
  }
}