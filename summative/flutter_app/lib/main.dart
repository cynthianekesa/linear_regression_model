import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(PredictionApp());
}

class PredictionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.teal[900]),
        ),
      ),
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WineWise'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome to WineWise! 🍷',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Enhance your wine expertise with WineWise. Our app provides accurate wine quality predictions, helping wine professionals make informed decisions. Whether you\'re assessing quality, producing, or testing, WineWise is your trusted tool.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PredictionPage()),
                    );
                  },
                  child: Text('Start predicting wine quality today!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final TextEditingController _fixedAcidityController = TextEditingController();
  final TextEditingController _volatileAcidityController = TextEditingController();
  final TextEditingController _residualSugarController = TextEditingController();
  final TextEditingController _chloridesController = TextEditingController();
  final TextEditingController _freeSO2Controller = TextEditingController();
  final TextEditingController _sulphatesController = TextEditingController();
  final TextEditingController _alcoholController = TextEditingController();
  final TextEditingController _colourController = TextEditingController();

  String _prediction = '';
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _makePrediction() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _prediction = '';
    });

    final fixedAcidity = _fixedAcidityController.text;
    final volatileAcidity = _volatileAcidityController.text;
    final residualSugar = _residualSugarController.text;
    final chlorides = _chloridesController.text;
    final freeSO2 = _freeSO2Controller.text;
    final sulphates = _sulphatesController.text;
    final alcohol = _alcoholController.text;
    final colour = _colourController.text;

    if (fixedAcidity.isEmpty || volatileAcidity.isEmpty || residualSugar.isEmpty || chlorides.isEmpty || freeSO2.isEmpty || sulphates.isEmpty || alcohol.isEmpty || colour.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Please enter all feature values';
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://linear-regression-model-11.onrender.com/predict'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'fixed_acidity': double.parse(fixedAcidity),
          'volatile_acidity': double.parse(volatileAcidity),
          'residual_sugar': double.parse(residualSugar),
          'chlorides': double.parse(chlorides),
          'free_SO2': double.parse(freeSO2),
          'sulphates': double.parse(sulphates),
          'alcohol': double.parse(alcohol),
          'colour': int.parse(colour),
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _prediction = jsonDecode(response.body)['predicted Quality'].toString();
        });
      } else {
        setState(() {
          _errorMessage = 'Error: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prediction App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _fixedAcidityController,
                decoration: InputDecoration(
                  labelText: 'Fixed Acidity',
                  filled: true,
                  fillColor: Colors.teal[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _volatileAcidityController,
                decoration: InputDecoration(
                  labelText: 'Volatile Acidity',
                  filled: true,
                  fillColor: Colors.teal[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _residualSugarController,
                decoration: InputDecoration(
                  labelText: 'Residual Sugar',
                  filled: true,
                  fillColor: Colors.teal[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _chloridesController,
                decoration: InputDecoration(
                  labelText: 'Chlorides',
                  filled: true,
                  fillColor: Colors.teal[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _freeSO2Controller,
                decoration: InputDecoration(
                  labelText: 'Free SO2',
                  filled: true,
                  fillColor: Colors.teal[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _sulphatesController,
                decoration: InputDecoration(
                  labelText: 'Sulphates',
                  filled: true,
                  fillColor: Colors.teal[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _alcoholController,
                decoration: InputDecoration(
                  labelText: 'Alcohol',
                  filled: true,
                  fillColor: Colors.teal[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _colourController,
                decoration: InputDecoration(
                  labelText: 'Colour',
                  filled: true,
                  fillColor: Colors.teal[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _makePrediction,
                child: _isLoading ? CircularProgressIndicator() : Text('Predict'),
              ),
              SizedBox(height: 20),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              if (_prediction.isNotEmpty)
                Text(
                  'Prediction: $_prediction',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
