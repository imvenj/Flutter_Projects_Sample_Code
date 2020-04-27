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
  String _convertedMeasure;
  String _resultMessage;

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

  final TextStyle inputStyle = TextStyle(
    fontSize: 20,
    color: Colors.blue[900]
  );

  final TextStyle labelStyle = TextStyle(
    fontSize: 24,
    color: Colors.grey[700],
  );

  final double verticalSpacing = 10;

  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3,28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1000, 1, 0, 0, 2,20462, 0.35274],
    '3': [0, 0, 1000, 0, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60394, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1]
  };

  void convert(double value, String from, String to) {
    int nFrom = _measuresMap[from];
    int nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;
    String resultMessage;
    if (result == 0) {
      resultMessage = 'This conversion connot be performed';
    }
    else {
      resultMessage = '${_numberForm.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure';
    }
    setState(() => _resultMessage = resultMessage);
  }

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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: verticalSpacing),
                child: Text(
                  'Value',
                  style: labelStyle
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: verticalSpacing),
                child: TextField(
                  style: inputStyle,
                  decoration: InputDecoration(
                    hintText: 'Please insert the measure to be converted'
                  ),
                  onChanged: (text) {
                    var rv = double.tryParse(text);
                    if (rv != null) {
                      setState(() {
                        _numberForm = rv;
                      });
                    }
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: verticalSpacing),
                child: Text(
                  'From',
                  style: labelStyle
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: verticalSpacing),
                child: DropdownButton(
                  isExpanded: true,
                  value: _startMeasure,
                  items: _measures.map((value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: inputStyle
                    )
                  )).toList(),
                  onChanged: (value) => setState(() => _startMeasure = value),
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: verticalSpacing),
                child: Text(
                  'To',
                  style: labelStyle
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: verticalSpacing),
                child: DropdownButton(
                  isExpanded: true,
                  value: _convertedMeasure,
                  items: _measures.map((value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: inputStyle
                    )
                  )).toList(),
                  onChanged: (value) => setState(() => _convertedMeasure = value),
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: verticalSpacing),
                child: RaisedButton(
                  child: Text(
                    'Convert',
                    style: inputStyle,
                  ),
                  onPressed: () {
                    if (_startMeasure.isEmpty || _convertedMeasure.isEmpty || _numberForm == 0) {
                      return;
                    }
                    else {
                      convert(_numberForm, _startMeasure, _convertedMeasure);
                    }
                  }
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: verticalSpacing),
                child: Text(
                  (_resultMessage == null) ? '' : _resultMessage.toString(),
                  style: labelStyle
                )
              ),
            ]
          )
        )
      )
    );
  }
}
