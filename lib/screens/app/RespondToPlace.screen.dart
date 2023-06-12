import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:maps_geogra/utils/api_paths.utils.dart';
import 'package:maps_geogra/utils/extentions.utils.dart';

class RespondToPlaceScreen extends StatefulWidget {
  final String plcaeID;

  const RespondToPlaceScreen({super.key, required this.plcaeID});

  @override
  State<RespondToPlaceScreen> createState() => _RespondToPlaceScreenState();
}


class _RespondToPlaceScreenState extends State<RespondToPlaceScreen> {
  late Map<String, dynamic> place;

  Future<Map<String, dynamic>> fetchPlace() async {
    var response = await http.get(
      Uri.parse(
        "${Paths().BASE_URL}${Paths().PENDING_PLACES}/${widget.plcaeID}"
      )
    );

    var decodedResponse = json.decode(response.body.toString());
    Map<String, dynamic> mapOfPlace = Map.from(decodedResponse);

    place = mapOfPlace;

    return mapOfPlace;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Respond to Text"),
        backgroundColor: Colors.indigo,
      ),

      body: FutureBuilder(
        future: fetchPlace(),
        builder: (context, snapshot) {
          if ( snapshot.connectionState == ConnectionState.waiting ){
            return const SizedBox(width: double.infinity, height: double.infinity, child: Center(child: CircularProgressIndicator()));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // images
                  buildImages(),
                  
                  // title
                  buildTitle(),
            
                  const SizedBox(height: 32,),
            
            
                  // climate
                  buildPropTitle("Climate", HexColor("#6495ED")),
                  buildPropText("Climate"),
            
                  const SizedBox(height: 32,),
            
                  // nature
                  buildPropTitle("Nature", HexColor("#097969")),
                  buildPropText("Nature"),
            
                  const SizedBox(height: 32,),
            
                  // tourism
                  buildPropTitle("Tourism", HexColor("#E49B0F")),
                  buildPropText("Tourism"),
            
                  const SizedBox(height: 32,),
            
                  // economy
                  buildPropTitle("Economy", HexColor("#800020")),
                  buildPropText("Economy"),
            
                  const SizedBox(height: 32,),
            
                  // borders
                  buildPropTitle("Borders", HexColor("#DE3163")),
                  buildPropText("Borders"),
            
                  const SizedBox(height: 32,),

                 // buttons
                 buildButtons(),
                ],
              ),
            ),
          );
        },
      )
    );
  }


  Widget buildImages() {
    List<dynamic> placeImages = place["images"];

    return
      SizedBox(
        width: double.infinity,
        child: CarouselSlider.builder(
          itemCount: placeImages.length, 
          options: CarouselOptions(height: 200),
          itemBuilder: (
            (context, index, realIndex) => buildImage(placeImages[index])
          ), 
        ),
      );
  }

  Widget buildImage(String urlImage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Image border
        child: SizedBox.fromSize(
          size: const Size.fromRadius(48), // Image radius
          child: Image.network(urlImage, fit: BoxFit.cover),
        ),
      )
    );
  }

  Widget buildTitle() {
    return 
      Center(
        child: Text(
          place["title"],
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
          ),
        ),
      );
  }

  Widget buildPropTitle(String property, HexColor textColor) {
    return
      Text(
        property,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: textColor
        ),
      );
  }

  Widget buildPropText(String property) {
    return
      Text(
        place[property.toLowerCase()],
        style: const TextStyle(
          
        ),
      );
  }

  Widget buildButtons() {
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {

            },

           style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll(Size(30, 50)),
            backgroundColor: const MaterialStatePropertyAll(Colors.green),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                )
              )
            ),

            child: const Icon(Icons.check_rounded, color: Colors.white, size: 28,)
          ),

          const SizedBox(width: 32,),

          ElevatedButton(
            onPressed: () {

            },

           style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll(Size(30, 50)),
            backgroundColor: const MaterialStatePropertyAll(Colors.redAccent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                )
              )
            ),

            child: const Icon(Icons.clear_rounded, color: Colors.white, size: 28,)
          ),
        ],
      );
  }

}