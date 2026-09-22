import 'package:flutter/material.dart';

import 'screens/calculadora_screen.dart';

import 'package:provider/provider.dart';

import 'package:calculadora_p_1/providers/calculadora_provider.dart';

import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //inicializamos el windows_manager
  await windowManager.ensureInitialized();

  //configurar las opciones de las ventanas
  WindowOptions windowOptions = const WindowOptions(
    size: Size(400, 600),
    minimumSize: Size(400, 600),
    center: true,
    title: 'Calculadora',
  );
  // Aplica la configuración y muestra la ventana
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();//hace visible la ventana 
    await windowManager.focus(); //con focus trae la ventana al frente de todas las demas aplicaciones. 
  });
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
