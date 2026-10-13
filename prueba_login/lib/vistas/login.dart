import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_login/widgets/boton_glass.dart';
import 'package:prueba_login/providers/auth_provider.dart';
import 'package:prueba_login/widgets/campo_texto.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final _formKey = GlobalKey<FormState>();

  // Creamos los "micrófonos"
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 👂 "Escuchamos" el estado del AuthController:
    final auth = context.watch<AuthController>();
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.2),
            radius: 0.8,
            colors: [Color.fromARGB(255, 129, 34, 34), Color(0xFF0A0E17)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsGeometry.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Bienvenido',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // Campo de Correo
                CampoTexto(
                  controlador: _emailController,
                  hintText: 'Correo electrónico',
                  esPassword: false,
                  icono: Icons.email_outlined,
                  validador: (valor) {
                    if (valor == null || valor.isEmpty)
                      return 'El correo es obligatorio';
                    if (!valor.contains('@')) return 'Escribe un correo válido';
                    return null; // null = todo correcto
                  },
                ),
                const SizedBox(height: 16),
                // Campo de Contraseña
                CampoTexto(
                  controlador: _passwordController,
                  hintText: 'Contraseña',
                  esPassword: true,
                  icono: Icons.lock_outline,
                  validador: (valor) {
                    if (valor == null || valor.isEmpty)
                      return 'La contraseña es obligatoria';
                    if (valor.length < 6) return 'Mínimo 6 caracteres';
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                if (auth.mensajeDeError.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    auth.mensajeDeError,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                Center(
                  child: SizedBox(
                    width: 320,
                    child: Row(
                      children: [
                        BotonGlass(
                          texto: 'Iniciar Sesión ',
                          cargando: auth.estaCargando,
                          presionar: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthController>().intentarLogin(
                                _emailController.text,
                                _passwordController.text,
                              );
                            }
                            ;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
