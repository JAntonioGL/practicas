
  //haremos otro método función para guardar  el operador que quiere y que se limpie la pantalla para introducir el siguiente numero
  import 'package:calculadora_p_1/logic/ejecutarOperacionMatematica.dart';

void seleccionarOperacion(String op, String pantalla, double? primerNumero, String operador, bool esperandoNuevoNumero, String historial) {
      //en un futuro podemos usar esta variable numeroActual para hacer
      //  Convertimos el texto de la pantalla al primer número
      double numeroActual = double.tryParse(pantalla) ?? 0.0; // double.tryParse es una función que convierte el texto  a tipo numerico decimal
      //al poner tryParse le estamos diciendo que si no es un numero valido que devueva null a comparación de Parse que nos da error de excepción si no es valido
      //el operador ?? es para decir: "si el resultado de la izquierda es nulo, usa el valor de la derecha"

      pantalla = (numeroActual % 1 == 0)
          ? numeroActual.toInt().toString()
          : numeroActual.toString();
      // CASO A: Ya había una cuenta previa esperando resolverse (ej. ya teníamos 1 y '+', y ahora pulsaron '+')
      if (primerNumero != null &&
          operador.isNotEmpty &&
          !esperandoNuevoNumero) {
        double subtotal = ejecutarOperacionMatematica(
          primerNumero!,
          numeroActual,
          operador,
        );
        if (subtotal.isNaN) {
          pantalla = 'Error';
          historial = '';
          primerNumero = null;
          operador = '';
          esperandoNuevoNumero = true;
          return;
        }

        // Actualizamos el primer número con el acumulado
        primerNumero = subtotal;

        // Actualizamos la pantalla con el subtotal formateado
        pantalla = (subtotal % 1 == 0)
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
        historial = '$historial $numeroActualtext $op'; // encadenamos y mostramos las variables con el signo $ y asi nos permite colocar variables
      }
      // CASO B: Es el primer operador que se presiona en la cuenta
      else if (primerNumero == null) {
        primerNumero = numeroActual;
        historial = '$pantalla $op';
      }
      // CASO C: El usuario se equivocó de operador y lo cambió antes de escribir otro número (ej. pulsó '+' y luego '-')
      else {
        historial =
            '${primerNumero! % 1 == 0 ? primerNumero!.toInt() : primerNumero} $op'; //es un operador terniario y el simbolo ?
        //nos dice que actua como un if else Condición ? Acción_si_es_verdadero : Acción_si_es_falso;
        //${ ... }: Permite evaluar una expresión completa dentro del string.
        //primerNumero! % 1 == 0 ? primerNumero!.toInt() : primerNumero: Revisa si el número guardado no tiene decimales para imprimirlo sin .0 (ej. 5 en vez de 5.0).
        //$op: Reemplaza el operador viejo por el nuevo en el texto visible del historial (cambia "5 +" por "5 -").
      }

      operador = op;
      esperandoNuevoNumero = true;
}
