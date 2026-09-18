import 'package:flutter/material.dart'; //importa la libreria de flutter que contiene todos los widgets
import '../widgets/botonBaseWidget.dart';
import '../logic/seleccionarOperacion.dart';
import 'package:calculadora_p_1/logic/limpiar.dart';
import 'package:calculadora_p_1/logic/presionarNumero.dart';
import '../logic/calcularResultado.dart';

// Método auxiliar para construir todas las filas de botones dinámicamente
  Widget construirTeclado(String pantalla, double? primerNumero, String operador, bool esperandoNuevoNumero, String historial) {
    return Column(
      children: [
        // Fila 1: C, ÷
        Expanded(
          child: Row(
            children: [
              construirBoton(
                texto: 'C',
                colorFondo: Colors.red[700],
                alPresionar: () => limpiar(pantalla, primerNumero, operador, esperandoNuevoNumero, historial),
              ),
              construirBoton(
                texto: '÷',
                colorFondo: Colors.orange[800],
                alPresionar: () => seleccionarOperacion('÷',pantalla, primerNumero, operador, esperandoNuevoNumero, historial ),
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
                alPresionar: () => presionarNumero('7',pantalla, esperandoNuevoNumero),
              ),
              construirBoton(
                texto: '8',
                alPresionar: () => presionarNumero('8',pantalla, esperandoNuevoNumero),
              ),
              construirBoton(
                texto: '9',
                alPresionar: () => presionarNumero('9',pantalla, esperandoNuevoNumero),
              ),
              construirBoton(
                texto: '×',
                colorFondo: Colors.orange[800],
                alPresionar: () => seleccionarOperacion('*',pantalla, primerNumero, operador, esperandoNuevoNumero, historial ),
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
                alPresionar: () => presionarNumero('4',pantalla, esperandoNuevoNumero),
              ),
              construirBoton(
                texto: '5',
                alPresionar: () => presionarNumero('5',pantalla, esperandoNuevoNumero),
              ),
              construirBoton(
                texto: '6',
                alPresionar: () => presionarNumero('6',pantalla, esperandoNuevoNumero),
              ),
              construirBoton(
                texto: '-',
                colorFondo: Colors.orange[800],
                alPresionar: () => seleccionarOperacion('-',pantalla, primerNumero, operador, esperandoNuevoNumero, historial ),
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
                alPresionar: () => presionarNumero('1',pantalla, esperandoNuevoNumero),
              ),
              construirBoton(
                texto: '2',
                alPresionar: () => presionarNumero('2',pantalla, esperandoNuevoNumero),
              ),
              construirBoton(
                texto: '3',
                alPresionar: () => presionarNumero('3',pantalla, esperandoNuevoNumero),
              ),
              construirBoton(
                texto: '+',
                colorFondo: Colors.orange[800],
                alPresionar: () => seleccionarOperacion('+',pantalla, primerNumero, operador, esperandoNuevoNumero, historial ),
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
                alPresionar: () => presionarNumero('0',pantalla, esperandoNuevoNumero),
              ),
              construirBoton(
                texto: '=',
                colorFondo: Colors.green[700],
                alPresionar: () => calcularResultado( primerNumero, operador, pantalla, esperandoNuevoNumero, historial),
              ),
            ],
          ),
        ),
      ],
    );
  }