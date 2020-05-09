import 'package:http/http.dart' as http;
import 'dart:io';

class HttpHelper {
  final String urlKey = 'api_key=bec6e93771cfe9954ce7a6f7f807cf36';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcomming = '/upcoming?';
  final String urlLanguage = '&language=en-US';


  Future<String> getUpcoming() async {
    final String upcomming = urlBase + urlUpcomming + urlKey + urlLanguage;
    print('upcomming url: ' + upcomming);
    http.Response result = await http.get(upcomming);
    if (result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      return responseBody;
    }
    else {
      return null;
    }
  }
}
