import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PantallaCalculadora(),
    );
  }
}

class PantallaCalculadora extends StatefulWidget {
  const PantallaCalculadora({super.key});

  @override
  _PantallaCalculadoraState createState() => _PantallaCalculadoraState();
}

class _PantallaCalculadoraState extends State<PantallaCalculadora> {
  String _output = "0";
  String _entradaActual = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operacion = "";
  bool _esperandoSegundoNumero = false;

  void _botonPresionado(String textoBoton) {
    setState(() {
      if (textoBoton == "C") {
        _output = "0";
        _entradaActual = "";
        _num1 = 0;
        _num2 = 0;
        _operacion = "";
        _esperandoSegundoNumero = false;
      } else if (textoBoton == "+" || textoBoton == "-" || textoBoton == "×" || textoBoton == "÷" || textoBoton == "x^y") {
        if (_entradaActual.isNotEmpty) {
          _num1 = double.parse(_entradaActual);
          _operacion = textoBoton;
          _esperandoSegundoNumero = true;
          _entradaActual = "";
          _output = _output + " " + _operacion;
        }
      } else if (textoBoton == ".") {
        if (!_entradaActual.contains(".")) {
          _entradaActual += textoBoton;
          _output = _entradaActual;
        }
      } else if (textoBoton == "=") {
        if (_operacion.isNotEmpty && _entradaActual.isNotEmpty) {
          _num2 = double.parse(_entradaActual);
          switch (_operacion) {
            case "+":
              _entradaActual = (_num1 + _num2).toString();
              break;
            case "-":
              _entradaActual = (_num1 - _num2).toString();
              break;
            case "×":
              _entradaActual = (_num1 * _num2).toString();
              break;
            case "÷":
              _entradaActual = (_num1 / _num2).toString();
              break;
            case "x^y": 
              _entradaActual = pow(_num1, _num2).toString(); 
              break;
          }
          _operacion = "";
          _num1 = 0;
          _num2 = 0;
          _esperandoSegundoNumero = false;
          _output = _entradaActual;
        }
      } else if (textoBoton == "√x") {
        if (_entradaActual.isNotEmpty) {
          _num1 = double.parse(_entradaActual);
          _entradaActual = sqrt(_num1).toString();
          _output = _entradaActual;
        }
      } else if (textoBoton == "ln") {
        if (_entradaActual.isNotEmpty) {
          _num1 = double.parse(_entradaActual);
          _entradaActual = log(_num1).toString(); 
          _output = _entradaActual;
        }
      } else if (textoBoton == "sen") {
        if (_entradaActual.isNotEmpty) {
          _num1 = double.parse(_entradaActual);
          _entradaActual = sin(_num1).toString();
          _output = _entradaActual;
        }
      } else if (textoBoton == "cos") {
        if (_entradaActual.isNotEmpty) {
          _num1 = double.parse(_entradaActual);
          _entradaActual = cos(_num1).toString();
          _output = _entradaActual;
        }
      } else if (textoBoton == "tan") {
        if (_entradaActual.isNotEmpty) {
          _num1 = double.parse(_entradaActual);
          _entradaActual = tan(_num1).toString();
          _output = _entradaActual;
        }
      } else if (textoBoton == "arcsen") {
        if (_entradaActual.isNotEmpty) {
          _num1 = double.parse(_entradaActual);
          _entradaActual = asin(_num1).toString();
          _output = _entradaActual;
        }
      } else if (textoBoton == "arccos") {
        if (_entradaActual.isNotEmpty) {
          _num1 = double.parse(_entradaActual);
          _entradaActual = acos(_num1).toString();
          _output = _entradaActual;
        }
      } else if (textoBoton == "arctan") {
        if (_entradaActual.isNotEmpty) {
          _num1 = double.parse(_entradaActual);
          _entradaActual = atan(_num1).toString();
          _output = _entradaActual;
        }
      } else if (textoBoton == "n!") {
        if (_entradaActual.isNotEmpty) {
          int n = int.parse(_entradaActual);
          _entradaActual = _factorial(n).toString();
          _output = _entradaActual;
        }
      } else {
        if (_esperandoSegundoNumero) {
          _entradaActual = textoBoton;
          _esperandoSegundoNumero = false;
        } else {
          if (_entradaActual == "0") {
            _entradaActual = textoBoton;
          } else {
            _entradaActual += textoBoton;
          }
        }
        _output = _entradaActual;
      }
    });
  }

  int _factorial(int n) {
    if (n <= 1) return 1;
    return n * _factorial(n - 1);
  }

  Widget _buildButton(String textoBoton, {Color? color, Color? textColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[300],
            foregroundColor: textColor ?? Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(24.0),
          ),
          onPressed: () => _botonPresionado(textoBoton),
          child: Text(
            textoBoton,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
            child: Text(
              _output,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("÷", color: const Color.fromARGB(255, 255, 255, 255), textColor: Colors.black),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("×", color: const Color.fromARGB(255, 255, 255, 255), textColor: Colors.black),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("-", color: const Color.fromARGB(255, 255, 255, 255), textColor: Colors.black),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("."),
                    _buildButton("0"),
                    _buildButton("C"),
                    _buildButton("+", color: const Color.fromARGB(255, 255, 255, 255), textColor: Colors.black),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("x^y", color: const Color.fromARGB(255, 255, 255, 255)),
                    _buildButton("√x", color: const Color.fromARGB(255, 255, 255, 255)),
                    _buildButton("ln", color: const Color.fromARGB(255, 255, 255, 255)),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("sen", color: const Color.fromARGB(255, 255, 255, 255)),
                    _buildButton("cos", color: const Color.fromARGB(255, 255, 255, 255)),
                    _buildButton("tan", color: const Color.fromARGB(255, 255, 255, 255)),
                    _buildButton("arcsen", color: const Color.fromARGB(255, 255, 255, 255)),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("arccos", color: const Color.fromARGB(255, 255, 255, 255)),
                    _buildButton("arctan", color: const Color.fromARGB(255, 255, 255, 255)),
                    _buildButton("n!", color: const Color.fromARGB(255, 255, 255, 255)),
                    _buildButton("=", color: const Color.fromARGB(255, 58, 216, 92), textColor: Colors.white),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}