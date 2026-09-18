import 'package:flutter/material.dart'; //importa la libreria de flutter que contiene todos los widgets
import 'package:calculadora_p_1/widgets/construirPanelResultadosWidget.dart';
import 'package:calculadora_p_1/widgets/contruirTecladoWidget.dart';

// Nueva vista para cuando el teléfono está en horizontal (acostado)
Widget construirVistaHorizontal(String pantalla, double? primerNumero, String operador, bool esperandoNuevoNumero, String historial) {
  return Row(
    children: [
      // Panel izquierdo: Historial y resultado (ocupa la mitad de la pantalla)
      Expanded(flex: 1, child: construirPanelResultados(historial, pantalla)),
      // Separador vertical
      const VerticalDivider(color: Colors.blueGrey, width: 1),
      // Panel derecho: Teclado (ocupa la otra mitad)
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
          child: construirTeclado(pantalla, primerNumero, operador, esperandoNuevoNumero, historial),
        ),
      ),
    ],
  );
}
