import 'package:flutter/material.dart'; //importa la libreria de flutter que contiene todos los widgets

import '../widgets/botonBaseWidget.dart';

import 'package:calculadora_p_1/providers/calculadora_provider.dart';
import 'package:provider/provider.dart';

// Método auxiliar para construir todas las filas de botones dinámicamente
Widget construirTeclado(BuildContext context) {
  // 1. Te conectas al provider y "observas" los cambios
  return Column(
    children: [
      // Fila 1: C, ÷
      Expanded(
        child: Row(
          children: [
            construirBoton(
              texto: 'C',
              colorFondo: Colors.red[700],
              alPresionar: () => context.read<CalculadoraProvider>().limpiar(), //al colocar el context. read le decimo0s que se va a EJECUTAR UNA ACCIÓN.
            ),
            construirBoton(
              texto: '÷',
              colorFondo: Colors.orange[800],
              alPresionar: () =>
                  context.read<CalculadoraProvider>().seleccionarOperacion('÷'),
            ),
          ],
        ),
      ),
      // Fila 2: 7, 8, 9, ×
      Expanded(
        child: Row(
          children: [
            construirBoton(
              texto: '7',
              alPresionar: () =>
                  context.read<CalculadoraProvider>().presionarNumero('7'),
            ),
            construirBoton(
              texto: '8',
              alPresionar: () =>
                  context.read<CalculadoraProvider>().presionarNumero('8'),
            ),
            construirBoton(
              texto: '9',
              alPresionar: () =>
                  context.read<CalculadoraProvider>().presionarNumero('9'),
            ),
            construirBoton(
              texto: '×',
              colorFondo: Colors.orange[800],
              alPresionar: () =>
                  context.read<CalculadoraProvider>().seleccionarOperacion('*'),
            ),
          ],
        ),
      ),
      // Fila 3: 4, 5, 6, -
      Expanded(
        child: Row(
          children: [
            construirBoton(
              texto: '4',
              alPresionar: () =>
                  context.read<CalculadoraProvider>().presionarNumero('4'),
            ),
            construirBoton(
              texto: '5',
              alPresionar: () =>
                  context.read<CalculadoraProvider>().presionarNumero('5'),
            ),
            construirBoton(
              texto: '6',
              alPresionar: () =>
                  context.read<CalculadoraProvider>().presionarNumero('6'),
            ),
            construirBoton(
              texto: '-',
              colorFondo: Colors.orange[800],
              alPresionar: () =>
                  context.read<CalculadoraProvider>().seleccionarOperacion('-'),
            ),
          ],
        ),
      ),
      // Fila 4: 1, 2, 3, +
      Expanded(
        child: Row(
          children: [
            construirBoton(
              texto: '1',
              alPresionar: () =>
                  context.read<CalculadoraProvider>().presionarNumero('1'),
            ),
            construirBoton(
              texto: '2',
              alPresionar: () =>
                  context.read<CalculadoraProvider>().presionarNumero('2'),
            ),
            construirBoton(
              texto: '3',
              alPresionar: () =>
                  context.read<CalculadoraProvider>().presionarNumero('3'),
            ),
            construirBoton(
              texto: '+',
              colorFondo: Colors.orange[800],
              alPresionar: () =>
                  context.read<CalculadoraProvider>().seleccionarOperacion('+'),
            ),
          ],
        ),
      ),
      // Fila 5: 0, =
      Expanded(
        child: Row(
          children: [
            construirBoton(
              texto: '0',
              alPresionar: () =>
                  context.read<CalculadoraProvider>().presionarNumero('0'),
            ),
            construirBoton(
              texto: '=',
              colorFondo: Colors.green[700],
              alPresionar: () =>
                  context.read<CalculadoraProvider>().calcularResultado(),
            ),
          ],
        ),
      ),
    ],
  );
}
