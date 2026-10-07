import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_login/servicios/auth_service.dart';

void main() {
  group('AuthService Tests', () {
    late AuthService authService;

    // setUp se ejecuta antes de cada prueba (test)
    setUp(() {
      authService = AuthService(); //instanciamos la clase AuthService, para que pueda ser usada en las pruebas
    });

    test('Debe registrar un nuevo usuario exitosamente', () async {
      // OJO: Si ejecutas estas pruebas varias veces, el registro podría fallar
      // si tu API no permite registrar el mismo email dos veces.
      // Puedes cambiar el email dinámicamente si es necesario.
      final uniqueEmail =
          'test_${DateTime.now().millisecondsSinceEpoch}@test.com';

      bool resultadoRegistro = await authService.register(
        "Usuario Test Unitario",
        uniqueEmail,
        "password123",
      );

      // Comprobamos que el resultado sea 'true'
      expect(resultadoRegistro, isTrue);
    });

    test('Debe iniciar sesión exitosamente con credenciales válidas', () async {
      // Aquí asumimos que el usuario 'test@test.com' ya existe en tu DB
      // gracias a la prueba anterior de test_api.dart
      bool resultadoLogin = await authService.login(
        "test@test.com",
        "mipassword123",
      );

      // Comprobamos que el resultado sea 'true'
      expect(resultadoLogin, isTrue);
    });
  });
}
