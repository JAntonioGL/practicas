// CONCEPTO DE CONTROLADOR (auth_controller.dart)
import 'package:flutter/material.dart';
import 'package:prueba_login/core/errores.dart';
import 'package:prueba_login/core/mensajes.dart';
import 'package:prueba_login/servicios/auth_service.dart';

class AuthController extends ChangeNotifier {
  // 1. Conecta con el Servicio (La cocina)
  final AuthService _servicio = AuthService();

  // 2. Variables de "Estado" (Lo que la vista necesita saber)
  bool _estaCargando = false;
  String _mensajeDeError = '';

  bool get estaCargando => _estaCargando;
  String get mensajeDeError => _mensajeDeError;

  // 3. La función que la Vista va a llamar cuando aprieten el botón
  Future<bool> intentarLogin(String email, String password) async {
    // LOGICA: Cambiar el estado a "Cargando"
    _estaCargando = true;
    _mensajeDeError = '';
    notifyListeners(); // La vista mostrará un circulito girando

    try {
      await _servicio.login(email, password); // si no lanza, fue éxito
      return true;
    } on AppError catch (e) {
      _mensajeDeError = Mensajes.deError(e); // 
      return false;
    } finally {//con finally hace que lo que este detro se ejecute si o si no importa lo que haya salido antes 
      _estaCargando = false; // se ejecuta SIEMPRE
      notifyListeners();
    }
  }

  //controlador de registro------------------------------------------------------
  Future<bool> intentarRegister(
    String name,
    String email,
    String password,
  ) async {
    // LOGICA 1: Validar antes de ir al servidor
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      //validamos que ningun campo este vacio para el registro
      _mensajeDeError = "Oye, llena todos los campos primero.";
      notifyListeners(); // <--- Le grita a la vista: ¡Redibújate con este error!
      return false; // Detiene la ejecución aquí
    }

    // LOGICA 2: Cambiar el estado a "Cargando"
    _estaCargando = true;
    _mensajeDeError = '';
    notifyListeners(); // La vista mostrará un circulito girando

    // LOGICA 3: Llamar al servicio
    bool exito = await _servicio.register(name, email, password);

    // LOGICA 4: Reaccionar a lo que dijo el servicio
    _estaCargando = false; // Ya terminamos de cargar

    if (!exito) {
      _mensajeDeError = "No se pudo crear la cuenta, Intenta de nuevo";
    }
    notifyListeners();
    return exito;
  }

  void limpiarError() {
    _mensajeDeError = '';
    notifyListeners();
  }
}
