import 'package:flutter/material.dart'; //importa la libreria de flutter que contiene todos los widgets

import 'package:calculadora_p_1/widgets/construirVistaVerticalWidget.dart';

import 'package:calculadora_p_1/widgets/construirVistaHorizontalWidget.dart';

/*class CalculadoraScreen extends StatelessWidget {
  //esta clase es la clase CalculadoraScreen
  const CalculadoraScreen({super.key}); //es el constructor de la clase y le da el identifcador key de esta clase a statefulwidget

  @override //es una anotacion que le dice a flutter que va a reescribir metodos de la clase statefulwidget
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}*/

class CalculadoraScreen extends StatelessWidget {
  const CalculadoraScreen({super.key}); //es el constructor de la clase y le da el identifcador key de esta clase a statefulwidget
  @override
  Widget build(BuildContext context) {
    //aqui defines ques e dibuja en la pantalla
    return Scaffold(
      // se usa scaffold o andamio como estructura base del widget porque estamos usando material design
      backgroundColor: Colors
          .black, //las palabras que ponemos antes de : son parametros nombrados
      appBar: AppBar(
        title: const Text(
          'Calculadora Curi',
          style: TextStyle(color: Colors.orangeAccent),
        ),
        backgroundColor: Colors.grey[900],
      ),
      //SafeArea es un widget que se asegura de que el contenido no se superponga con el hardware de la pantalla
      body: SafeArea(
        //agregar relleno automático a tus elementos y evitar que se oculten detrás de las partes físicas o de la interfaz del sistema operativo
        child: OrientationBuilder(
          // es un widget escuchador o listener que se encarga de detectar la orientación de la pantalla y de builder construye la vista correspondiente
          builder: (context, orientation) {
            //el parametro builder es obligatorio ya que se encarga de construir y devolver el widget específico que se debe mostrar según la orientación actual.
            // el parámetro builder siempre recibe context(ubicacion exacta de este widget dentro del arbol de widgets de la aplicación)
            // orientation es el parametro que nos permite obtener la orientacion de la pantalla calcula el espacio disponible y entrega un valor de dos
            //el primero es orientation.portrait(retrato o vertical, pantalla mas alta que ancha)
            // orientation.landscape(paisaje u horizontal, pantalla mas ancha que alta)

            // Evaluamos la orientación para devolver la vista correspondiente
            if (orientation == Orientation.portrait) {
              // si es vertical
              return construirVistaVertical(context);
            } else {
              return construirVistaHorizontal(context);
            }
          },
        ),
      ),
    );
  }
}
