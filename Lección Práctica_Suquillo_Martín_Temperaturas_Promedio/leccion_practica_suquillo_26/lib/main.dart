import 'package:flutter/material.dart';
import 'ui/interfaz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Promedio de Temperaturas',
      home: Interfaz(),
    );
  }
}
