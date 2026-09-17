import 'package:flutter/material.dart'; //importa la libreria de flutter que contiene todos los widgets

import '../logic/calculadora_core.dart'; //importa la logica de la calculadora

class CalculadoraScreen extends StatefulWidget {
  //esta clase es la clase CalculadoraScreen
  const CalculadoraScreen({super.key}); //es el constructor de la clase y le da el identifcador key de esta clase a statefulwidget

  @override //es una anotacion que le dice a flutter que va a reescribir metodos de la clase statefulwidget
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  //en esta clase se encuentra el estado de la calculadora, es decir, los datos que se van a mostrar en la pantalla
  // en este espacio se declaran varaibles que cambian
  String _pantalla = '0'; //lo que s emuestra en pantalla y lleva un _ porque estamos diciendo que es pivada y solo la puede leer y modificar el mismo archivo que la creo
  double? _primerNumero; // // guarda el primer calor y el signo ? nos dice que puede ser un valor nulo
  String _operador =
      ''; // guarda  el operador aritmetico que quiere usar '+', '-', '*', '/'
  bool _esperandoNuevoNumero = false; // Indica si el siguiente toque limpia la patalla o no es como una bandera
  String _historial = ''; // con esta variable de estado vamos a poder mostrar la operación que está realizando el usuario
  //la guardamos con texto secundario

  //------------------------------------------------------------------------
  //haremos una función limpiar, como no es una función matematica no se coloca en calculadora_core.dart, sino aqui mismo en la clase
  //ya que aqui es donde tenemos acceso a las variables de estado que necesitamos para limpiar pantalla como _pantalla
  //funciona basicamente como una funcion que reinicia la calculadora por eso los valores los regresamos a uini estado inicial por eso
  //
  void _limpiar() {
    setState(() {
      //nosotros al poner setSate le decimos al framework que el estado interno del statefulwidget ha cambiado y que lo debe modificar (osea redibujar la pantalla) con
      //lo que se coloque dentro del setstate, en este caso las variables de estado
      _pantalla = '0'; // regresa a 0 en la pantalla
      _primerNumero = null; //lo ponemos en nulo para que no tenga valor
      _operador = ''; //deja en blanco el operador
      _esperandoNuevoNumero =
          false; //indica si el siguiente toque limpia la patalla o no
      _historial = ''; //deja en blanco el historial
    });
  }

  //haremos otro método función para guardar  el operador que quiere y que se limpie la pantalla para introducir el siguiente numero
  void _seleccionarOperacion(String op) {
    setState(() {
      //en un futuro podemos usar esta variable numeroActual para hacer
      //  Convertimos el texto de la pantalla al primer número
      double numeroActual = double.tryParse(_pantalla) ?? 0.0; // double.tryParse es una función que convierte el texto  a tipo numerico decimal
      //al poner tryParse le estamos diciendo que si no es un numero valido que devueva null a comparación de Parse que nos da error de excepción si no es valido
      //el operador ?? es para decir: "si el resultado de la izquierda es nulo, usa el valor de la derecha"
      // CASO A: Ya había una cuenta previa esperando resolverse (ej. ya teníamos 1 y '+', y ahora pulsaron '+')
      if (_primerNumero != null &&
          _operador.isNotEmpty &&
          !_esperandoNuevoNumero) {
        double subtotal = _ejecutarOperacionMatematica(
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
            ? subtotal.toInt().toString()
            : subtotal.toString(); //es un operador terniario y el simbolo ?
        //nos dice que actua como un if else Condición ? Acción_si_es_verdadero : Acción_si_es_falso;
        //si es cierto lo convierte a entero y le quita los decimales .00 y si es falso se deja tal cual solo lo pasa a string para mostrarlo

        // Extendemos el historial acumulando: "1 + 2 +"
        _historial = '$_historial $numeroActual $op'; // encadenamos y mostramos las variables con el signo $ y asi nos permite colocar varaibles
      }
      // CASO B: Es el primer operador que se presiona en la cuenta
      else if (_primerNumero == null) {
        _primerNumero = numeroActual;
        _historial = '$_pantalla $op';
      }
      // CASO C: El usuario se equivocó de operador y lo cambió antes de escribir otro número (ej. pulsó '+' y luego '-')
      else {
        _historial =
            '${_primerNumero! % 1 == 0 ? _primerNumero!.toInt() : _primerNumero} $op'; //es un operador terniario y el simbolo ?
        //nos dice que actua como un if else Condición ? Acción_si_es_verdadero : Acción_si_es_falso;
        //${ ... }: Permite evaluar una expresión completa dentro del string.
        //_primerNumero! % 1 == 0 ? _primerNumero!.toInt() : _primerNumero: Revisa si el número guardado no tiene decimales para imprimirlo sin .0 (ej. 5 en vez de 5.0).
        //$op: Reemplaza el operador viejo por el nuevo en el texto visible del historial (cambia "5 +" por "5 -").
      }

      _operador = op;
      _esperandoNuevoNumero = true;
    });
  }

  //esta función nos va  ayudar a capturar los digitos que precionamos, sean del 1 al 9
  void _presionarNumero(String digito) {
    setState(() {
      // Si la pantalla tiene '0' o acabamos de tocar un operador, reemplazamos el texto
      if (_pantalla == '0' || _esperandoNuevoNumero) {
        //cuando presionamos el boton de operador se llama a la función de _seleccionarOperador y
        //ahi se va a cambiar el estado de la variable _esperandoNuevoNumero a true para que al presionar un numero se reemplace el texto en lugar de concatenar
        //asi funciona en una calculadora real, primero precionas un numero, luego el operador y luego otro numero para realizar la operacion
        //es decir, si _pantalla es '0' y precionamos '5', se reemplaza el cero por el cinco, si _pantalla es '5' y precionamos '+', se guarda el cinco y se reinicia la pantalla a '0'
        //si despues de precionar '+' precionamos '3', se reemplaza el cero por el tres y se guarda el tres, si precionamos '=', se realiza la operacion '5 + 3' y se muestra el resultado '8'
        _pantalla = digito; //se reemplaza el cero por el digito precionado, si la varible esperandoNuevoNumero es true se reemplaza el texto
        _esperandoNuevoNumero = false; //y como ya se preciono el primer numero de esta operacion, se cambia el valor del booleano a false
      } else {
        // Si ya hay números escritos, concatenamos el nuevo dígito al final
        _pantalla = _pantalla + digito; //si no es cero y no se ha precionado un operador, se concatena el digito al texto que ya se tiene en pantalla
      }
    });
  }

  //en este método se hace el calculo llamando a las funciones de logic en calculadora_core.dart
  void _calcularResultado() {
    if (_primerNumero == null || _operador.isEmpty) return; //si no hay primer numero o no hay operador, no se hace nada, validamos que
    //haya algo para que no de error al hacer las operaciones desde calculadora_core.dart

    double segundoNumero =
        double.tryParse(_pantalla) ??
        0.0; //obtiene el valor actual en la pantalla
    double resultado = _ejecutarOperacionMatematica(
      _primerNumero!,
      segundoNumero,
      _operador,
    );

    // 3. Actualizamos la pantalla con el resultado final
    setState(() {
      if (resultado.isNaN) {
        // si en resultado nos arroja un indefinido o invalido con isNaN lo detectamos
        _pantalla = 'Error';
        _historial = '';
      } else {
        _historial = '$_historial $segundoNumero ='; //concatenamos el resultado actual con el segundo numero y el historial que llevemos de operaciones encadenadas
        _pantalla = (resultado % 1 == 0)
            ? resultado.toInt().toString()
            : resultado.toString(); // es un operador terniario que nos ayuda a mostrar el resultado sin decimales si es que no tiene
      }

      // Reiniciamos para que el siguiente número empiece cuenta nueva
      _primerNumero = null;
      _operador = '';
      _esperandoNuevoNumero = true;
    });
  }

  // para refactorizar el codigo para que haga operaciones encadenadas y no solo operaciones de 2 numeros necesitamos una funcion auxiliar
  // que simplemente aplique las funciones de calculaora_core.dart
  double _ejecutarOperacionMatematica(double a, double b, String op) {
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

  @override
  Widget build(BuildContext context) {
    //aqui defines ques e dibuja en la pantalla
    return Scaffold(
      // se usa scaffold o andamio como estructura base del widget porque estamos usando material design
      backgroundColor: Colors.black, //las palabras que ponemos antes de : son parametros nombrados
      appBar: AppBar(
        title: const Text(
          'Calculadora Curi',
          style: TextStyle(color: Colors.orangeAccent),
        ),
        backgroundColor: Colors.grey[900],
      ),
      //SafeArea es un widget que se asegura de que el contenido no se superponga con el hardware de la pantalla
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            // Evaluamos la orientación para devolver la vista correspondiente
            if (orientation == Orientation.portrait) {
              return _construirVistaVertical();
            } else {
              return _construirVistaHorizontal();
            }
          },
        ),
      ),
    );
  }

  // Vista original para cuando el teléfono está en vertical
  Widget _construirVistaVertical() {
    return Column(
      children: [
        // Area superior: display (ocupa 2 partes del espacio)
        Expanded(
          flex: 2,
          child: _construirPanelResultados(),
        ),
        // Separador visual
        const Divider(color: Colors.blueGrey, height: 1),
        // Area inferior: teclado (ocupa 5 partes del espacio)
        Expanded(
          flex: 5,
          child: _construirTeclado(),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  // Nueva vista para cuando el teléfono está en horizontal (acostado)
  Widget _construirVistaHorizontal() {
    return Row(
      children: [
        // Panel izquierdo: Historial y resultado (ocupa la mitad de la pantalla)
        Expanded(
          flex: 1,
          child: _construirPanelResultados(),
        ),
        // Separador vertical
        const VerticalDivider(color: Colors.blueGrey, width: 1),
        // Panel derecho: Teclado (ocupa la otra mitad)
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
            child: _construirTeclado(),
          ),
        ),
      ],
    );
  }

  // Método auxiliar para construir la pantalla de resultados y el historial
  Widget _construirPanelResultados() {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true, // Para que siempre se vea lo último del historial
              child: Text(
                _historial,
                style: const TextStyle(fontSize: 24, color: Colors.grey),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _pantalla,
            style: const TextStyle(
              fontSize: 48,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  // Método auxiliar para construir todas las filas de botones dinámicamente
  Widget _construirTeclado() {
    return Column(
      children: [
        // Fila 1: C, ÷
        Expanded(
          child: Row(
            children: [
              _construirBoton(
                texto: 'C',
                colorFondo: Colors.red[700],
                alPresionar: _limpiar,
              ),
              _construirBoton(
                texto: '÷',
                colorFondo: Colors.orange[800],
                alPresionar: () => _seleccionarOperacion('÷'),
              ),
            ],
          ),
        ),
        // Fila 2: 7, 8, 9, ×
        Expanded(
          child: Row(
            children: [
              _construirBoton(texto: '7', alPresionar: () => _presionarNumero('7')),
              _construirBoton(texto: '8', alPresionar: () => _presionarNumero('8')),
              _construirBoton(texto: '9', alPresionar: () => _presionarNumero('9')),
              _construirBoton(texto: '×', colorFondo: Colors.orange[800], alPresionar: () => _seleccionarOperacion('*')),
            ],
          ),
        ),
        // Fila 3: 4, 5, 6, -
        Expanded(
          child: Row(
            children: [
              _construirBoton(texto: '4', alPresionar: () => _presionarNumero('4')),
              _construirBoton(texto: '5', alPresionar: () => _presionarNumero('5')),
              _construirBoton(texto: '6', alPresionar: () => _presionarNumero('6')),
              _construirBoton(texto: '-', colorFondo: Colors.orange[800], alPresionar: () => _seleccionarOperacion('-')),
            ],
          ),
        ),
        // Fila 4: 1, 2, 3, +
        Expanded(
          child: Row(
            children: [
              _construirBoton(texto: '1', alPresionar: () => _presionarNumero('1')),
              _construirBoton(texto: '2', alPresionar: () => _presionarNumero('2')),
              _construirBoton(texto: '3', alPresionar: () => _presionarNumero('3')),
              _construirBoton(texto: '+', colorFondo: Colors.orange[800], alPresionar: () => _seleccionarOperacion('+')),
            ],
          ),
        ),
        // Fila 5: 0, =
        Expanded(
          child: Row(
            children: [
              _construirBoton(texto: '0', alPresionar: () => _presionarNumero('0')),
              _construirBoton(texto: '=', colorFondo: Colors.green[700], alPresionar: () => _calcularResultado()),
            ],
          ),
        ),
      ],
    );
  }

  // Método auxiliar para crear un botón responsivo sin medidas fijas que rompan la interfaz
  Widget _construirBoton({
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
}
