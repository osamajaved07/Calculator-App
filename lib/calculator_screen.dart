// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, unnecessary_null_comparison, prefer_const_constructors, unused_element

import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  
  String _input = '';
  String _output = '';
  late double _inputValue = 0;
  String? _operation;
  bool _isDecimal = false;
  




  void _onDigitPress(String digit) {
    
    setState(() {
      _input += digit;
    });
  }

  void _onDecimalPress() {
    if (!_isDecimal) {
      setState(() {
        _input += '.';
        _isDecimal = true;
      });
    }
  }

  void _onOperatorPress(String operator) {
    if (_input.isEmpty) return;

    if (_operation != null) {
      _onEqualPress();
    } else {
      _inputValue = double.parse(_input);
      _input = '';
    }

    setState(() {
      _operation = operator;
      _isDecimal = false;
    });
  }

  void _onEqualPress() {
    if (_input.isEmpty || _operation == null) return;

    double secondOperand = double.parse(_input);
    double result = 0;

    switch (_operation) {
      case '+':
        result = _inputValue + secondOperand;
        break;
      case '-':
        result = _inputValue - secondOperand;
        break;
      case 'x':
        result = _inputValue * secondOperand;
        break;
      case '÷':
        if (secondOperand == 0) {
          _output = 'Error';
          return;
        }
        result = _inputValue / secondOperand;
        break;
    }

    setState(() {
      _input = '';
      _inputValue = result;
      _operation = null;
      _output = result.toString();
      _isDecimal = result % 1 != 0;
    });
  }

  void _onClearPress() {
    setState(() {
      _input = '';
      _output = '';
      _inputValue = 0.0;
      _operation = null;
      _isDecimal = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 232, 247),
      appBar: AppBar(
        
        elevation: 2,
        centerTitle: true,
        title: Text('CALCULATOR', style: TextStyle(fontWeight: FontWeight.w500),),
        backgroundColor:  Color.fromARGB(255, 211, 232, 247),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    _inputValue != null ? _inputValue.toString() : _input,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _output,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 0),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildOperatorButton('÷'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildOperatorButton('×'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildOperatorButton('-'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('0'),
                  _buildButton('.'),
                  _buildOperatorButton('+'),
                  _buildEqualButton(),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: <Widget>[
              _buildClearButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: InkWell(
        onTap: () => _onDigitPress(text),
        child: Container(
          alignment: Alignment.center,
          height: 80,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOperatorButton(String text) {
    return Expanded(
      child: InkWell(
        onTap: () => _onOperatorPress(text),
        child: Container(
          alignment: Alignment.center,
          height: 80,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEqualButton() {
    return Expanded(
      child: InkWell(
        onTap: _onEqualPress,
        child: Container(
          alignment: Alignment.center,
          height: 80,
          child: Text(
            '=',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return Expanded(
      child: InkWell(
        onTap: _onClearPress,
        child: Container(
          alignment: Alignment.center,
          height: 80,
          child: Text(
            'C',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
