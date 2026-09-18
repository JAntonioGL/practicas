import 'package:flutter/material.dart'; //importa la libreria de flutter que contiene todos los widgets
import 'package:calculadora_p_1/widgets/construirPanelResultadosWidget.dart';
import 'package:calculadora_p_1/widgets/contruirTecladoWidget.dart';


// Vista original para cuando el teléfono está en vertical
Widget construirVistaVertical(String pantalla, double? primerNumero, String operador, bool esperandoNuevoNumero, String historial ) {
  return Column(
    children: [
      // Area superior: display (ocupa 2 partes del espacio)
      Expanded(
        flex: 2, //flex es un parametro que que sirve para definir la proporción de espacio que va a ocupar ese widget en comparación
        //con los demás elementos que están dentro de la misma, el 2 le dice a flutter que del espacio que hay tome 2 porciones
        child: construirPanelResultados(historial, pantalla),
      ),
      // Separador visual
      const Divider(color: Colors.blueGrey, height: 1),
      // Area inferior: teclado (ocupa 5 partes del espacio)
      Expanded(
        flex: 5,
        child: construirTeclado(pantalla, primerNumero, operador, esperandoNuevoNumero, historial),
      ),
      const SizedBox(height: 12), //siezedBox normalemnete se usa como separador o margen porque este es un contenedor con un tamaño fijo y exacto en Flutter
    ],
  );
}
