 import 'package:flutter/material.dart'; //importa la libreria de flutter que contiene todos los widgets
 //------------------------------------------------------------------------
  //haremos una función limpiar, como no es una función matematica no se coloca en calculadora_core.dart, sino aqui mismo en la clase
  //ya que aqui es donde tenemos acceso a las variables de estado que necesitamos para limpiar pantalla como _pantalla
  //funciona basicamente como una funcion que reinicia la calculadora por eso los valores los regresamos a uini estado inicial por eso
  //
  void limpiar(String pantalla, double? primerNumero, String operador, bool esperandoNuevoNumero, String historial) {
      //nosotros al poner setSate le decimos al framework que el estado interno del statefulwidget ha cambiado y que lo debe modificar (osea redibujar la pantalla) con
      //lo que se coloque dentro del setstate, en este caso las variables de estado
      pantalla = '0'; // regresa a 0 en la pantalla
      primerNumero = null; //lo ponemos en nulo para que no tenga valor
      operador = ''; //deja en blanco el operador
      esperandoNuevoNumero =
          false; //indica si el siguiente toque limpia la patalla o no
      historial = ''; //deja en blanco el historial
  }