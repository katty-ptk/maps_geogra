import 'package:flutter/material.dart';

import '../../../utils/extentions.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

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
                image: AssetImage('assets/images/presentation/2.png'),
                width: 250,
              ),
            ),

            const SizedBox(height: 60,),

            const Text(
              "Discover captivating images of places and uncover intriguing fun facts",
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
