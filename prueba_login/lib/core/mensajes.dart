import 'package:flutter/material.dart';

class Mensajes {
  // Constructor privado: nadie debe hacer Mensajes(), solo usar Mensajes.algo
  Mensajes._();
  static const campoRequerido = 'Este campo es obligatorio';
  static const emailInvalido = 'Escribe un correo válido';
  static const passwordInvalido =
      'La contraseña debe tener al menos 6 caracteres'; //queda pendiente el numero de caracteres
  static const passwordRequerido = 'La contraseña es obligatoria';
  static const nombreInvalido = 'El nombre debe tener al menos 3 caracteres';
}
