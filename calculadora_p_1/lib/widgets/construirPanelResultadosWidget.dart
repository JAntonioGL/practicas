import 'package:flutter/material.dart'; //importa la libreria de flutter que contiene todos los widgets
//import '../widgets/botonBaseWidget.dart';
import 'package:provider/provider.dart';
import 'package:calculadora_p_1/providers/calculadora_provider.dart';

// Método auxiliar para construir todas las filas de botones dinámicamente
// Método auxiliar para construir la pantalla de resultados y el historial
Widget construirPanelResultados(BuildContext context) {
  // 1. Te conectas al provider y "observas" los cambios
  final provider = context.watch<CalculadoraProvider>(); // con esta variable provider estamos diciendo que  va a  LEER y ESCUCHAR. para eso es context.watch
  return Container(
    alignment: Alignment.bottomRight,
    padding: const EdgeInsets.all(24.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: SingleChildScrollView(
            reverse: true, // Para que siempre se vea lo último del historial
            child: Text(
              provider.historial,
              style: const TextStyle(fontSize: 24, color: Colors.grey),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        const SizedBox(height: 8), // es un contenedor de tamaño fijo pero vacio y se usa como separador o margen
        Text(
          provider.pantalla,
          style: const TextStyle(
            fontSize: 48,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
      ],
    ),
  );
}
