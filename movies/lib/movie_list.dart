import 'package:flutter/material.dart';
import 'package:movies/http_helper.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  String result = '';
  HttpHelper helper;

  @override
  void initState() {
    helper = HttpHelper();
    // Move get upcoming here to prevent repeatedly rebuild UI.
    helper.getUpcoming().then((value) {
      setState(() {
        result = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies')
      ),
      body: Container(
        child: Text(result)
      ),
    );
  }
}