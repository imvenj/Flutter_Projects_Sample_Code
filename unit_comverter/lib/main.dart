import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measure Converter',
      home: Home()
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  double _numberForm;
  String _startMeasure;

  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces'
  ];

  @override
  void initState() {
    _numberForm = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Measure Converter')
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              DropdownButton(
                value: _startMeasure,
                items: _measures.map((value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value)
                )).toList(),
                onChanged: (value) => setState(() => _startMeasure = value),
              ),
              TextField(
                onChanged: (text) {
                  var rv = double.tryParse(text);
                  if (rv != null) {
                    setState(() {
                      _numberForm = rv;
                    });
                  }
                },
              ),
              Text(
                'Result: ${(_numberForm == null) ? '' : _numberForm.toString()}'
              )
            ]
          )
          
        )
      );
  }
}
