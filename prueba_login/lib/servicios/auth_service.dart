import 'dart:convert';

import 'package:http/http.dart' as http;
// las buenas prácticas suguieren que no es recomendable usar prints para mostrar errores comom solo lo vamos a ver nostros como
//desarrolladores mejor usamos debugprint así flutter sabe que nunca se va a mostrar en producción para el usuario y por eso usamos
//foundation.dart
import 'package:flutter/foundation.dart';

import 'dart:io';
import 'dart:async';

import 'package:prueba_login/core/errores.dart';

//aqui van los servicios que tiene que ver con Usuarios y Auteticación
class AuthService {
  // La URL de la API ( cambiar la dir ip a localhost cuando se compila en windows, o usas la ip de la compu cuando se compila
  ////en dispositivos fisicos y que esten en la misma red.
  // y por 10.0.2.2 si usas emulador Android)
  final String _baseUrl = 'http://localhost:3000/api/users';

  // Funciones para dar servicios---------------------------------------servicio de login
  Future<void> login(String email, String password) async {
    //se arma la url para poder hacer peticiones a la API, Uri es una clase de dart que nos ayuda a manejar url
    final url = Uri.parse('$_baseUrl/login');

    //se define la cabecera de la petición
    final headers = {'Content-Type': 'application/json'};

    //se crea el body de la petición
    final body = jsonEncode({'email': email, 'password': password});

    final http.Response response;

    try {
      //hacemos la peticion POST login, esperamos await que es la respuesta de la peticion
      response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 10));
    } on SocketException {
      //no hay red / el servidor no responde
      throw const SinConexion();
    } on TimeoutException {
      // tardó demasiado
      throw const SinConexion();
    }

    //si llegamos aquí, el servidor si respondió y revisamos que devolvio
    switch (response.statusCode) {
      case >= 200 && < 300:
        return; // éxito, no hay nada que lanzar
      case 401:
        throw const CredencialesInvalidas();
      case >= 500:
        throw ErrorServidor(response.statusCode);
      default:
        debugPrint(
          'Respuesta no esperada: ${response.statusCode} ${response.body}',
        );
        throw const ErrorDesconocido();
    }
  }

  //servicio de registro--------------------------------------------------------
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
