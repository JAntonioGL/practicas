// CONCEPTO DE CONTROLADOR (auth_controller.dart)
import 'package:flutter/material.dart';
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
  Future<void> intentarLogin(String email, String password) async {
    
    // LOGICA 1: Validar antes de ir al servidor
    if (email.isEmpty || password.isEmpty) {
      _mensajeDeError = "Oye, llena todos los campos primero.";
      notifyListeners(); // <--- Le grita a la vista: ¡Redibújate con este error!
      return; // Detiene la ejecución aquí
    }

    // LOGICA 2: Cambiar el estado a "Cargando"
    _estaCargando = true;
    _mensajeDeError = '';
    notifyListeners(); // La vista mostrará un circulito girando

    // LOGICA 3: Llamar al servicio
    bool exito = await _servicio.login(email, password);

    // LOGICA 4: Reaccionar a lo que dijo el servicio
    _estaCargando = false; // Ya terminamos de cargar
    
    if (exito) {
      // Todo salió bien, el Controlador no hace nada más, la Vista se encargará de navegar
    } else {
      _mensajeDeError = "Credenciales incorrectas, intenta de nuevo.";
    }
    
    notifyListeners(); // Le vuelve a gritar a la vista para que quite el circulito
  }
}
