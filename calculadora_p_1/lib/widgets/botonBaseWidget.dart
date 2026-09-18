import 'package:flutter/material.dart'; //importa la libreria de flutter que contiene todos los widgets

 
 // Método auxiliar para crear un botón responsivo sin medidas fijas que rompan la interfaz
  Widget construirBoton({
    required String texto,
    Color? colorFondo,
    Color colorTexto = Colors.white,
    required VoidCallback alPresionar,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorFondo ?? Colors.grey[850],
            // SE ELIMINÓ EL PADDING VERTICAL FIJO PARA EVITAR OVERFLOW Y HACERLO RESPONSIVO
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: alPresionar,
          child: FittedBox(
            // FittedBox asegura que el texto no se desborde si el botón se hace muy pequeño
            fit: BoxFit.scaleDown,
            child: Text(
              texto,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorTexto,
              ),
            ),
          ),
        ),
      ),
    );
  }
