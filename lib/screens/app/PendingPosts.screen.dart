import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:maps_geogra/utils/state_manager.utils.dart';
import 'package:maps_geogra/widgets/pending_place_card.widget.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../utils/api_paths.utils.dart';

class PendingPlacesScreen extends StatefulWidget {
  const PendingPlacesScreen({super.key});

  @override
  State<PendingPlacesScreen> createState() => _PendingPlacesScreenState();
}

class _PendingPlacesScreenState extends State<PendingPlacesScreen> {
  String _userEmail = "";

  @override
  void initState() {
    _userEmail = context.read<StateManager>().USER_EMAIL;

    super.initState();
  }

  Future<dynamic>  fetchPendingPlaces() async {
    var response = await http.get(Uri.parse(Paths().BASE_URL + Paths().PENDING_PLACES));
    var decodedResponse = json.decode(response.body.toString());

    return decodedResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchPendingPlaces(),
        builder: (context, snapshot) {
          if ( snapshot.connectionState == ConnectionState.waiting ){
            return const Center(child: CircularProgressIndicator());
          } else if ( snapshot.hasData ) {

            List<dynamic> data = snapshot.data;

            return addCards(data);
          }

          return Container();
        },
      )
    );
  }

  Widget addCards( List<dynamic> places ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(child: PendingPlaceCard()),
      ],
    );
  }
}