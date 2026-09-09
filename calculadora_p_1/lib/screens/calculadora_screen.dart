import 'package:flutter/material.dart'; //importa la libreria de flutter que contiene todos los widgets

import '../logic/calculadora_core.dart'; //importa la logica de la calculadora

class CalculadoraScreen extends StatefulWidget {
  //esta clase es la clase
  const CalculadoraScreen({super.key}); //es el constructor de la clase y le da el identifcador key de esta clase a statefulwidget

  @override //es una anotacion que le dice a flutter que va a reescribir metodos de la clase statefulwidget
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  //en esta clase se encuentra el estado de la calculadora, es decir, los datos que se van a mostrar en la pantalla
  // en este espacio se declaran varaibles que cambian
  @override
  Widget build(BuildContext context) {
    //aqui defines ques e dibuja en la pantalla
    String _pantalla = '0'; //lo que s emuestra en pantalla y lleva un _ porque estamos diciendo que es pivada y solo la puede leer y modificar el mismo archivo que la creo
    double? _primerNumero; // // guarda el primer calor y el signo ? nos dice que puede ser un valor nulo
    String _operador =
        ''; // guarda  el operador aritmetico que quiere usar '+', '-', '*', '/'
    bool _esperandoNuevoNumero =
        false; // Indica si el siguiente toque limpia la patalla o no

    return Scaffold(
      // se usa scaffold o andamio como estructura base del widget porque estamos usando material design
      backgroundColor: Colors.black, //las palabras que ponemos antes de : son parametros nombrados, es decir, le decimos a flutter que es lo que queremos que haga con el widget
      appBar: AppBar(
        title: const Text('Calculadora Curi'),
        backgroundColor: Colors.grey[900],
      ), //podemos verlo como cajas dentro de cajas, los argumentos del widget son como las propiedades que le damos al widget, y los widgets anidados son como los elementos que ponemos dentro del widget
      body: Column(
        //seguimos con la lógica de las cajas dentro de cajas y dentro de esta caja metemos otras
        children: [
          //con children le decimos a column que los hijos van a ir en esta lista de elementos, ya sea widgets o parametros nomabraos
          //Area superior: display
          Expanded(
            //digamos que expanded es un envoltorio que ocupa todo el espacio disponible para su widget hijo
            child: Container(
              //container es un widget multiproposito que se usa para agrupar otros widgets y darle propiedades como color, tamaño, etc
              alignment: Alignment(bottomRight),
              padding: const EdgeInsets.all(24.0),
              child: Text(
                _pantalla,
                style: const TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ),
          ),
          const Divider(color: Colors.blueGrey, height: 1),
        ],
      ), //SafeArea es un widget que se asegura de que el contenido no se superponga con el hardware de la pantalla, como el notch o la muesca de iPhone o la barra de navegación en Android. Center es un widget que centra su contenido en el centro de la pantalla. Text es un widget que muestra texto
    ); //Scaffold es el widget esqueleto que proporciona una estructura basica para la pantalla y se usa para el diseño visual de material design
  }

  //aqui vamos a colocar uhn método auxiliar para crear un boton, para no tener que crear un boton en cada espacio de la pantalla, por lo que será mas facil organizar y codificar el boton
  //no es tan buena práctica ya que la buena práctica escalable es crear una clase statelesswidget indepéndiente
  //por ahora lo dejaremos en método de la misma clase

  Widget _construirBoton({
    // aqui se colocan los parametros que va a recibir el metodo y algunos no son constantes por lo que se les pone ? para que puedan ser nulos
    //son parámetros nombrados ya que no se requiere un orden especifico de los argumentos, si fuera sin las llave {} si seria necesario indicar el orden de los argumentos
    //la palabra required nos dice que ese parametro es obligatorio y no puede ser nulo
    // los paramertos que necesitamos son el texto que va a ir en el boton, el color del fondo del boton, el color del texto del boton y una funcion para cuando se presione el boton
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
            padding: const EdgeInsets.symmetric(vertical: 22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: alPresionar,
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
    ); // aqui termina el metodo _construirBoton
  }
}
