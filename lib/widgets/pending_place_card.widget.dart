import 'package:flutter/material.dart';
import 'package:maps_geogra/screens/app/RespondToPlace.screen.dart';

class PendingPlaceCard extends StatefulWidget {
  final String title;
  final String senderEmail;
  final String placeID;

  const PendingPlaceCard({super.key, required this.placeID, required this.title, required this.senderEmail});


  @override
  State<PendingPlaceCard> createState() => _PendingPlaceCardState();
}

class _PendingPlaceCardState extends State<PendingPlaceCard> {
  @override
  Widget build(BuildContext context) {
    return 
      GestureDetector(
        onTap: () {
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => RespondToPlaceScreen(plcaeID: widget.placeID)));
        },
        child: buildPlaceCard()
      );
  }

  Widget buildPlaceCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: Container(
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.deepPurple[50],
          border: Border.all(
            color: Colors.transparent
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.title, 
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                      ),
                    )
                  ),

                  const SizedBox(height: 4,),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "by: ${widget.senderEmail}",
                    )
                  ),
                ],
              ),

              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {}, 
                  icon: const Icon(Icons.keyboard_arrow_right_rounded, size: 32,)
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}