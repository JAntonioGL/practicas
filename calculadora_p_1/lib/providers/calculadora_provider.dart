import 'package:flutter/material.dart';

//import '../logic/calculadora_core.dart';

import '../logic/ejecutarOperacionMatematica.dart';

class CalculadoraProvider extends ChangeNotifier {
  //ChangeNotifier se basa en un patrón de diseño de software llamado Patrón Observador (Observer Pattern)
  //es una clase que extiende de ChangeNotifier, lo que nos permite notificar a los widgets que estén escuchando
  // 1. Aquí pones todas tus variables de estado (privadas)
  String _pantalla = '0';
  String _historial = '';
  double? _primerNumero;
  String _operador = '';
  bool _esperandoNuevoNumero = true;

  String get pantalla =>
      _pantalla; // Getter público para que los widgets lean el valor
  String get historial => _historial;
  double? get primerNumero => _primerNumero;
  String get operador => _operador;
  bool get esperandoNuevoNumero => _esperandoNuevoNumero;
  //un get es como si fuera una variable que se puede leer pero no se puede modificar desde fuera
  //esto quiere decir que solo se puede modificar desde aqui mismo

  // 3. Traes todos tus métodos aquí adentro (presionarNumero, seleccionarOperacion, etc.)
  //esta función nos va  ayudar a capturar los digitos que precionamos, sean del 1 al 9
  void presionarNumero(String digito) {
    // Si la pantalla tiene '0' o acabamos de tocar un operador, reemplazamos el texto
    if (_pantalla == '0' || _esperandoNuevoNumero) {
      //cuando presionamos el boton de operador se llama a la función de _seleccionarOperador y
      //ahi se va a cambiar el estado de la variable _esperandoNuevoNumero a true para que al presionar un numero se reemplace el texto en lugar de concatenar
      //asi funciona en una calculadora real, primero precionas un numero, luego el operador y luego otro numero para realizar la operacion
      //es decir, si pantalla es '0' y precionamos '5', se reemplaza el cero por el cinco, si pantalla es '5' y precionamos '+', se guarda el cinco y se reinicia la pantalla a '0'
      //si despues de precionar '+' precionamos '3', se reemplaza el cero por el tres y se guarda el tres, si precionamos '=', se realiza la operacion '5 + 3' y se muestra el resultado '8'
      _pantalla = digito; //se reemplaza el cero por el digito precionado, si la varible esperandoNuevoNumero es true se reemplaza el texto
      _esperandoNuevoNumero = false; //y como ya se preciono el primer numero de esta operacion, se cambia el valor del booleano a false
    } else {
      // Si ya hay números escritos, concatenamos el nuevo dígito al final
      _pantalla = _pantalla + digito; //si no es cero y no se ha precionado un operador, se concatena el digito al texto que ya se tiene en pantalla
    }
    notifyListeners(); //notifica a los widgets que estén escuchando que el estado ha cambiado
  }

  void limpiar() {
    //nosotros al poner setSate le decimos al framework que el estado interno del statefulwidget ha cambiado y que lo debe modificar (osea redibujar la pantalla) con
    //lo que se coloque dentro del setstate, en este caso las variables de estado
    _pantalla = '0'; // regresa a 0 en la pantalla
    _primerNumero = null; //lo ponemos en nulo para que no tenga valor
    _operador = ''; //deja en blanco el operador
    _esperandoNuevoNumero =
        false; //indica si el siguiente toque limpia la patalla o no
    _historial = ''; //deja en blanco el historial

    notifyListeners();
  }

  void calcularResultado() {
    if (_primerNumero == null || _operador.isEmpty) return; //si no hay primer numero o no hay operador, no se hace nada, validamos que
    //haya algo para que no de error al hacer las operaciones desde calculadora_core.dart

    double segundoNumero =
        double.tryParse(_pantalla) ??
        0.0; //obtiene el valor actual en la pantalla
    double resultado = ejecutarOperacionMatematica(
      _primerNumero!,
      segundoNumero,
      _operador,
    );

    // 3. Actualizamos la pantalla con el resultado final
    if (resultado.isNaN) {
      // si en resultado nos arroja un indefinido o invalido con isNaN lo detectamos
      _pantalla = 'Error';
      _historial = '';
    } else {
      String segundoNumerotext = segundoNumero.toString().replaceAll(
        RegExp(r"([.]*0+)(?!.*\d)"),
        "",
      );
      _historial = '$_historial $segundoNumerotext ='; //concatenamos el resultado actual con el segundo numero y el historial que llevemos de operaciones encadenadas
      _pantalla = (resultado % 1 == 0)
          ? resultado.toInt().toString()
          : resultado.toString(); // es un operador terniario que nos ayuda a mostrar el resultado sin decimales si es que no tiene
    }

    // Reiniciamos para que el siguiente número empiece cuenta nueva
    _primerNumero = null;
    _operador = '';
    _esperandoNuevoNumero = true;
    notifyListeners();
  }

  void seleccionarOperacion(String op) {
    //en un futuro podemos usar esta variable numeroActual para hacer
    //  Convertimos el texto de la pantalla al primer número
    double numeroActual = double.tryParse(_pantalla) ?? 0.0; // double.tryParse es una función que convierte el texto  a tipo numerico decimal
    //al poner tryParse le estamos diciendo que si no es un numero valido que devueva null a comparación de Parse que nos da error de excepción si no es valido
    //el operador ?? es para decir: "si el resultado de la izquierda es nulo, usa el valor de la derecha"

    _pantalla = (numeroActual % 1 == 0)
        ? numeroActual.toInt().toString()
        : numeroActual.toString();
    // CASO A: Ya había una cuenta previa esperando resolverse (ej. ya teníamos 1 y '+', y ahora pulsaron '+')
    if (_primerNumero != null &&
        _operador.isNotEmpty &&
        !_esperandoNuevoNumero) {
      double subtotal = ejecutarOperacionMatematica(
        _primerNumero!,
        numeroActual,
        _operador,
      );
      if (subtotal.isNaN) {
        _pantalla = 'Error';
        _historial = '';
        _primerNumero = null;
        _operador = '';
        _esperandoNuevoNumero = true;
        return;
      }

      // Actualizamos el primer número con el acumulado
      _primerNumero = subtotal;

      // Actualizamos la pantalla con el subtotal formateado
      _pantalla = (subtotal % 1 == 0)
          ? subtotal.toInt().toString().replaceAll(
              RegExp(r"([.]*0+)(?!.*\d)"),
              "",
            )
          : subtotal.toString().replaceAll(
              RegExp(r"([.]*0+)(?!.*\d)"),
              "",
            ); //es un operador terniario y el simbolo ?
      //nos dice que actua como un if else Condición ? Acción_si_es_verdadero : Acción_si_es_falso;
      //si es cierto lo convierte a entero y le quita los decimales .00 y si es falso se deja tal cual solo lo pasa a string para mostrarlo

      String numeroActualtext = numeroActual.toString().replaceAll(
        RegExp(r"([.]*0+)(?!.*\d)"),
        "",
      );
      // Extendemos el historial acumulando: "1 + 2 +"
      _historial = '$_historial $numeroActualtext $op'; // encadenamos y mostramos las variables con el signo $ y asi nos permite colocar variables
    }
    // CASO B: Es el primer operador que se presiona en la cuenta
    else if (_primerNumero == null) {
      _primerNumero = numeroActual;
      _historial = '$pantalla $op';
    }
    // CASO C: El usuario se equivocó de operador y lo cambió antes de escribir otro número (ej. pulsó '+' y luego '-')
    else {
      _historial =
          '${_primerNumero! % 1 == 0 ? _primerNumero!.toInt() : _primerNumero} $op'; //es un operador terniario y el simbolo ?
      //nos dice que actua como un if else Condición ? Acción_si_es_verdadero : Acción_si_es_falso;
      //${ ... }: Permite evaluar una expresión completa dentro del string.
      //primerNumero! % 1 == 0 ? primerNumero!.toInt() : primerNumero: Revisa si el número guardado no tiene decimales para imprimirlo sin .0 (ej. 5 en vez de 5.0).
      //$op: Reemplaza el operador viejo por el nuevo en el texto visible del historial (cambia "5 +" por "5 -").
    }

    _operador = op;
    _esperandoNuevoNumero = true;
    notifyListeners();
  }
}
