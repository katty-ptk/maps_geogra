// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps_geogra/utils/extentions.dart';

class PlaceInfo extends StatelessWidget {
  late BuildContext context;
  late ScrollController scrollController; 
  // ignore: prefer_typing_uninitialized_variables
  late String placeTitle = "", climate = "", nature = "", tourism = "", economy = "", borders = "";

  // ignore: prefer_typing_uninitialized_variables
  late var placeImages;

  PlaceInfo({
    super.key, 
    required this.scrollController,
    required this.placeTitle, 
    required this.placeImages,
    required this.climate,
    required this.nature,
    required this.tourism,
    required this.economy,
    required this.borders
  });

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView (
      controller: scrollController,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                width: double.infinity,
                child: CarouselSlider.builder(
                  itemCount: (placeImages != null && placeImages != [] ) ? placeImages.length : 1, 
                  options: CarouselOptions(height: 200),
                  itemBuilder: ( (context, index, realIndex) {

                    if ( placeImages == null || placeImages == [] ) {
                      return const Center(child: Text("no images for this place :/"));
                    }

                    final String urlImage = placeImages[index];
                    return buildImage(urlImage);
                  }), 
                ),
              ),

              Text(
                placeTitle,
                style: Theme.of(context).textTheme.headline3,
              ),

              buildInfoBody(
                context,
                "Climate", 
                climate
              ),

              buildInfoBody(
                context,
                "Nature", 
                nature
              ),

              buildInfoBody(
                context,
                "Tourism", 
                tourism
              ),

              buildInfoBody(
                context,
                "Economy", 
                economy
              ),

              buildInfoBody(
                context,
                "Borders", 
                borders
              ),

              ElevatedButton(
                child: const Text("close"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
              ),
            ],
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

  Widget buildInfoBody(BuildContext context, String infoTitle, String infoText) {
    Color title_color = HexColor("#484848");
    String icon_url = "";

    switch ( infoTitle ) {
      case "Climate":
        title_color = HexColor("#6495ED");
        icon_url = "https://cdn-icons-png.flaticon.com/512/5367/5367835.png";
        break;
      
      case "Nature":
        // green
        title_color = HexColor("#097969");
        icon_url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw45KThSjquRK6CbhIycoIL_PfzBMXrXpW4A&usqp=CAU";
        break;

      case "Tourism":
        // yellow
        title_color = HexColor("#E49B0F");
        icon_url = "https://cdn-icons-png.flaticon.com/512/2560/2560124.png";
        break;

      case "Economy":
        // purple
        title_color = HexColor("#800020");
       // icon_url = "https://uxwing.com/wp-content/themes/uxwing/download/banking-finance/economy-grow-icon.png";
        icon_url = "https://icon-library.com/images/economy-icon/economy-icon-12.jpg";
        break;

      case "Borders":
        // pink
        title_color = HexColor("#DE3163");
        icon_url = "https://cdn-icons-png.flaticon.com/128/6057/6057054.png";
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                icon_url,
                width: 24,
              ),
              const SizedBox(width: 15,),
              Text(
                infoTitle,
                style: GoogleFonts.comfortaa(
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: title_color
                  )
                ),
              ),
            ],
          ),
          

          const SizedBox(height: 10),

          Text(
            infoText,
            style: GoogleFonts.merriweatherSans(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: HexColor("#484848")
              )
            ),
          ),
        ],
      ),
    );
  }
}