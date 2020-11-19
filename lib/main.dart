import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Currency Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String convertedSum = '';

  String _convertAmount(String amount) {
    final double x = double.parse(convertedSum);
    final double amountInLei = x * 4.87;
    return amountInLei.toString();
  }

  String _validateInput(String value) {
    if (value.isEmpty) {
      convertedSum = '';
      return 'Please enter the amount';
    } else {
      try {
        double.parse(value);
      } on FormatException {
        convertedSum = '';
        return 'Please enter an valid amount';
      }
      convertedSum = value;
      return null;
    }
  }

  void _initializeAmount() {
    if (_formKey.currentState.validate()) {
      setState(() {
        convertedSum = _convertAmount(convertedSum);
      });
    } else {
      setState(() {
        convertedSum = '';
      });
    }
  }

  Text _setTextBasedOnAmount() {
    if (convertedSum == '' || convertedSum == null) {
      return const Text('');
    } else {
      return Text(convertedSum + ' Lei');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/currency_converter.jpg',
                width: 400,
                height: 210,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'enter the amount in EUR',
                  suffixIcon: Icon(Icons.euro),
                ),
                keyboardType: TextInputType.number,
                validator: (String value) {
                  return _validateInput(value);
                },
              ),
              RaisedButton(
                onPressed: () {
                  _initializeAmount();
                },
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text('Convert'),
              ),
              _setTextBasedOnAmount(),
            ],
          ),
        ),
      ),
    );
  }
}
