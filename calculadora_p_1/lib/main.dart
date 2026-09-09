import 'package:flutter/material.dart';

import 'screens/calculadora_screen.dart';

void main() {
  runApp(const MiCalculadoraApp());
}

class MiCalculadoraApp extends StatelessWidget {
  const MiCalculadoraApp({super.key});

  @override
  Widget build(BuildContext) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: calculadora_screen(),
    );
  }
}
