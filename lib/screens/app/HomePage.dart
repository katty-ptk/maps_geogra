// ignore_for_file: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      "lng": 21.1815705
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
    zoom: 10,
  );  

  @override
  void initState() {
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
                top: Radius.circular(30)
              )
            ),
            builder: (BuildContext context ) {
              return DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.4,
                minChildSize: 0.32,
                maxChildSize: 0.9,
                builder:(context, scrollController) =>
                 SingleChildScrollView(
                  controller: scrollController,
                  child: Center(
                    child: ElevatedButton(
                      child: const Text("close"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              );
            }
          );
        }
      ));
    }

    super.initState();
  }

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414
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