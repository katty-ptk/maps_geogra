import 'package:flutter/material.dart';

class PendingPlaceCard extends StatelessWidget {
  const PendingPlaceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.deepPurple[50],
          border: Border.all(
            color: Colors.transparent
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
      //  color: Colors.black,
        child: Stack(
          children: [
            Column(
              children: const [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Asia")
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("by: mail@test.com")
                ),
              ],
            ),

            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.keyboard_arrow_right_rounded)
              )
            )
          ],
        ),
      ),
    );
  }

  TextStyle styleForText() {
    return TextStyle(
      
    );
  }
}