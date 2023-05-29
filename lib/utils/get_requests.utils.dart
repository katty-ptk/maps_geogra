import 'package:http/http.dart' as http;
import 'package:maps_geogra/utils/paths.utils.dart';

class GetReq {
  var client = http.Client();
  
  Future<dynamic> getAllPlaces() async {
    var url = Uri.parse( Paths().BASE_URL + Paths().ALL_PLACES );
    
    var response = await client.get(url);

    if ( response.statusCode != 200 ) {
      // show error snackbar
      return "COULD NOT RETRIEVE PLACES :(";
    }

    return response.body; 
  }
}