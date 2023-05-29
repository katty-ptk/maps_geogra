// ignore_for_file: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_geogra/utils/navigation.utils.dart';
import 'package:maps_geogra/utils/paths.utils.dart';
import 'package:maps_geogra/utils/routes.utils.dart';
import 'package:maps_geogra/widgets/place_info.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController; 

  Set<Marker> markers = {};
  List<dynamic> fetchedPlaces = <dynamic>[];

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(46.4298523, 21.8240082),
    zoom: 0,
  );  

  Future<dynamic> fetchPlaces() async {
    var response = await http.get(Uri.parse(Paths().BASE_URL + Paths().ALL_PLACES));
    var decodedResponse = json.decode(response.body.toString());

    return decodedResponse;
  }

  addMarkers(List<dynamic> markersToAdd) {
    for (var marker in markersToAdd) {
      markers.add(Marker(
        markerId: MarkerId("_${marker["title"]}kGooglrrePlex"),
        infoWindow: InfoWindow(
          title: marker["title"].toString(),
          snippet: marker["snippet"].toString()
        ),
        // icon: BitmapDescriptor.fromBytes(customMarker, size: const Size(3, 3)),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng( double.parse(marker["lat"]), double.parse(marker["lng"])),
        onTap: () {
          showModalBottomSheet(
            context: context, 
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15)
              )
            ),
            builder: (BuildContext context ) {
              return DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.4,
                minChildSize: 0.32,
                maxChildSize: 0.9,
                builder:(context, scrollController) =>
                 PlaceInfo(
                  scrollController: scrollController, 
                  placeTitle: marker["title"].toString(), 
                  placeImages: marker["images"],
                  climate: marker["climate"],
                  nature: marker["nature"],
                  tourism: marker["tourism"],
                  economy: marker["economy"],
                  borders: marker["borders"],
                 )
              );
            }
          );
        }
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPlaces(),
      builder: (context, snapshot) {
        if ( snapshot.connectionState == ConnectionState.waiting ){
          return const Center(child: CircularProgressIndicator());
        } else if ( snapshot.hasData ) {

          List<dynamic> data = snapshot.data;
          addMarkers(data);

          return buildMap();
        }

        return Container();
      },
    );
  }

  Widget buildMap() {
    return Scaffold(
      body: Stack(
        children: [ 
          GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: markers,
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
            _controller.complete(controller);
          },
        ),

        Positioned(
          top: 50,
          right: 10,
          child: TextButton(
              onPressed: () => NavigationUtil().navigateTo(context, Routes().NEW_PLACE_SCREEN), 
          
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)))
              ),
              
              child: const Text(
                "+",
                style: TextStyle(
                  fontSize: 32,
                ),
              )
            ),
          ),
      ]),
    );
   }
}