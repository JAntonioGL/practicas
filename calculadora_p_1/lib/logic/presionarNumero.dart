//esta función nos va  ayudar a capturar los digitos que precionamos, sean del 1 al 9
  void presionarNumero(String digito, String pantalla, bool esperandoNuevoNumero) {
      // Si la pantalla tiene '0' o acabamos de tocar un operador, reemplazamos el texto
      if (pantalla == '0' || esperandoNuevoNumero) {
        //cuando presionamos el boton de operador se llama a la función de _seleccionarOperador y
        //ahi se va a cambiar el estado de la variable _esperandoNuevoNumero a true para que al presionar un numero se reemplace el texto en lugar de concatenar
        //asi funciona en una calculadora real, primero precionas un numero, luego el operador y luego otro numero para realizar la operacion
        //es decir, si pantalla es '0' y precionamos '5', se reemplaza el cero por el cinco, si pantalla es '5' y precionamos '+', se guarda el cinco y se reinicia la pantalla a '0'
        //si despues de precionar '+' precionamos '3', se reemplaza el cero por el tres y se guarda el tres, si precionamos '=', se realiza la operacion '5 + 3' y se muestra el resultado '8'
        pantalla = digito; //se reemplaza el cero por el digito precionado, si la varible esperandoNuevoNumero es true se reemplaza el texto
        esperandoNuevoNumero = false; //y como ya se preciono el primer numero de esta operacion, se cambia el valor del booleano a false
      } else {
        // Si ya hay números escritos, concatenamos el nuevo dígito al final
        pantalla = pantalla + digito; //si no es cero y no se ha precionado un operador, se concatena el digito al texto que ya se tiene en pantalla
      }
}