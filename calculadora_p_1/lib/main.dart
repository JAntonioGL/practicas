import 'package:flutter/material.dart';

import 'screens/calculadora_screen.dart';

import 'package:provider/provider.dart';

import 'package:calculadora_p_1/providers/calculadora_provider.dart';

void main() {
  // Envolvemos la app para que la instancia viva globalmente
  runApp(
    ChangeNotifierProvider(
      create: (context) => CalculadoraProvider(),
      child: const MiCalculadoraApp(),
    ),
  );
}

class MiCalculadoraApp extends StatelessWidget {
  const MiCalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculadoraScreen(),
    );
  }
}
