import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greertings',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Greetings App'),
          backgroundColor: Colors.deepPurple  ,
        ),
        body: Builder(builder: (context) =>
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Hello world!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800]
                      )
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Discover the world',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepPurpleAccent
                      )
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Image.network(
                      'https://images.freeimages.com/images/large-previews/eaa/the-beach-1464354.jpg',
                      height: 320
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: RaisedButton(
                      child: Text('Contact Us'),
                      onPressed: () => contactUs(context),
                    )
                  ),
                ]
              )
            )
          )
        )
      )
    );
  }

  void contactUs(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context2) {
        return AlertDialog(
          title: Text('Contact Us'),
          content: Text('Mail us at hello@world.com'),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context2).pop(),
            )
          ],
        );
      }
    );
  }
}
