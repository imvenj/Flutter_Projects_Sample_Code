import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:movies/movie.dart';

class HttpHelper {
  final String urlKey = 'api_key=bec6e93771cfe9954ce7a6f7f807cf36';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcomming = '/upcoming?';
  final String urlLanguage = '&language=en-US';


  Future<List> getUpcoming() async {
    final String upcomming = urlBase + urlUpcomming + urlKey + urlLanguage;
    print('upcomming url: ' + upcomming);
    http.Response result = await http.get(upcomming);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      var movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    }
    else {
      return null;
    }
  }
}
