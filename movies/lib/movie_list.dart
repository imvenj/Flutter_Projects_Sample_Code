import 'package:flutter/material.dart';
import 'package:movies/http_helper.dart';
import 'package:movies/movie.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage = 'images.freeimages.com/images/large-previews/5eb/movie-clap board-1184339.jpg';
  String result = '';
  HttpHelper helper;
  int moviesCount;
  List movies;

  Future initialize() async {
    var movies = await helper.getUpcoming();
    setState(() {
      this.movies = movies;
      moviesCount = movies.length;
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies')
      ),
      body: ListView.builder(
        itemCount: moviesCount == null ? 0 : moviesCount,
        itemBuilder: (BuildContext context, int position) {
          if (movies[position].posterPath != null) {
            image = NetworkImage(iconBase + movies[position].posterPath);
          }
          else {
            image = NetworkImage(defaultImage);
          }
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(movies[position].title),
              subtitle: Text('Released: ' + movies[position].releaseDate.toString() + ' - Vote: ' + movies[position].voteAverage.toString()),
              leading: CircleAvatar(backgroundImage: image)
            )
          );
        },
      )
    );
  }
}