//en este método se hace el calculo llamando a las funciones de logic en calculadora_core.dart
  import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:calculadora_p_1/logic/ejecutarOperacionMatematica.dart';

void calcularResultado(double? primerNumero, String operador, String pantalla, bool esperandoNuevoNumero, String historial) {
    if (primerNumero == null || operador.isEmpty) return; //si no hay primer numero o no hay operador, no se hace nada, validamos que
    //haya algo para que no de error al hacer las operaciones desde calculadora_core.dart

    double segundoNumero =
        double.tryParse(pantalla) ??
        0.0; //obtiene el valor actual en la pantalla
    double resultado = ejecutarOperacionMatematica(
      primerNumero!,
      segundoNumero,
      operador,
    );

    // 3. Actualizamos la pantalla con el resultado final
      if (resultado.isNaN) {
        // si en resultado nos arroja un indefinido o invalido con isNaN lo detectamos
        pantalla = 'Error';
        historial = '';
      } else {
        String segundoNumerotext = segundoNumero.toString().replaceAll(
          RegExp(r"([.]*0+)(?!.*\d)"),
          "",
        );
        historial = '$historial $segundoNumerotext ='; //concatenamos el resultado actual con el segundo numero y el historial que llevemos de operaciones encadenadas
        pantalla = (resultado % 1 == 0)
            ? resultado.toInt().toString()
            : resultado.toString(); // es un operador terniario que nos ayuda a mostrar el resultado sin decimales si es que no tiene
      }

      // Reiniciamos para que el siguiente número empiece cuenta nueva
      primerNumero = null;
      operador = '';
      esperandoNuevoNumero = true;
}