import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'package:prueba_login/vistas/login.dart';

void main() {
  runApp(
    // Envolvemos toda la app en un MultiProvider
    MultiProvider(
      providers: [
        // Aquí "nace" tu controlador y queda disponible para todos
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Login(),
    );
  }
}
