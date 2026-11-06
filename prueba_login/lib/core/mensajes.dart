import 'package:prueba_login/core/errores.dart';

class Mensajes {
  // Constructor privado: nadie debe hacer Mensajes(), solo usar Mensajes.algo
  Mensajes._();
  static const campoRequerido = 'Este campo es obligatorio';
  static const emailInvalido = 'Escribe un correo válido';
  //static const passwordInvalido = 'La contraseña debe tener al menos 6 caracteres';
  static String passwordCorta(int min) =>
      'La contraseña debe tener al menos $min caracteres';
  //static const passwordRequerido = 'La contraseña es obligatoria';
  //static const nombreInvalido = 'El nombre debe tener al menos 3 caracteres';
  static String deError(AppError error) {
    return switch (error) {
      SinConexion() => 'No hay conexión. Revisa tu internet',
      CredencialesInvalidas() => 'Correo o contraseña incorrectos.',
      ErrorServidor() => 'Tuvimos un problema. Intenta más tarde.',
      ErrorDesconocido() => 'Algo salió mal. Intenta de nuevo.',
      CorreoYaRegistrado() => 'El correo ya ha sido registrado',
      DatosInvalidos() => 'Revisa los datos ingresados, no son validos ',
    };
  }
}
