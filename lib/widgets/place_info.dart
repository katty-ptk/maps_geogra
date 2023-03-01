// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PlaceInfo extends StatelessWidget {
  late BuildContext context;
  late ScrollController scrollController;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  late var placeImages;

  PlaceInfo({super.key, required this.scrollController, required this.placeImages});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (
      controller: scrollController,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 206, 223, 231),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                child: CarouselSlider.builder(
                  itemCount: placeImages != null ? placeImages.length : 1, 
                  options: CarouselOptions(height: 200),
                  itemBuilder: ( (context, index, realIndex) {

                    if ( placeImages == null ) {
                      return const Center(child: Text("no images for this place :/"));
                    }

                    final String urlImage = placeImages[index];
                    return buildImage(urlImage);
                  }), 
                ),
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
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
  }
}