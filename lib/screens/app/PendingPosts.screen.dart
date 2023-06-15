import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:maps_geogra/utils/navigation.utils.dart';
import 'package:maps_geogra/utils/routes.utils.dart';
import 'package:maps_geogra/widgets/pending_place_card.widget.dart';
import 'package:http/http.dart' as http;
import '../../utils/api_paths.utils.dart';

class PendingPlacesScreen extends StatefulWidget {
  const PendingPlacesScreen({super.key});

  @override
  State<PendingPlacesScreen> createState() => _PendingPlacesScreenState();
}

class _PendingPlacesScreenState extends State<PendingPlacesScreen> {
  Future<dynamic>  fetchPendingPlaces() async {
    var response = await http.get(Uri.parse(Paths().BASE_URL + Paths().PENDING_PLACES));
    var decodedResponse = json.decode(response.body.toString());

    return decodedResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Places pending for Approval"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => NavigationUtil().navigateTo(context, Routes().HOME_SCREEN),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder(
        future: fetchPendingPlaces(),
        builder: (context, snapshot) {
          if ( snapshot.connectionState == ConnectionState.waiting ){
            return const Center(child: CircularProgressIndicator());
          } else if ( snapshot.hasData ) {

            List<dynamic> data = snapshot.data;

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for ( var place in data ) 
                      addCard(place["_id"], place["title"], place["senderEmail"] ?? "katytest@gmail.com")
                  ]
                ),
              ),
            );
          }

          return Container();
        },
      )
    );
  }

  Widget addCard( String placeID, String placeTitle, String placeSenderEmail ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: PendingPlaceCard(placeID: placeID, title: placeTitle, senderEmail: placeSenderEmail))
      ],
    );
  }
}