// ignore_for_file: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_geogra/utils/navigation.utils.dart';
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

  // ignore: prefer_collection_literals
  Set<Marker> markers = Set();
  List<dynamic> fetchedPlaces = <dynamic>[];

  final customMarkers = [
    {
      "title": "Timisoara", 
      "snippet": "Transylvania: folklore & beautiful landscapes.",
      "lat": 45.7411191,
      "lng": 21.1815705,
    },

    {
      "title": "Asia",
      "snippet": "Great Wall of China, Wonder of the World.",
      "lat": 34.895055,
      "lng": 103.098987,
      "images": [
        'https://images.lifestyleasia.com/wp-content/uploads/sites/6/2022/09/02114323/GettyImages-654557138.jpg',
        'https://cdn.statically.io/img/rawmalroams.com/wp-content/uploads/2020/08/63F1820F-BC01-4AA8-B3CD-824F2E8E2DA7-1024x570.jpeg?quality=80&f=auto',
        'https://i.pinimg.com/736x/91/aa/1f/91aa1f9c25b79943bc65a4d0d44739c3.jpg',
        'https://travelmelodies.com/wp-content/uploads/2020/05/travel-melodies-bali-handara-gate-best-places-to-visit-in-asia.jpg'
      ]
    },

    {
      "title": "Greenland",
      "snippet": "Nature paradise: hiking, dog sledding, Northern Lights.",
      "lat": 76.214944,
      "lng": -44.955107,
      "images": [
        'https://travellersworldwide.com/wp-content/uploads/2022/12/Shutterstock_2176107763.jpg.webp',
        'https://tasermiutgreenland.com/wp-content/uploads/2020/01/greenland-wonders-qaleraliq-1.jpg',
        'https://storage.googleapis.com/oceanwide_web/media-dynamic/cache/widen_1600/media/default/0001/02/ff3266f646ee033159e28ac15d2d160e0974da8b.jpeg'
      ]
    },

    {
      "title": "Iceland",
      "snippet": "No mosquitoes here.",
      "lat": 64.683899,
      "lng": -18.828899,
      "images": [
        'https://www.planetware.com/wpimages/2020/01/iceland-in-pictures-beautiful-places-to-photograph-icelandic-countryside.jpg',
        'https://www.tripsavvy.com/thmb/Fi6L1P-bgRmk8rm17bhev3XF9no=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/northern-lights-at-mount-kirkjufell--iceland-1045987138-3f37999a3b8944999b0c3520ce83bd6c.jpg',
        'https://www.ourescapeclause.com/wp-content/uploads/2021/12/Iceland_Snaefellsnes-347.jpg'
      ],
    }
  ];

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(46.4298523, 21.8240082),
    zoom: 0,
  );  

  @override
  void initState() {
    //fetchPlaces();
    //addMarkers([]);
    super.initState();
  }

  Future<dynamic> fetchPlaces() async {
    var response = await http.get(Uri.parse("http://10.0.2.2:3000/places"));
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