import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_login/vistas/bienvenida.dart';
import 'package:prueba_login/vistas/register.dart';
import 'package:prueba_login/widgets/boton_glass.dart';
import 'package:prueba_login/providers/auth_provider.dart';
import 'package:prueba_login/widgets/campo_texto.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  // Creamos los "micrófonos"
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Limpiamos los micrófonos cuando ya no los usamos
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 👂 "Escuchamos" el estado del AuthController:
    //final auth = context.watch<AuthController>();
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      // 1. CAPA DE FONDO: Ocupa toda la pantalla
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.2),
            radius: 0.8,
            colors: [Color.fromARGB(255, 37, 120, 141), Color(0xFF0A0E17)],
          ),
        ),
        // 2. CAPA INTERMEDIA: Centrada y con scroll por si la ventana se achica
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 380),
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              padding: const EdgeInsets.all(28),
              // 💎 TARJETA GLASS
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Bienvenido',
                      style: TextStyle(
                        fontSize: 26.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Campo de Correo
                    CampoTexto(
                      controlador: _emailController,
                      hintText: 'Correo electrónico',
                      esPassword: false,
                      icono: Icons.email_outlined,
                      validador: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'El correo es obligatorio';
                        }
                        if (!valor.contains('@')) {
                          return 'Escribe un correo válido';
                        }
                        return null;
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
                        if (valor == null || valor.isEmpty) {
                          return 'La contraseña es obligatoria';
                        }
                        if (valor.length < 6) {
                          return 'Mínimo 6 caracteres';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    Consumer<AuthController>(
                      builder: (context, auth, child) {
                        return Column(
                          children: [
                            // Mensaje de error
                            if (auth.mensajeDeError.isNotEmpty) ...[
                              Text(
                                auth.mensajeDeError,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 102, 80, 80),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                            ],

                            Row(
                              children: [
                                BotonGlass(
                                  texto: 'Iniciar Sesión',
                                  cargando: auth.estaCargando,
                                  presionar: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final exito = await context
                                          .read<AuthController>()
                                          .intentarLogin(
                                            _emailController.text,
                                            _passwordController.text,
                                          );
                                      if (!context.mounted) return;
                                      if (exito) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Bienvenida(
                                              email: _emailController.text,
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () async {
                        //
                        context.read<AuthController>().limpiarError();
                        final registrado = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                        if(!context.mounted) return;//revisa si ya esta en el arbol de widgets de flutter
                        if(registrado == true){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cuenta creada, ahora inicia sesion')));
                        }
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white70,
                      ),
                      child: const Text('¿No tienes cuenta? Registrate'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
