import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oceane\'s Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onPressed(String text) {
    setState(() {
      if (text == 'C') {
        _expression = '';
        _result = '';
      } else if (text == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(_expression);
          ContextModel cm = ContextModel();
          _result = exp.evaluate(EvaluationType.REAL, cm).toString();
        } catch (e) {
          _result = 'Error';
        }
      } else if (text == 'x²') {
        try {
          double value = double.parse(_expression);
          _result = (value * value).toString();
        } catch (e) {
          _result = 'Error';
        }
      } else if (text == '%') {
        _expression += '%';
      } else {
        _expression += text;
      }
    });
  }

  Widget _buildButton(String text, Color color) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onPressed(text),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(24.0),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oceane\'s Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: TextStyle(fontSize: 32.0, color: Colors.black54),
                  ),
                  Text(
                    _result,
                    style: TextStyle(fontSize: 48.0, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              _buildButton('7', Colors.grey),
              _buildButton('8', Colors.grey),
              _buildButton('9', Colors.grey),
              _buildButton('/', Colors.grey),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('4', Colors.grey),
              _buildButton('5', Colors.grey),
              _buildButton('6', Colors.grey),
              _buildButton('*', Colors.blue),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('1', Colors.grey),
              _buildButton('2', Colors.grey),
              _buildButton('3', Colors.grey),
              _buildButton('-', Colors.blue),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('0', Colors.grey),
              _buildButton('C', Colors.red),
              _buildButton('=', Colors.green),
              _buildButton('+', Colors.blue),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('x²', Colors.orange), // Square button
              _buildButton('%', Colors.orange), // Modulo button
            ],
          ),
        ],
      ),
    );
  }
}
