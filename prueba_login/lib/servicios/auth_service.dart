import 'dart:convert';

import 'package:http/http.dart' as http;
// las buenas prácticas suguieren que no es recomendable usar prints para mostrar errores comom solo lo vamos a ver nostros como
//desarrolladores mejor usamos debugprint así flutter sabe que nunca se va a mostrar en producción para el usuario y por eso usamos
//foundation.dart
import 'package:flutter/foundation.dart';

//aqui van los servicios que tiene que ver con Usuarios y Auteticación

class AuthService {
  // La URL de tu API (Asegúrate de cambiar localhost por 10.0.2.2 si usas emulador Android)
  final String _baseUrl = 'http://10.0.2.2:3000/api/users';

  // Funciones para dar servicios
  Future<bool> login(String email, String password) async {
    //se arma la url para poder hacer peticiones a la API, Uri es una clase de dart que nos ayuda a manejar url
    final url = Uri.parse('$_baseUrl/login');

    //se define la cabecera de la petición
    final headers = {'Content-Type': 'application/json'};

    //se crea el body de la petición
    final body = jsonEncode({'email': email, 'password': password});

    try {
      //hacemos la peticion POST login, esperamos await que es la respuesta de la peticion
      final response = await http.post(url, headers: headers, body: body);

      //si la peticion fue exitosa (codigos 200-299)
      if (response.statusCode == 200) {
        //podmeos usar jsondecode sobre  response.body para sacar datos como el token etc si es que lo queremos para este caso no
        debugPrint("Login exitoso");
        return true;
      } else {
        //por si algo falla con el login
        debugPrint("Error en login: ${response.body}");
        return false;
      }
    } catch (e) {
      debugPrint('Error de red o del servidor: $e');
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    final url = Uri.parse("$_baseUrl/register");

    //se define la cabecera de la petición
    final headers = {'Content-Type': 'application/json'};

    //se crea el body de la petición
    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });

    try {
      //hacemos la peticion POST login, esperamos await que es la respuesta de la peticion
      final response = await http.post(url, headers: headers, body: body);

      //si la peticion fue exitosa (codigos 200-299)
      if (response.statusCode == 200) {
        debugPrint("Registro exitoso");
        return true;
      } else {
        //por si algo falla con el login
        debugPrint("Error en Registro: ${response.body}");
        return false;
      }
    } catch (e) {
      debugPrint('Error de red o del servidor: $e');
      return false;
    }
  }
}
