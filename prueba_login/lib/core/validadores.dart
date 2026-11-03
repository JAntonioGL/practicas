import 'package:prueba_login/core/mensajes.dart';

class Validadores {
  Validadores._();
  //funcion estatica de tipo string para validar haciendo uso de los textos de Mensajes 

  //revisa solo si el valor que le pasan es correcto, revisa que no venga null,
  // le quita los espacios y comprueba que no este vacio es decir con espacios ern blanco
  static String? requerido(String? valor){
    if(valor == null || valor.trim().isEmpty){
      return Mensajes.campoRequerido;
    }
    return null;
  }
//con la validación anterior podemos comprobar que si el campo esta vacio para tener doble validación en correo 
  static String? email(String? valor){
    final error = requerido(valor);
    if(error != null) return error;//si está vacio regresa error de camporequerido 

    //validación para el correo 
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');//expresión regular para el formato deel correo 
    if(!regex.hasMatch(valor!)) return Mensajes.emailInvalido;//hasMatch es un metodo de regexp, solo comprueba si 
    //cumple el patrón definido y devuelve un booleano, si es false ! lo vuelve true y entra al mensaje de error 
    return null;
  }

//validacion para la contraseña o password
static const int minPassword = 6;//aqui podemos cambiar el numero de caracrteres admitido 
  static String? password(String? valor){
    final error = requerido(valor);
    if(error != null) return error;//si está vacio regresa error de camporequerido 

    //pendiente ver si se elimina los espacios en contraseñas -corrección a una contraseña no se le quitan espacios en 
    //blanco porque también son validos y si lo vamos a guardar y enviar tiene que mandarse tal cual 
    if (valor!.length < minPassword){
      return Mensajes.passwordCorta(minPassword);
    }
    return null;
  }
  
}