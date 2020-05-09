import 'package:flutter/material.dart';
import 'package:movies/http_helper.dart';
import 'package:movies/movie.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies')
      ),
      body: ListView.builder(
        itemCount: moviesCount == null ? 0 : moviesCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(movies[position].title),
              subtitle: Text('Released: ' + movies[position].releaseDate.toString() + ' - Vote: ' + movies[position].voteAverage.toString()),
            )
          );
        },
      )
    );
  }
}