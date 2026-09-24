import 'package:calculadora_p_1/logic/calculadora_core.dart';

// para refactorizar el codigo para que haga operaciones encadenadas y no solo operaciones de 2 numeros necesitamos una funcion auxiliar
// que simplemente aplique las funciones de calculaora_core.dart
double ejecutarOperacionMatematica(double a, double b, String op) {
  switch (op) {
    case '+':
      return suma(a, b);
    case '-':
      return resta(a, b);
    case '*':
      return multiplicacion(a, b);
    case '÷':
      if (b == 0) return double.nan;
      return division(a, b);
    default:
      return b;
  }
}
