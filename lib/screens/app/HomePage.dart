// ignore_for_file: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_geogra/widgets/place_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController; 

  // ignore: prefer_collection_literals
  Set<Marker> markers = Set();

  final customMarkers = [
    {
      "title": "Timisoara", 
      "lat": 45.7411191,
      "lng": 21.1815705,
      "images": [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEQwYU9O1PD6BtRggwLGfnTRfGKH3Y0Ilg3Q&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTs15WUyz7trE3T6Ce9KizPAgWGTMiOh9pDZQ&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9YzeI0shLX5GnP7XnQwP_-oBUgnkJ_c8itw&usqp=CAU',
        'https://thumbs.dreamstime.com/b/holy-trinity-cathedral-sameba-tbilisi-night-georgia-holy-trinity-cathedral-sameba-tbilisi-night-georgia-124204445.jpg',
        'https://live.staticflickr.com/5150/5641331585_b246b31e42_z.jpg'
      ]
    },

    {
      "title": "Bucuresti", 
      "lat": 44.4379269,
      "lng": 26.0245983
    }
  ];

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(46.4298523, 21.8240082),
    zoom: 6,
  );  

  @override
  void initState() {
    addMarkers();
    super.initState();
  }

  addMarkers() {
    for (var marker in customMarkers) {
      markers.add(Marker(
        markerId: MarkerId("_${marker["title"]}kGooglrrePlex"),
        infoWindow: InfoWindow(
          title: marker["title"].toString(),
          snippet: "this is a snippet"
        ),
        // icon: BitmapDescriptor.fromBytes(customMarker, size: const Size(3, 3)),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(marker["lat"] as double, marker["lng"] as double),
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
                 )
              );
            }
          );
        }
      ));
    }
  }

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 17.151926040649414
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          _controller.complete(controller);
        },
      ),
    );
  }

  // ignore: unused_element
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}