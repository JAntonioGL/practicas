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
      body: const SafeArea(
        child: Center(
          child: Text(
            'Lienzo listo',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ), //SafeArea es un widget que se asegura de que el contenido no se superponga con el hardware de la pantalla, como el notch o la muesca de iPhone o la barra de navegación en Android. Center es un widget que centra su contenido en el centro de la pantalla. Text es un widget que muestra texto
    ); //Scaffold es el widget esqueleto que proporciona una estructura basica para la pantalla y se usa para el diseño visual de material design
  }
}
