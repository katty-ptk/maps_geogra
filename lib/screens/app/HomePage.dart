// ignore_for_file: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:typed_data';

import 'package:network_image_to_byte/network_image_to_byte.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_collection_literals
  Set<Marker> markers = Set();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(46.4298523, 21.8240082),
    zoom: 10,
  );  

  @override
  void initState() {
    addMarkers(const LatLng(46.1853782, 21.3114286), "Tucano");
    super.initState();
  }


  addMarkers(LatLng latLng, String title) async {
      final Uint8List customMarker = await networkImageToByte("https://static.thenounproject.com/png/2120976-200.png");

      markers.add(Marker(
        markerId: MarkerId("_${title}kGooglrrePlex"),
        infoWindow: InfoWindow(
          title: title,
          snippet: "this is a snippet"
        ),
        icon: BitmapDescriptor.fromBytes(customMarker, size: const Size(3, 3)),
        position: latLng,
        onTap: () {
          
        }
      ));

      // timisoara
      markers.add(Marker(
        markerId: MarkerId("_${title}kGoroglePlex"),
        infoWindow: const InfoWindow(
          title: "Timisoara",
          snippet: "this is a snippet"
        ),
        icon: BitmapDescriptor.fromBytes(customMarker),
        position: const LatLng(45.7411191, 21.1815705),
        onTap: () {
          
        }
      ));

      // oradea
      markers.add(Marker(
        markerId: MarkerId("_${title}kffGooglePlex"),
        infoWindow: const InfoWindow(
          title: "Oradea",
          snippet: "this is a snippet"
        ),
        icon: BitmapDescriptor.fromBytes(customMarker),
        position: const LatLng(47.0746904, 21.867405),
        onTap: () {
          
        }
      ));


      // oradea
      markers.add(Marker(
        markerId: MarkerId("_${title}adkGooglePlex"),
        infoWindow: const InfoWindow(
          title: "Bucuresti",
          snippet: "this is a snippet"
        ),
        icon: BitmapDescriptor.fromBytes(customMarker, size: const Size(0, 0)),
        position: const LatLng(44.4379269, 26.0245983),
        onTap: () {
          
        }
      ));

      setState(() {
        // this "resets" the state
      });
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